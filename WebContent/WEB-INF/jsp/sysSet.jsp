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
			//Modify system settings
			function updSet(){
				var mianfeiTime = $('#mianfeiTime').val();
				var shoufeiTime = $('#shoufeiTime').val();
				var shoufeiMoney = $('#shoufeiMoney').val();
				if(mianfeiTime==""){
					alert("Please enter the length of free parking");
					$("#mianfeiTime").focus();
					return ;
				}
				
				if(shoufeiTime==""){
					alert("Please enter the charge time");
					$("#shoufeiTime").focus();
					return ;
				}
				if(shoufeiMoney==""){
					alert("Please enter the charge amount");
					$("#shoufeiMoney").focus();
					return ;
				}
				
				var url="${pageContext.request.contextPath}/user/updSet";
				$.post(
					url,
					{
						"mianfeiTime":mianfeiTime,
						"shoufeiTime":shoufeiTime,
						"shoufeiMoney":shoufeiMoney
					},
					function(data){
						alert(data.msg);
					},
					"json"
				);
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
		<div class="exam_content">
			<div class="exam_con">
				<div class="person_right">
				<h2 class="exam_con_t">System settings</h2>
					<ul>
						<li><span>Free duration (minutes):</span><input type="text" name="mianfeiTime" id="mianfeiTime" class="iptxs" value="${sysSet.mianfeiTime}"></li>
						<li><span>Charge basis (minutes):</span><input type="text" name="newPassword" id="shoufeiTime" class="iptxs" value="${sysSet.shoufeiTime}"></li>
						<li><span>Charge amount (base):</span><input type="text" name="shoufeiMoney" id="shoufeiMoney" class="iptxs" value="${sysSet.shoufeiMoney}"></li>
						<li><span>&nbsp;</span><a class="kaoshi_btn" href="javascript:void(0);" onclick="updSet();">Modify settings</a></li>
					</ul>
				</div>
			</div>			
		</div>
	</body>
</html>
	