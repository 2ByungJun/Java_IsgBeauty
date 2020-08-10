package egovframework.example.sample.service.jfile.web;

import java.io.IOException;
import java.util.Collection;
import java.util.Enumeration;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovBasicLogger;
import egovframework.example.sample.service.jfile.GlobalVariables;
import egovframework.example.sample.service.jfile.JFile;
import egovframework.example.sample.service.jfile.JFileDetails;
import egovframework.example.sample.service.jfile.JFileService;
import egovframework.example.sample.service.jfile.JFileVO;
import egovframework.example.sample.service.jfile.JProperties;
import egovframework.example.sample.service.jfile.session.SessionUploadChecker;
import egovframework.example.sample.service.jfile.utils.DateUtils;
import egovframework.example.sample.service.jfile.view.JSonView;
import egovframework.example.sample.service.jfile.view.JfileDownloadView;

@Controller
public class JFileController {

	private static final Logger LOGGER = LoggerFactory.getLogger(JFileController.class);

	@Resource(name = "multipartResolver")
	private MultipartResolver multipartResolver;

	@Autowired
	private JFileService service;

	private Enumeration params;

	/**
	 * 파일 업로드 실행
	 *
	 * @param fileVo
	 * @param request
	 * @return
	 */
	@RequestMapping("/jfile/processUpload.do")
	public ModelAndView processUpload(@ModelAttribute JFileVO fileVo, HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("======================");
		System.out.println("Controller-2.파일 업로드 /processUpload.do");
		System.out.println("======================");

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);

		// form 태그의 타입이 multipart/form-data 형태인지
		if (multipartResolver.isMultipart(request)) {
			// HttpServletRequest request를 MultipartHttpServletRequest 형태로 형변환
			final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

			// multiRequest
			params = multiRequest.getParameterNames();
			System.out.println("---------- multiRequest ------------------");
			while (params.hasMoreElements()) {
				String name = (String) params.nextElement();
				System.out.println(name + " : " + multiRequest.getParameter(name));
			}
			System.out.println("----------------------------");

			// values = multiRequest의 값 부분
			// size = 1
			// 한 개만 담겨 upload가 수행된다.
			Collection<MultipartFile> values = multiRequest.getFileMap().values();
			System.out.println("---------- value ------------------");
			System.out.println("value : " + values);
			System.out.println("----------------------------");

			// 업로드 수행
			System.out.println("---------- fileVo ------------------");
			System.out.println("fileVo : " + fileVo.toString());
			System.out.println("----------------------------");
			service.upload(values, fileVo);

		}

		System.out.println("업로드완료");
		return modelAndView;
	}

	/**
	 * 파일업로드가 완료된 후 처리 작업을 수행한다.
	 *
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/afterProcessUploadCompleted.do")
	public ModelAndView afterProcessUploadCompleted(JFileVO fileVO, HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("============================");
		System.out.println("Controller-3.업로드 완료 /afterProcessUploadCompleted.do");
		System.out.println("============================");

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		try {
			service.executeAfterUploadCompleted(fileVO.getFileId());
			SessionUploadChecker.unCheck(request, fileVO.getFileId());
		} catch (RuntimeException e) {
			try {
				response.sendError(GlobalVariables.Error.SYSTEM_ERROR, "");
			} catch (IOException e1) {
				EgovBasicLogger.debug("Reponse send error", e1);
			}
		}
		return modelAndView;
	}

	/**
	 * 파일 아이디로 첨부파일 목록을 읽어온다.
	 *
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/readFiles.do")
	public ModelAndView readFiles(JFileVO fileVO) {
		System.out.println("============================");
		System.out.println("Controller-4.첨부파일 읽기 /readFiles.do");
		System.out.println("============================");

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		List<JFileDetails> fileList = service.getAttachFiles(fileVO.getFileId());
		modelAndView.addObject("fileList", fileList);
		return modelAndView;
	}

	/**
	 *
	 */
	@RequestMapping("/jfile/jfiledownloadForm.do")
	public String jfiledownloadForm() {
		System.out.println("============================");
		System.out.println("Controller-b.다운로드 폼 /jfiledownloadForm.do");
		System.out.println("============================");
		return "egovframework/com/ext/jfile/jfiledownloadForm";
	}

	/**
	 * 파일 아이디로 첨부파일 목록을 읽어온다.
	 *
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/readDownloadFiles.do")
	public ModelAndView readDownloadFiles(JFileVO fileVO) {
		System.out.println("============================");
		System.out.println("Controller-5.파일 ID로 첨부파일 목록 읽기/readDownloadFiles.do");
		System.out.println("============================");
		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		modelAndView.addObject("fileList", service.getAttachFiles(fileVO.getFileId()));
		return modelAndView;
	}

	/**
	 * 이미지 파일일 경우 미리보기를 한다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/preview.do")
	public ModelAndView preview(JFileVO fileVO) {
		System.out.println("============================");
		System.out.println("Controller-8. 이미지 미리보기 /preview.do");
		System.out.println("============================");
		JFileDetails prevFileVO = null;
		prevFileVO = service.getAttachFile(fileVO.getFileId(), fileVO.getFileSeq());

		System.out.println("-------------------------");
		System.out.println("fileVO.getFileId() : " + fileVO.getFileId());
		System.out.println("fileVO.getFileSeq() : " + fileVO.getFileSeq());
		System.out.println("-------------------------");

		JFile previewFile = prevFileVO.isImage() ?
				service.getFileBySequence(fileVO.getFileId(), fileVO.getFileSeq(), fileVO.getUseSecurity()) : new JFile(getNoImagePath());
		return new ModelAndView(JfileDownloadView.NAME, JfileDownloadView.MODELNAME, previewFile);
	}

	/**
	 * 이미지 경로를 읽어온다.
	 * @return
	 */
	private String getNoImagePath() {
		System.out.println("============================");
		System.out.println("Controller-8-a. 이미지 경로확인");
		System.out.println("============================");
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		return request.getSession().getServletContext().getRealPath("/") + JProperties.getString(GlobalVariables.DEFAULT_NO_IMAGE_APP_PATH_KEY);
	}

}