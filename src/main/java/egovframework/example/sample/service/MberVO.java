/*
 * Copyright 2008-2009 the original author or authors.
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
 */
package egovframework.example.sample.service;

/**
 * @Class Name : mberVO.java
 * @Description : mberVO Class
 * @Modification Information
 */
public class MberVO extends SampleDefaultVO {

	/*
	 * 2020.06.12 이병준
	 * serialVersionUID?
	 * - 직렬화에 사용되는 고유 아이디
	 * - 선언하지 않아도 JVM(Java Virtual Machine)에서 디폴트로 생성된다.
	 * - 동작에는 문제없지만 불안하기 때문에 명시적으로 선언하는 것을 권장한다.
	 * 
	 * 1L?
	 * - 5.0부터 필요한 변수이며, 속도 및 보안 문제를 해결하는 것을 목적으로 둔다.
	 * - 1L은 JVM에서 자동으로 UID를 생성하는 것으로 보인다.
	 * 참고 : https://hyeonstorage.tistory.com/253
	 */
	private static final long serialVersionUID = 1L;

	private String mberSn;
	private String eEmpId;
	private String mberNm;
	private String sexdstn;
	private String telno;
	private String brthdy;
	private String registId;
	private String registDt;
	private String updtId;
	private String updtDt;
	private String empNm;


	public String getMberSn() {
		return mberSn;
	}
	public void setMberSn(String mberSn) {
		this.mberSn = mberSn;
	}
	public String geteEmpId() {
		return eEmpId;
	}
	public void seteEmpId(String eEmpId) {
		this.eEmpId = eEmpId;
	}
	public String getMberNm() {
		return mberNm;
	}
	public void setMberNm(String mberNm) {
		this.mberNm = mberNm;
	}
	public String getSexdstn() {
		return sexdstn;
	}
	public void setSexdstn(String sexdstn) {
		this.sexdstn = sexdstn;
	}
	public String getTelno() {
		return telno;
	}
	public void setTelno(String telno) {
		this.telno = telno;
	}
	public String getBrthdy() {
		return brthdy;
	}
	public void setBrthdy(String brthdy) {
		this.brthdy = brthdy;
	}
	public String getRegistId() {
		return registId;
	}
	public void setRegistId(String registId) {
		this.registId = registId;
	}
	public String getRegistDt() {
		return registDt;
	}
	public void setRegistDt(String registDt) {
		this.registDt = registDt;
	}
	public String getUpdtId() {
		return updtId;
	}
	public void setUpdtId(String updtId) {
		this.updtId = updtId;
	}
	public String getUpdtDt() {
		return updtDt;
	}
	public void setUpdtDt(String updtDt) {
		this.updtDt = updtDt;
	}
	public String getEmpNm() {
		return empNm;
	}
	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}
	
	
}


