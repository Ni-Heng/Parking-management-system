package com.ht.mapper;

import java.util.List;

import com.ht.vo.UserVo;

public interface UserDAO {

	//registered
	public void reg(UserVo user);
	//change Password
	public void pwd(UserVo user);
	//log in
	public UserVo login(UserVo user);
	//Find by user id
	public UserVo findById(UserVo user);
	//user list
	public List<UserVo> userList();
	//Modify user status
	public void updStatus(UserVo user);
}
