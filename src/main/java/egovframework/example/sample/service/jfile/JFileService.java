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
package egovframework.example.sample.service.jfile;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.service.jfile.impl.JFileMapper;
import egovframework.example.sample.service.jfile.template.JFileUploadModeFactory;
import egovframework.example.sample.service.jfile.template.JFileUploadModeTemplate;


@Service
public class JFileService {

	@Autowired
    private JFileMapper mapper;

	public static final String DB_MODE = "db";

	/**
	 * 파일 아이디를 반환
	 * @param fileId 파일 아이디
	 * @param fileSeq 파일 시퀀스
	 * @return String 파일 아이디
	 */
	public String getFileId(String fileId, Object fileSeq) {
		return mapper.getFileId(fileId, fileSeq);
	};

	/**
	 * 첨부파일 정보를 저장한다.
	 * @param fileId 파일 아이디.
	 * @param fileName 파일 명.
	 * @param fileSize 파일 사이즈.
	 * @param maskingFileName 마스킹 파일명.
	 * @param expireDate 폐기 일자.
	 * @param limitCount 첨부파일 제한 갯수.
	 */
	public void addAttachFile(JFileDetails fileVo) {
		mapper.addAttachFile(fileVo);
	};

	/**
	 * 파일아이디로 첨부파일 정보를 조회한다.
	 * @param fileId 파일 아이디.
	 * @return List<Map<String, Object>> 첨부파일 목록 정보.
	 */
	public List<JFileDetails> getAttachFiles(String fileId){
		return mapper.getAttachFiles(fileId);
	};

	/**
	 * 파일아이디와 파일 시퀀스로 첨부 파일 정보를 조회한다.
	 * @param fileId 파일 아이디.
	 * @param fileSeq 파일 시퀀스.
	 * @return Map<String, Object> 첨부파일 정보.
	 */
	public JFileVO getAttachFile(String fileId, String fileSeq) {
		System.out.println("getAttachFile 실행");
		System.out.println("fileId : " + fileId);
		System.out.println("fileSeq : " + fileSeq);
		JFileVO jfileVO = new JFileVO();
		jfileVO.setFileId(fileId);
		jfileVO.setFileSeq(fileSeq);

		return mapper.getAttachFileToMap(jfileVO);
	};

	/**
	 * 파일 아이디로 파일 시퀀스 목록을 조회한다.
	 * @param fileId 파일아이디.
	 * @return Object[] 파일 시퀀스 목록.
	 */
	public Object[] getAttachFileSeqs(String fileId) {
		return mapper.getAttachFileSeqs(fileId);
	};

	/**
	 * 파일 아이디와 파일 시퀀스 목록으로 첨부파일 목록이 존재하는 지 여부를 조회한다.
	 * @param fileId 파일 아이디.
	 * @param fileSeqs 파일 시퀀스 목록.
	 * @return isExistingAttachFileInfo 파일목록 존재 여부.
	 */
	public boolean isExistingAttachFileInfo(String fileId, List<Object> arrayToList) {
		return mapper.isExistingAttachFileInfo(fileId, arrayToList);
	};

	/**
	 * 파일아이디로 삭제여부 컬럼을 변경한다.
	 * @param fileId 파일 아이디.
	 * @param deleteYn 삭제 여부.
	 */
	public void updateAttachFileDeleteYnByFileId(String fileId, String deleteYn) {
		mapper.updateAttachFileDeleteYnByFileId(fileId, deleteYn);
	};

	/**
	 * 파일 아이디로 파일 다운로드시 다운로드 건수를 변경한다.
	 * @param fileId 파일 아이디.
	 */
	public void updateAttachFileDownloadCount(String fileId) {
		mapper.updateAttachFileDownloadCount(fileId);
	};

	/**
	 * 파일 아이디로 파일 다운로드시 다운로드 건수를 변경한다.
	 * @param fileId 파일 아이디.
	 */
	public void updateAttachFileDownloadCount(String fileId, String fileSeq) {
		mapper.updateAttachFileDownloadCount(fileId, fileSeq);
	};

	/**
	 * 파일아이디로 삭제여부 컬럼을 변경한다.
	 * @param fileId 파일 아이디.
	 * @param deleteYn 삭제 여부.
	 */
	public void updateAttachFileDeleteYn(String fileId, Object[] fileSeqs, String yn) {
		mapper.updateAttachFileDeleteYn(fileId, fileSeqs, yn);
	};

	/**
	 * 파일 아이디와 파일 시퀀스로 다운로드한 건수를 변경한다.
	 * @param fileId 파일 아이디.
	 * @param fileSeq 파일 시퀀스.
	 */
	public void updateAttachFileDownloadCountBySequence(String fileId, String fileSeq) {
		mapper.updateAttachFileDownloadCountBySequence(fileId, fileSeq);
	};

	/**
	 * 파일아이디로 다운로드 한 건수를 변경한다.
	 * @param fileId 파일아이디.
	 */
	public void updateAttachFileDownloadCountByFileId(String fileId) {
		mapper.updateAttachFileDownloadCountByFileId(fileId);
	};

	/**
	 * 파일 아이디와 파일 시퀀스로 첨부파일 정보를 삭제한다.
	 * @param fileId 파일 아이디.
	 * @param fileSeqs 파일 시퀀스 목록.
	 */
	public void removeAttachFile(String fileId, List<Object> arrayToList) {
		mapper.removeAttachFile(fileId, arrayToList);
	};

	/**
	 * 업로드를 수행한다.
	 * @param values 멀티 파일
	 * @param fileVo 파일 정보를 담고 객체
	 */
	public void upload(Collection<MultipartFile> multipartFiles, JFileVO fileVo) {
			if(multipartFiles == null)
				return;
			for (final MultipartFile file : multipartFiles) {
				upload(file, fileVo);
	        }
	};

	private void upload(MultipartFile multipartFile, JFileVO fileVo) {
		// 파일 저장
		JFileUploadModeFactory.INSTANCE.getUploadType(fileVo.getUploadMode()).getHandler().upload(multipartFile, fileVo);
		// DB 연동
		if(JFileService.DB_MODE.equalsIgnoreCase(fileVo.getUploadMode())) {
			addAttachFile(fileVo);
		}
	}

	/**
	 * 업로드 완료 후 처리 작업을 수행한다.
	 * @param fileId 파일 아이디
	 */
	public void executeAfterUploadCompleted(String fileId) {
		mapper.executeAfterUploadCompleted(fileId);
	};

	/**
	 * 파일아이디와 파일 시퀀스 암호화 여부를 검색 조건으로 파일을 찾는다.
	 * @param fileId 파일아이디
	 * @param fileSeq 파일 시퀀스
	 * @param useSecurity 암호화 여부
	 * @return File 파일 객체
	 */
	public JFile getFileBySequence(String fileId, String fileSeq, String useSecurity) {
		JFileUploadModeTemplate upload = JFileUploadModeFactory.INSTANCE.getUploadType(JFileService.DB_MODE).getHandler();
		return upload.getJFile(getAttachFile(fileId, fileSeq), useSecurity, JProperties.getString(GlobalVariables.DEFAULT_FILE_UPLOAD_PATH_KEY));
	};


}
