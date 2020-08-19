package com.ht.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ht.service.DbService;
import com.ht.vo.CarInfoVo;
import com.ht.vo.CarVo;
import com.ht.vo.FinanceVo;
import com.ht.vo.SysSetVo;
import com.ht.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	DbService dbService;
	//Home
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
	//log in
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model) {
		String msg = "";
		HttpSession session = request.getSession();
		if (session.getAttribute("rand") == null) {
			return "login";
		}
		String loginName = request.getParameter("loginName");
		String password = request.getParameter("password");
		String randCode = request.getParameter("randCode");

		String rand = session.getAttribute("rand").toString();
		rand = rand.toUpperCase();
		randCode = randCode.toUpperCase();
		if (!rand.equals(randCode)) {
			msg = "Verification code error";
			model.addAttribute("msg", msg);
			return "login";
		}
		UserVo user = new UserVo();
		user.setUserId(loginName);
		user.setPassword(password);
		user = dbService.login(user);
		if (user == null) {
			msg = "wrong user name or password";
			model.addAttribute("msg", msg);
			return "login";
		}
		if(user.getStatus()==0){
			msg = "User has been banned";
			model.addAttribute("msg", msg);
			return "login";
		}
		session.setAttribute("userinfo", user);
		SysSetVo sysSet = dbService.getSet();
		request.getServletContext().setAttribute("sysSet", sysSet);
		return "faceCheck";
	}
	//Return to license plate recognition interface
	@RequestMapping("/faceCheck")
	public String faceCheck() throws Exception{
		
		return "faceCheck";
	}
	//registered
	@RequestMapping(value="/reg",method=RequestMethod.GET)
	public String reg() throws Exception{
		return "regUser";
	}
	//registered
	@RequestMapping(value="/reg",method=RequestMethod.POST)
	@ResponseBody
	public Map reg(UserVo user) throws Exception{
		user.setStatus(1);
		Map<String,String> map = new HashMap<String,String>();
		if(dbService.findById(user)){
			dbService.reg(user);
			map.put("code","0");
			map.put("msg", "registration success，log-in name:"+user.getUserId()+",password："+user.getPassword()+",please login again");
		}else{
			map.put("code","1");
			map.put("msg", "Login name already exists");
		}
		return map;
	}
	//Sign out
	@RequestMapping("/exit")
	public String exit(HttpServletRequest request){
		
		request.getSession().invalidate();
		return "login";
	}
	//change Password
	@RequestMapping("/updPwd")
	@ResponseBody
	public Map updPwd(UserVo user){
		dbService.pwd(user);
		Map map = new HashMap();
		map.put("msg", "Password changed successfully, please log in again！");
		return map;
	}
	//Modify status
	@RequestMapping("/updStatus")
	public String updStatus(UserVo user,ModelMap model){
		dbService.updStatus(user);
		//User Info
		List<UserVo> userList = dbService.userList();
		model.addAttribute("userList", userList);
		return "user";
	}
	//System settings
	@RequestMapping("/updSet")
	@ResponseBody
	public Map updSet(HttpServletRequest request, SysSetVo sysSet){
		dbService.updateSet(sysSet);
		request.getServletContext().setAttribute("sysSet", sysSet);
		Map map = new HashMap();
		map.put("msg", "The charging settings have been modified successfully!");
		return map;
	}
	//User profile list
	@RequestMapping("/user")
	public String user(ModelMap model) throws Exception{
		//User Info
		List<UserVo> userList = dbService.userList();
		model.addAttribute("userList", userList);
		return "user";
	}
	//change Password
	@RequestMapping("/pwd")
	public String pwd() throws Exception{
		
		return "pwd";
	}
	//System settings
	@RequestMapping("/sysSet")
	public String sysSet() throws Exception{
		
		return "sysSet";
	}
}
