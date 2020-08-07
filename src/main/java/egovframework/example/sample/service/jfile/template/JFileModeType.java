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
package egovframework.example.sample.service.jfile.template;

public enum JFileModeType {

	DBMODE(DBUploadModeTemplate.class),

	FILEMODE(FileUploadModeTemplate.class);

	JFileUploadModeTemplate handler;

	private JFileModeType(Class<? extends JFileUploadModeTemplate> clazz) {
		try {
			handler = clazz.newInstance();
		} catch (IllegalAccessException ex) {
			throw new RuntimeException(ex);
		} catch (InstantiationException ex) {
			throw new RuntimeException(ex);
		}
	}

	public JFileUploadModeTemplate getHandler() {
		return this.handler;
	}
}