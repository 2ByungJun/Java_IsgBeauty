package egovframework.example.sample.service.resve;


/**
 * ResveVO
 * @author 이병준
 *
 */
public class ChartVO {

	private String year;
	private String month;
	private String day;
	private String index;
	private int cnt=0;
	private String sexdstn;
	private String tretmentNm;
	private String dateType="y";


	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String resveDt) {
		this.month = resveDt;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getSexdstn() {
		return sexdstn;
	}
	public void setSexdstn(String sexdstn) {
		this.sexdstn = sexdstn;
	}
	public String getTretmentNm() {
		return tretmentNm;
	}
	public void setTretmentNm(String tretmentNm) {
		this.tretmentNm = tretmentNm;
	}
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getIndex() {
		return index;
	}
	public void setIndex(String index) {
		this.index = index;
	}
}


