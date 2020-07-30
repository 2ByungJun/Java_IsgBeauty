package egovframework.example.sample.web.jfile;

import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import egovframework.example.sample.service.jfile.JFileService;
import egovframework.example.sample.service.jfile.JFileVO;
import egovframework.example.sample.service.jfile.view.JSonView;


@Controller
public class JFileController {


	@Resource(name="multipartResolver")
	private MultipartResolver multipartResolver;

	@Autowired
	private JFileService service;

	/**
	 * 파일 ID를 읽어온다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/empRegister/readFileId.do")
	public ModelAndView readFileId(JFileVO fileVO, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("[[[[[[[[[1.파일 ID 읽기]]]]]]]]]]");

		try {
			String fileId = service.getFileId(fileVO.getFileId(), request.getParameterValues("fileSeq"));
			modelAndView.addObject("fileId", fileId);
		} catch(RuntimeException e) {
			modelAndView.addObject("fileId", "errorFileId");
		}
		return modelAndView;
	}

	/**
	 * 파일 업로드 실행
	 * @param fileVo
	 * @param request
	 * @return
	 */
	@RequestMapping("/empRegister/processUpload.do")
	public ModelAndView processUpload(@ModelAttribute JFileVO fileVo, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("[[[[[[[[[2.파일 업로드 실행]]]]]]]]]]");

		if(multipartResolver.isMultipart(request)) {
			final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

			Collection<MultipartFile> values = multiRequest.getFileMap().values();

			service.upload(values, fileVo);
		}
		return modelAndView;
	}

	/**
	 * 파일업로드가 완료된 후 처리 작업을 수행한다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/empRegister/afterProcessUploadCompleted.do")
	public ModelAndView afterProcessUploadCompleted(JFileVO fileVO, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("[[[[[[[[[3.업로드 완료 후 처리 작업]]]]]]]]]]");
		try {
			service.executeAfterUploadCompleted(fileVO.getFileId());
		} catch (RuntimeException e) {

		}
		return modelAndView;
	}

	/**
	 * 파일 아이디로 첨부파일 목록을 읽어온다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/empRegister/readFiles.do")
	public ModelAndView readFiles(JFileVO fileVO) {
		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("[[[[[[[[[4. 파일 아이디로 첨부 파일 목록을 읽어옴]]]]]]]]]]");
		List<egovframework.example.sample.service.jfile.JFileDetails> fileList= service.getAttachFiles(fileVO.getFileId());
		modelAndView.addObject("fileList", fileList);
		return modelAndView;
	}



}
