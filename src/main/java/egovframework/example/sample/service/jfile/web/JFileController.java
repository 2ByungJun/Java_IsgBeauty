/*
 * eGovFrame JFile
 * Copyright The eGovFrame Open Community (http://open.egovframe.go.kr)).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @author 정호열 커미터(표준프레임워크 오픈커뮤니티 리더)
 */
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

	@Resource(name="multipartResolver")
	private MultipartResolver multipartResolver;

	@Autowired
	private JFileService service;

	@RequestMapping("/jfile/jfileuploadForm.do")
	public String jfileuploadForm() {
		System.out.println("============================");
		System.out.println("Controller-a.업로드 폼 /jfileuploadForm.do");
		System.out.println("============================");
		return "egovframework/com/ext/jfile/jfileuploadForm";
	}

	private Enumeration params;

	/**
	 * 파일 ID를 읽어온다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/readFileId.do")
	public ModelAndView readFileId(JFileVO fileVO, HttpServletRequest request, HttpServletResponse response) {

		System.out.println("======================");
		System.out.println("Controller-1.파일 읽기 /readFileId.do ");
		System.out.println("======================");

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);

		try {
			// request
			params = request.getParameterNames();
			System.out.println("---------- request ------------------");
			while (params.hasMoreElements()){
				 String name = (String)params.nextElement();
				 System.out.println(name + " : " + request.getParameter(name));
			}
			System.out.println("----------------------------");


			String fileId = service.getFileId(fileVO.getFileId(), request.getParameterValues("fileSeq"));// "" , null
			System.out.println("FileId(service후)" + fileId);

			modelAndView.addObject("fileId", fileId);
			SessionUploadChecker.check(request, fileId);
		} catch(RuntimeException e) {
			modelAndView.addObject("fileId", "errorFileId");
//			try {
//				response.sendError(GlovalVariables.Error.SYSTEM_ERROR, "");
//			} catch (IOException e1) {
//				e1.printStackTrace();
//			}
		}
		return modelAndView;
	}

	@RequestMapping("/jfile/uploadingCheck.do")
	public ModelAndView uploadingCheck(@ModelAttribute JFileVO fileVO, HttpServletRequest request) {
		System.out.println("======================");
		System.out.println("Controller-1-a.업로드 체크 /uploadingCheck.do ");
		System.out.println("======================");
		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		modelAndView.addObject("hasFileId", SessionUploadChecker.isContainsKey(request, fileVO.getFileId()));
		modelAndView.addObject("maxInactiveInterval", request.getSession().getMaxInactiveInterval());
		LOGGER.debug("\nlastAccessTime : " + DateUtils.getDateString(request.getSession().getLastAccessedTime(), "yyyy.MM.dd HH:mm:ss"));
		return modelAndView;
	}

	/**
	 * 파일 업로드 실행
	 * @param fileVo
	 * @param request
	 * @return
	 */
	@RequestMapping("/jfile/processUpload.do")
	public ModelAndView processUpload(@ModelAttribute JFileVO fileVo, HttpServletRequest request, HttpServletResponse response) {
		System.out.println("======================");
		System.out.println("Controller-2.파일 업로드 /processUpload.do");
		System.out.println("======================");

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);

		// form 태그의 타입이 multipart/form-data 형태인지
		if(multipartResolver.isMultipart(request)) {
			// HttpServletRequest request를    MultipartHttpServletRequest 형태로 형변환
			final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

			// multiRequest
			params = multiRequest.getParameterNames();
			System.out.println("---------- multiRequest ------------------");
			while (params.hasMoreElements()){
			    String name = (String)params.nextElement();
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

			// 글자 수 체크
			boolean exceedFileNameLength = isExceedFileNameLength(values);
			if (exceedFileNameLength) {
				try {
					response.sendError(GlobalVariables.Error.FILE_LENGTH_ERROR, "");
				} catch (IOException e) {
					EgovBasicLogger.debug("Reponse send error", e);
				}
			} else {
				try {
					// 업로드 수행
					System.out.println("---------- fileVo ------------------");
					System.out.println("fileVo : " + fileVo.toString());
					System.out.println("----------------------------");
					service.upload(values, fileVo);
				} finally {
					SessionUploadChecker.unCheck(request, fileVo.getFileId());
				}
			}

		}
		return modelAndView;
	}

	private boolean isExceedFileNameLength(Collection<MultipartFile> values) {

		if(values != null) {
			for(MultipartFile mfile : values) {
				if(mfile.getOriginalFilename().length() > 99) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * 파일업로드가 완료된 후 처리 작업을 수행한다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/afterProcessUploadCompleted.do")
	public ModelAndView afterProcessUploadCompleted(JFileVO fileVO, HttpServletRequest request, HttpServletResponse response) {
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
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/readFiles.do")
	public ModelAndView readFiles(JFileVO fileVO) {
		System.out.println("============================");
		System.out.println("Controller-4.첨부파일 읽기 /readFiles.do");
		System.out.println("============================");

		ModelAndView modelAndView = new ModelAndView(JSonView.NAME);
		List<JFileDetails> fileList= service.getAttachFiles(fileVO.getFileId());
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
	 * 파일을 다운로드 받는다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/readDownloadFile.do")
	public ModelAndView readDownloadFile(JFileVO fileVO) {
		System.out.println("============================");
		System.out.println("Controller-6.파일 다운로드 /readDownloadFile.do");
		System.out.println("============================");
		JFile downloadFile = service.getFile(fileVO.getFileId(), fileVO.getFileSeq(), fileVO.getUseSecurity());
		// 다운로드 카운트를 증가 시킨다.
		service.updateAttachFileDownloadCountBySequence(fileVO.getFileId(), fileVO.getFileSeq());
        return new ModelAndView(JfileDownloadView.NAME, JfileDownloadView.MODELNAME, downloadFile);
	}

	/**
	 * 멀티 업로드된 모든 파일을 zip로 압축하여 다운로드 받는다.
	 * @param fileVO
	 * @return
	 */
	@RequestMapping("/jfile/downloadAll.do")
	public ModelAndView downloadAll(JFileVO fileVO) {
		System.out.println("============================");
		System.out.println("Controller-7. zip파일 다운로드 /downloadAll.do");
		System.out.println("============================");
		JFile[] downloadZipFile = service.getFiles(fileVO.getFileId(), fileVO.getUseSecurity());
		service.updateAttachFileDownloadCountByFileId(fileVO.getFileId());
		return new ModelAndView(JfileDownloadView.NAME, JfileDownloadView.MODELNAME, downloadZipFile);
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