<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			//Change Password
			function check(){
				var totalMoney = $('#totalMoney').val();
				var expireDate = $('#expireDate').val();
				if(totalMoney==""){
					alert("Please enter the payment amount");
					$("#totalMoney").focus();
					return false;
				}
				if(isNaN(totalMoney)){
					alert("Incorrect payment amount");
					$("#totalMoney").focus();
					return false;
				}
				if(expireDate==""){
					alert("Please select an expiration date");
					$("#expireDate").focus();
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body class="bg_all">
		<div class="face_header">
			<div class="face_header_con">
				<p class="face_header_lf">Parking Management System</p>
				<a class="face_header_rg" href="javascript:void(0);"><span class="headsp"><img src="${pageContext.request.contextPath }/images/icon-user.png" ></span>${userinfo.userName }</a>
			</div>
		</div>
		<div class="exam_tit">
			<ul>
				<li><a href="${pageContext.request.contextPath }/car/carInfo">Car Information</a></li>
				<li><a href="${pageContext.request.contextPath }/car/stopCar">Stop Information</a></li>
				<li><a href="${pageContext.request.contextPath }/car/finance">Payment list</a></li>
				<li><a href="${pageContext.request.contextPath }/user/user">Administrator Account</a></li>
				<li><a href="${pageContext.request.contextPath }/user/pwd">Change Password</a></li>
				<li><a href="${pageContext.request.contextPath }/user/sysSet">System Settings</a></li>
				<li><a href="${pageContext.request.contextPath }/user/faceCheck">Back To Monitoring</a></li>
				<li><a href="${pageContext.request.contextPath }/user/login">Exit</a></li>
			</ul>
		</div>
		<form name="form1" action="${pageContext.request.contextPath}/car/financeAdd" method="post" onsubmit="return check()">
		<input type="hidden" name="carInfoId" id="carInfoId" value="${carInfo.carInfoId}">
		<input type="hidden" name="carNo" id="carNo" value="${carInfo.carNo}">
		<div class="exam_content">
			<div class="exam_con">
				<div class="person_right">
				<h2 class="exam_con_t">vip payment</h2>
					<ul>
						<li><span>number plate:</span>${carInfo.carNo}</li>
						<li><span>Owner's name:</span>${carInfo.userName}</li>
						<li><span>Contact Information:</span>${carInfo.mobile}</li>
						<li><span>Start Date:</span>${carInfo.startDate}</li>
						<li><span>Deadline:</span>${carInfo.expireDate}</li>
						<li><span>Payment amount:</span><input type="text" name="totalMoney" id="totalMoney" class="iptxs"></li>
						<li><span>expiry date:</span><input type="date" name="expireDate" id="expireDate" class="iptxs" value="${carInfo.expireDate}"></li>
						<li><span>&nbsp;</span><input type="submit" class="kaoshi_btn" value="Payment"></li>
					</ul>
				</div>
			</div>
		</div>
		</form>
	</body>
</html>
	