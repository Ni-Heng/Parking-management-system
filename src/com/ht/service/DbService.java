package com.ht.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.base.PageObject;
import com.ht.mapper.CarDAO;
import com.ht.mapper.CarInfoDAO;
import com.ht.mapper.FinanceDAO;
import com.ht.mapper.SysSetDAO;
import com.ht.mapper.UserDAO;
import com.ht.vo.CarInfoVo;
import com.ht.vo.CarVo;
import com.ht.vo.FinanceVo;
import com.ht.vo.SysSetVo;
import com.ht.vo.UserVo;

//Add a service annotation to indicate that this class is a service layer, a class that operates the database
@Service
public class DbService {
	//Inject the database operation class of MyBatis
	@Resource 
	UserDAO userDAO;
	@Resource
	CarDAO carDAO;
	@Resource
	SysSetDAO sysDAO;
	@Resource
	CarInfoDAO carInfoDAO;
	@Resource
	FinanceDAO financeDAO;
	//Enter
	@Transactional
	public void carIn(CarVo car){
		carDAO.carIn(car);
	}
	//depart
	@Transactional
	public void carOut(CarVo car){
		carDAO.carOut(car);
	}
	//List
	@Transactional
	public List<CarVo> findAll(CarVo car){
		return carDAO.findAll(car);
	}
	@Transactional
	public int count(CarVo carVo,PageObject pager){
		return carDAO.count(carVo, pager);
	}
	@Transactional
	public List<CarVo> findByCarNo(CarVo carVo,PageObject pager){
		return carDAO.findByCarNo(carVo,pager);
	}
	//Find by status
	public CarVo findByStatus(CarVo car){
		return carDAO.findByStatus(car);
	}
	//registered
	@Transactional
	public void reg(UserVo user){
		userDAO.reg(user);
	}
	//change Password
	@Transactional
	public void pwd(UserVo user){
		userDAO.pwd(user);
	}
	//user list
	@Transactional
	public List<UserVo> userList(){
		return userDAO.userList();
	}
	//Modify user status
	@Transactional
	public void updStatus(UserVo user){
		userDAO.updStatus(user);
	}
	//log in
	@Transactional
	public UserVo login(UserVo user){
		return userDAO.login(user);
		
	}
	//Find by user id
	@Transactional
	public boolean findById(UserVo user){
		UserVo u = userDAO.findById(user);
		if(u==null){
			return true;
		}else{
			return false;
		}
		
	}
	//Get parameters
	@Transactional
	public SysSetVo getSet(){
		return sysDAO.getSet();
	}
	//Change parameters
	@Transactional
	public void updateSet(SysSetVo sysSet){
		sysDAO.updateSet(sysSet);
	}
	
	//New vehicle information
	@Transactional
	public void carAdd(CarInfoVo carInfo){
		carInfoDAO.carAdd(carInfo);
	}
	//New vehicle information
	@Transactional
	public List<CarInfoVo> findCar(String carNo){
		return carInfoDAO.findAll(carNo);
	}
	//New vehicle information
	@Transactional
	public void carUpdate(CarInfoVo carInfo){
		carInfoDAO.updateCarInfo(carInfo);
	}
	//Get vehicle information by id
	@Transactional
	public CarInfoVo getCarById(int carInfoId){
		return carInfoDAO.get(carInfoId);
	}
	public CarInfoVo findCarbyCarId(String carNo){
		return carInfoDAO.findCarbyCarId(carNo);
	}
	//Delete vehicle information by id
	@Transactional
	public void delCarById(int carInfoId){
		carInfoDAO.del(carInfoId);
	}
	//Charge management
	@Transactional
	public void financeAdd(FinanceVo finance){
		financeDAO.financeAdd(finance);
	}
	//Charge query
	@Transactional
	public List<FinanceVo> financeAll(String carNo){
		return financeDAO.findAll(carNo);
	}
}
