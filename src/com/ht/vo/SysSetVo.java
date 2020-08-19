package com.ht.vo;

import java.io.Serializable;

public class SysSetVo implements Serializable {

	private int sysSetId;
	private int mianfeiTime;//Free time (minutes)
	private int shoufeiTime;//Charge time base (minutes)
	private float shoufeiMoney;//Charge amount (charge time base)
	
	public int getSysSetId() {
		return sysSetId;
	}
	public void setSysSetId(int sysSetId) {
		this.sysSetId = sysSetId;
	}
	public int getMianfeiTime() {
		return mianfeiTime;
	}
	public void setMianfeiTime(int mianfeiTime) {
		this.mianfeiTime = mianfeiTime;
	}
	public int getShoufeiTime() {
		return shoufeiTime;
	}
	public void setShoufeiTime(int shoufeiTime) {
		this.shoufeiTime = shoufeiTime;
	}
	public float getShoufeiMoney() {
		return shoufeiMoney;
	}
	public void setShoufeiMoney(float shoufeiMoney) {
		this.shoufeiMoney = shoufeiMoney;
	}
}
