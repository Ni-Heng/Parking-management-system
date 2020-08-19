package com.ht.vo;

import java.io.Serializable;
import java.util.Date;

public class CarVo implements Serializable{

	private long carId;
	private String cardNo;
	private String inTime;
	private String outTime;
	private String inPic;
	private String outPic;
	private float carFee;
	private int status;
	private String userName;
	private String remark;
	private int financeType;
	private int minutes;
	public int getMinutes() {
		return minutes;
	}
	public void setMinutes(int minutes) {
		this.minutes = minutes;
	}
	public int getFinanceType() {
		return financeType;
	}
	public void setFinanceType(int financeType) {
		this.financeType = financeType;
	}
	public long getCarId() {
		return carId;
	}
	public void setCarId(long carId) {
		this.carId = carId;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getInTime() {
		return inTime;
	}
	public void setInTime(String inTime) {
		this.inTime = inTime;
	}
	public String getOutTime() {
		return outTime;
	}
	public void setOutTime(String outTime) {
		this.outTime = outTime;
	}
	public String getInPic() {
		return inPic;
	}
	public void setInPic(String inPic) {
		this.inPic = inPic;
	}
	public String getOutPic() {
		return outPic;
	}
	public void setOutPic(String outPic) {
		this.outPic = outPic;
	}
	public float getCarFee() {
		return carFee;
	}
	public void setCarFee(float carFee) {
		this.carFee = carFee;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
