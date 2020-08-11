package egovframework.example.sample.service.jfile.impl;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.service.jfile.JFile;
import egovframework.example.sample.service.jfile.JFileDetails;
import egovframework.example.sample.service.jfile.JFileVO;

public interface JFileMapper {

	/**
	 * 파일 아이디를 반환
	 * @param fileId 파일 아이디
	 * @param fileSeq 파일 시퀀스
	 * @return String 파일 아이디
	 */
	public String getFileId(String fileId, Object fileSeq);

	/**
	 * 첨부파일 정보를 저장한다.
	 * @param fileId 파일 아이디.
	 * @param fileName 파일 명.
	 * @param fileSize 파일 사이즈.
	 * @param maskingFileName 마스킹 파일명.
	 * @param expireDate 폐기 일자.
	 * @param limitCount 첨부파일 제한 갯수.
	 */
	public void addAttachFile(JFileDetails fileVo);

	/**
	 * 파일아이디로 첨부파일 정보를 조회한다.
	 * @param fileId 파일 아이디.
	 * @return List<Map<String, Object>> 첨부파일 목록 정보.
	 */
	public List<JFileDetails> getAttachFiles(String fileId) ;

	/**
	 * 파일아이디와 파일 시퀀스로 첨부 파일 정보를 조회한다.
	 * @param fileId 파일 아이디.
	 * @param fileSeq 파일 시퀀스.
	 * @return Map<String, Object> 첨부파일 정보.
	 */
	public JFileDetails getAttachFile(String fileId, String fileSeq);

	/**
	 * 파일 아이디로 파일 시퀀스 목록을 조회한다.
	 * @param fileId 파일아이디.
	 * @return Object[] 파일 시퀀스 목록.
	 */
	public Object[] getAttachFileSeqs(String fileId);

	/**
	 * 파일 아이디와 파일 시퀀스 목록으로 첨부파일 목록이 존재하는 지 여부를 조회한다.
	 * @param fileId 파일 아이디.
	 * @param fileSeqs 파일 시퀀스 목록.
	 * @return isExistingAttachFileInfo 파일목록 존재 여부.
	 */
	public boolean isExistingAttachFileInfo(String fileId, List<Object> arrayToList);

	/**
	 * 파일아이디로 삭제여부 컬럼을 변경한다.
	 * @param fileId 파일 아이디.
	 * @param deleteYn 삭제 여부.
	 */
	public void updateAttachFileDeleteYnByFileId(String fileId, String deleteYn);

	/**
	 * 파일 아이디로 파일 다운로드시 다운로드 건수를 변경한다.
	 * @param fileId 파일 아이디.
	 */
	public void updateAttachFileDownloadCount(String fileId);

	/**
	 * 파일 아이디로 파일 다운로드시 다운로드 건수를 변경한다.
	 * @param fileId 파일 아이디.
	 */
	public void updateAttachFileDownloadCount(String fileId, String fileSeq);

	/**
	 * 파일아이디로 삭제여부 컬럼을 변경한다.
	 * @param fileId 파일 아이디.
	 * @param deleteYn 삭제 여부.
	 */
	public void updateAttachFileDeleteYn(String fileId, Object[] fileSeqs, String yn);

	/**
	 * 파일 아이디와 파일 시퀀스로 다운로드한 건수를 변경한다.
	 * @param fileId 파일 아이디.
	 * @param fileSeq 파일 시퀀스.
	 */
	public void updateAttachFileDownloadCountBySequence(String fileId, String fileSeq);

	/**
	 * 파일아이디로 다운로드 한 건수를 변경한다.
	 * @param fileId 파일아이디.
	 */
	public void updateAttachFileDownloadCountByFileId(String fileId);

	/**
	 * 파일 아이디와 파일 시퀀스로 첨부파일 정보를 삭제한다.
	 * @param fileId 파일 아이디.
	 * @param fileSeqs 파일 시퀀스 목록.
	 */
	public void removeAttachFile(String fileId, List<Object> arrayToList);

	/**
	 * 업로드를 수행한다.
	 * @param values 멀티 파일
	 * @param fileVo 파일 정보를 담고 객체
	 */
	public void upload(Collection<MultipartFile> values, JFileVO fileVo);

	/**
	 * 업로드 완료 후 처리 작업을 수행한다.
	 * @param fileId 파일 아이디
	 */
	public void executeAfterUploadCompleted(String fileId);

	/**
	 * JFile 객체
	 * @param fileId 파일 아이디.
	 * @return JFile[] 암호화 정보 및 마스킹 파일명을 포함하고 있는 파일 객체.
	 */
	public JFile[] getFiles(String fileId, String useSecurity);

	/**
	 * 파일아이디와 파일 시퀀스로 첨부 파일 정보를 조회한다.
	 * @param fileId 파일 아이디.
	 * @param fileSeq 파일 시퀀스.
	 * @return JFileVO 첨부파일 정보.
	 */
	public JFileVO getAttachFileToMap(JFileVO jfileVO);

}
