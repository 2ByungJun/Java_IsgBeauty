package egovframework.example.sample.service.jfile.web;

import java.io.IOException;
import java.util.ArrayList;
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
	 * 이미지 파일일 경우 미리보기를 한다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/preview.do")
	public ModelAndView preview(JFileVO fileVO) {
		System.out.println("============================");
		System.out.println("Controller-8. 이미지 미리보기 /preview.do!!!!");
		System.out.println("============================");
		JFileDetails prevFileVO = service.getAttachFile(fileVO.getFileId(), fileVO.getFileSeq());

		JFile previewFile;
		if(prevFileVO == null) {
			previewFile = new JFile(getNoImagePath());
		} else {
			previewFile = prevFileVO.isImage() ? service.getFileBySequence(fileVO.getFileId(), fileVO.getFileSeq(), fileVO.getUseSecurity()) : new JFile(getNoImagePath());
		}


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

	@RequestMapping("/jfile/imgDelete.do")
	public ModelAndView imgDelete(@ModelAttribute JFileVO fileVo, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		System.out.println("============================");
		System.out.println("Controller-9. imgDelete");
		System.out.println("============================");

		// 삭제 수행
		System.out.println("---------- 삭제 -------------------");
		service.removeAttachFile(fileVo.getFileId());

		return modelAndView;
	}

	@RequestMapping("/jfile/processUpdate.do")
	public ModelAndView processUpdate(@ModelAttribute JFileVO fileVo, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		System.out.println("============================");
		System.out.println("Controller-10. 이미지 수정");
		System.out.println("============================");

		// 삭제 수행
		System.out.println("---------- 삭제 -------------------");
		service.removeAttachFile(fileVo.getFileId());

		if (multipartResolver.isMultipart(request)) {
			final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			Collection<MultipartFile> values = multiRequest.getFileMap().values();

			// 업로드 수행
			System.out.println("---------- 업로드될 fileVo ------------------");
			System.out.println("fileVo : " + fileVo.toString());
			System.out.println("----------------------------");
			service.upload(values, fileVo);

		}

		return modelAndView;
	}

}