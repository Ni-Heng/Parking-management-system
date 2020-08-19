package com.ht.mapper;

import com.ht.vo.SysSetVo;

public interface SysSetDAO {

	//Get parameters
	public SysSetVo getSet();
	//Change parameters
	public void updateSet(SysSetVo sysSet);
		
}
