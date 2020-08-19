package com.ht.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.base.PageObject;
import com.ht.service.DbService;
import com.ht.vo.CarInfoVo;
import com.ht.vo.CarVo;
import com.ht.vo.FinanceVo;
import com.ht.vo.SysSetVo;
import com.ht.vo.UserVo;
import com.lgr.car.FaceApi;
import com.lgr.car.RootResp;
import com.lgr.car.utils.Base64Util;

@Controller
@RequestMapping("/car")
public class CarController {
	@Resource
	DbService dbService;
	//Take a picture of the license plate
	@RequestMapping("/paizhao")
	@ResponseBody
	public Map<String, Object> paizhao(HttpServletRequest request,String imageData,String extName) throws Exception{
		UserVo user = (UserVo)request.getSession().getAttribute("userinfo");
		FaceApi faceApi = new FaceApi();
		RootResp resp = faceApi.getPlateOcr(imageData);
		Map<String,Object> json = new HashMap<String, Object>();
		json.put("errorCode", 1);
		json.put("msg", "License plate recognition failed");
		if(resp!=null){
			//ret=0 Indicates successful recognition
			if(resp.getRet()==0) {
				JSONObject data = (JSONObject )resp.getData();
				json.put("errorCode", 0);
				JSONArray arr = data.getJSONArray("item_list");
				System.out.println(arr);
				JSONObject item = (JSONObject)arr.get(0);
				String carNo = item.getString("itemstring");
				System.out.println("carNo="+carNo);
				String savePath = request.getSession().getServletContext().getRealPath("/attached/face/")+"/";
				String inPic = UUID.randomUUID()+"."+extName;
				savePath += inPic;
				System.out.println("savePath="+savePath);
				Base64Util.decoderBase64File(imageData, savePath);
				
				//Car information
				CarInfoVo carInfo = dbService.findCarbyCarId(carNo);

				CarVo car = new CarVo();
				car.setCardNo(carNo);
				car.setStatus(0);
				car.setUserName(user.getUserName());
				//Check unpaid parking information
				CarVo c = dbService.findByStatus(car);
				String remark= "temporary parking";
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if(carInfo==null){//temporary parking
					car.setFinanceType(2);//2temporary
					if(c==null){//enter
						car.setCarFee(0);
						car.setInPic(inPic);
						car.setInTime(sdf.format(new Date()));
						car.setRemark(remark);
						car.setStatus(0);//0No charge
						dbService.carIn(car);
						json.put("msg","Temporary car【"+carNo+"】：enter" );
					}else{//depart
						float carFee = 0;
						SysSetVo sysSet = (SysSetVo)request.getServletContext().getAttribute("sysSet");
						carFee = c.getMinutes()-sysSet.getMianfeiTime();
						if(carFee<=0){
							car.setCarFee(0);
							carFee=0;
						}else{
							carFee = (float)Math.ceil(carFee/sysSet.getShoufeiTime())*sysSet.getShoufeiMoney();
							car.setCarFee(carFee);
						}
						car.setStatus(1);//1Charged
						car.setOutPic(inPic);
						car.setOutTime(sdf.format(new Date()));
						car.setRemark(remark);
						car.setCarId(c.getCarId());
						dbService.carOut(car);
						if(carFee>0){
							//toll
							FinanceVo finance = new FinanceVo();
							finance.setCarNo(carNo);
							finance.setFinanceType(2);//Temporary car toll
							finance.setOprTime(new Date());
							finance.setUserName(user.getUserName());
							finance.setRemark("Temporary car【"+carNo+"】：depart，Please charge:"+carFee+"Pound" );
							finance.setTotalMoney(carFee);
							dbService.financeAdd(finance);
						}
						json.put("msg","Temporary car【"+carNo+"】：depart，Please charge:"+carFee+"Pound" );
					}
				}else{//VIP parking
					remark="VIP parking";
					car.setFinanceType(1);//1VIP
					if(c==null){//enter
						car.setCarFee(0);
						car.setInPic(inPic);
						car.setInTime(sdf.format(new Date()));
						car.setRemark(remark);
						car.setStatus(0);//0No charge
						dbService.carIn(car);
						json.put("msg","VIP car【"+carNo+"】：enter" );
					}else{//depart
						car.setCarFee(0);
						car.setStatus(2);//2VIP
						car.setOutPic(inPic);
						car.setOutTime(sdf.format(new Date()));
						car.setRemark(remark);
						car.setCarId(c.getCarId());
						dbService.carOut(car);
						if(carInfo.getDiffDate()>0){
							json.put("msg","VIP car【"+carNo+"】：depart，JUST"+carInfo.getDiffDate()+"Days" );
						}else{
							json.put("msg","VIP car【"+carNo+"】：depart，Please renew in time" );
						}
					}
				}
				
			}else{
				json.put("errorCode", resp.getRet());
				json.put("msg", "License plate recognition failed");
			}
		}
		return json;
	}
	//Display vehicle list interface
	@RequestMapping("/carInfo")
	public String carInfo(String carNo,ModelMap model) throws Exception{
		if(carNo==null){
			carNo="";
		}
		List<CarInfoVo> carInfoList = dbService.findCar(carNo);
		model.addAttribute("carInfoList", carInfoList);
		return "car";
	}
	//Display the new vehicle interface
	@RequestMapping(value="/carAdd",method=RequestMethod.GET)
	public String carAdd(ModelMap model) throws Exception{
		CarInfoVo carInfo = new CarInfoVo();
		model.addAttribute("carInfo",carInfo);
		return "carInfo";
	}
	//Save vehicle information
	@RequestMapping(value="/carAdd",method=RequestMethod.POST)
	public String carAdd(CarInfoVo carInfo,ModelMap model) {
		try{
			if(carInfo.getCarInfoId()==0){
				dbService.carAdd(carInfo);
			}else{
				dbService.carUpdate(carInfo);
			}
		}catch(Exception e){
			model.addAttribute("carInfo", carInfo);
			model.addAttribute("msg", "The car's information already exists");
			return "carInfo";
		}
		//Car information
		List<CarInfoVo> carInfoList = dbService.findCar("");
		model.addAttribute("carInfoList", carInfoList);
		return "car";
	}
	//Parking information query
	@RequestMapping("/stopCar")
	public String stopCar(HttpServletRequest request,CarVo carVo,ModelMap model,PageObject pager){

		//Save query conditions for use when clicking on the pagination link
		if(request.getParameter("cardNo")==null){
			carVo = (CarVo)request.getSession().getAttribute("carVo");
		}else{
			request.getSession().setAttribute("carVo", carVo);
		}
		int cnt = dbService.count(carVo, pager);
		pager.setTotalRows(cnt);
		if(pager.getCur_page()>pager.getPageCount()){
			pager.setCur_page(pager.getPageCount());
		}
		if(pager.getCur_page()<1){
			pager.setCur_page(1);
		}
		
		//Parking information
		List<CarVo> carList = dbService.findByCarNo(carVo, pager);
		model.addAttribute("carList", carList);
		model.addAttribute("pager", pager);
		model.addAttribute("carVo", carVo);
		
		return "stop";
	}
	//Parking information query
	@RequestMapping("/finance")
	public String finance(String carNo,ModelMap model){
		if(carNo==null){
			carNo="";
		}
		//Charge information
		List<FinanceVo> financeList = dbService.financeAll(carNo);
		model.addAttribute("financeList", financeList);
		return "finance";
	}
	//Get vehicle information by id
	@RequestMapping(value="/updateCar")
	public String carUpdate(int carInfoId,ModelMap model) throws Exception{
		CarInfoVo carInfo = dbService.getCarById(carInfoId);
		model.addAttribute("carInfo", carInfo);
		return "carInfo";
	}
	//Delete vehicle information by id
	@RequestMapping(value="/delCar")
	public String delCar(int carInfoId,ModelMap model) throws Exception{
		dbService.delCarById(carInfoId);
		//Car information
		List<CarInfoVo> carInfoList = dbService.findCar("");
		model.addAttribute("carInfoList", carInfoList);
		return "car";
	}
	//Payment
	@RequestMapping(value="/financeAdd",method=RequestMethod.GET)
	public String financeCar(int carInfoId,ModelMap model) {
		CarInfoVo carInfo = dbService.getCarById(carInfoId);
		model.addAttribute("carInfo", carInfo);
		return "financeAdd";
	}
	//Payment
	@RequestMapping(value="/financeAdd",method=RequestMethod.POST)
	public String financeCar(HttpServletRequest request, CarInfoVo carInfo,FinanceVo finance,ModelMap model) {
		
		
		CarInfoVo cInfo = dbService.getCarById(carInfo.getCarInfoId());
		cInfo.setExpireDate(carInfo.getExpireDate());
		dbService.carUpdate(cInfo);
		
		finance.setFinanceType(1);
		finance.setOprTime(new Date());
		UserVo user = (UserVo)request.getSession().getAttribute("userinfo");
		finance.setUserName(user.getUserName());
		finance.setRemark("VIP payment");
		dbService.financeAdd(finance);
		List<CarInfoVo> carInfoList = dbService.findCar("");
		model.addAttribute("carInfoList", carInfoList);
		return "car";
	}

}
