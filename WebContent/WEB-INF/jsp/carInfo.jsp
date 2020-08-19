<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Parking Management System</title>
		<jsp:include page="/IncludeJS.jsp"></jsp:include>
		<script type="text/javascript">
			function check(){
				$("#message").text("");
				var carNo=$("#carNo").val();
				var userName = $("#userName").val();
				var mobile = $("#mobile").val();
				if(carNo==""){
					alert("Please enter the license plate number, must be unique");
					$("#carNo").focus();
					return false;
				}			
				if(userName==""){
					alert("Please enter the user name");
					$("#userName").focus();
					return false;
				}			
				if(mobile==""){
					alert("Please enter the contact information");
					$("#mobile").focus();
					return false;
				}			
				return true;	
			}
			if("${msg}"!=""){
				alert("${msg}");
			}
		</script>
	</head>
	<body class="bg_all">
		<div class="face_header">
			<div class="face_header_con">
				<p class="face_header_lf">Parking Management System</p>
				<a class="face_header_rg" href="javascript:void(0);"><span class="headsp"><img src="${pageContext.request.contextPath }/images/icon-user.png" ></span></a>
			</div>
		</div>
		<form action="${pageContext.request.contextPath }/car/carAdd" method="post" onsubmit="return check();">
		<input type="hidden" name="carInfoId" id="carInfoId" value="${carInfo.carInfoId}">
		<div class="exam_content">
			<div class="exam_con">
				<div class="person_right">
					<ul>
						<li><span>&nbsp;</span><h2>Add / modify car information</h2></li>
						<li><font color="red" id="message"></font></li>
						<li><span>number plate:</span><input type="text" name="carNo" id="carNo" class="iptxs"  value="${carInfo.carNo}"></li>
						<li><span>Owner's name:</span><input type="text" name="userName" id="userName" class="iptxs" value="${carInfo.userName}"></li>
						<li><span>Contact Information:</span><input type="text" name="mobile" id="mobile" class="iptxs" value="${carInfo.mobile}"></li>
						<li><span>Start Date:</span><input type="date" name="startDate" id="startDate" class="iptxs" value="${carInfo.startDate}"></li>
						<li><span>Deadline:</span><input type="date" name="expireDate" id="expireDate" class="iptxs" value="${carInfo.expireDate}"></li>
						<li><span>Remarks:</span><input type="text" name="remark" id="remark" class="iptxs" value="${carInfo.remark}"></li>
						<li><span>&nbsp;</span><input type="submit" class="kaoshi_btn" value="Save"></li>
					</ul>
				</div>
			</div>
		</div>
		</form>
	</body>
</html>
	