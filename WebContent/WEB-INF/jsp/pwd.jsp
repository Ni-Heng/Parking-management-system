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
			function updPwd(userid){
				var oldpwd = $('#oldPassword').val();
				var newpwd = $('#newPassword').val();
				var cfgpwd = $('#confirmPwd').val();
				if(oldpwd==""){
					alert("Please enter the old password");
					$("#oldPassword").focus();
					return ;
				}
				if("${userinfo.password}"!=oldpwd){
					alert("The old password is inconsistent with the original password");
					$("#oldPassword").focus();
					return ;
				}
				if(newpwd==""){
					alert("Please enter a new password");
					$("#newPassword").focus();
					return ;
				}
				if(newpwd !=cfgpwd){
					alert("New password and confirmation password are inconsistent");
					$("#confirmPwd").focus();
					return;
				}
				var url="${pageContext.request.contextPath}/user/updPwd";
				$.post(
					url,
					{
						"userId":"${userinfo.userId}",
						"password":newpwd
					},
					function(data){
						alert(data.msg);
						location.href="${pageContext.request.contextPath}/user/login";
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
				<h2 class="exam_con_t">Change Password</h2>
					<ul>
						<li><span>Username:</span>${userinfo.userName}</li>
						<li><span>Login name:</span>${userinfo.userId}</li>
						<li><span>Cellphone number:</span>${userinfo.mobile}</li>
						<li><span>Old password:</span><input type="password" name="oldPassword" id="oldPassword" class="iptxs"></li>
						<li><span>New password:</span><input type="password" name="newPassword" id="newPassword" class="iptxs"></li>
						<li><span>Confirm new password:</span><input type="password" name="confirmPwd" id="confirmPwd" class="iptxs"></li>
						<li><span>&nbsp;</span><a class="kaoshi_btn" href="javascript:void(0);" onclick="updPwd('${userinfo.userId}');">Change Password</a></li>
					</ul>
					
				</div>
			</div>
		</div>
	</body>
</html>
	