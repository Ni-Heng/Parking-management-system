package com.ht.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.base.PageObject;
import com.ht.vo.CarVo;

public interface CarDAO {

	//enter
	public void carIn(CarVo car);
	//depart
	public void carOut(CarVo car);
	//Query list
	public List<CarVo> findAll(CarVo car);

	public int count(@Param("car") CarVo car,@Param("pager") PageObject pager);
	
	public List<CarVo> findByCarNo(@Param("car") CarVo car,@Param("pager") PageObject pager);

	public CarVo findByStatus(CarVo car);
		
}
