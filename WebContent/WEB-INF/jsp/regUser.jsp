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
				var userId=$("#userId").val();
				var userName = $("#userName").val();
				var mobile = $("#mobile").val();
				var password = $("#password").val();
				var confirmPwd = $("#confirmPwd").val();
				if(userId==""){
					alert("Please enter your login name");
					$("#userId").focus();
					return;
				}			
				if(userName==""){
					alert("please enter username");
					$("#userName").focus();
					return;
				}			
				if(mobile==""){
					alert("Please enter the phone number");
					$("#mobile").focus();
					return;
				}			
				if(password==""){
					alert("Please enter the login password");
					$("#password").focus();
					return;
				}			
				if(confirmPwd!=password){
					alert("Passwords are inconsistent");
					$("#confirmPwd").focus();
					return;
				}			
				var url="${pageContext.request.contextPath }/user/reg";
		       	$.post(
		       		url,
		       		{
		       			"userId":userId,
		       			"mobile":mobile,
		       			"userName":userName,
		       			"password":password
		       		},
					function(data){
						$("#message").text(data.msg);
						alert(data.msg);
						if(data.code=="0"){
							location.href="${pageContext.request.contextPath }/user/login";
						}
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
				<a class="face_header_rg" href="javascript:void(0);"><span class="headsp"><img src="${pageContext.request.contextPath }/images/icon-user.png" ></span></a>
			</div>
		</div>
		<div class="exam_content">
			<div class="exam_con">
				
				<div class="person_right">
					<ul>
						<li><span>&nbsp;</span><h4><font color="red"><a href="${pageContext.request.contextPath}">>>>></a></font></h4></li>
						<li><span>&nbsp;</span><h2>Add administrator information</h2></li>
						<li><font color="red" id="message"></font></li>
						<li><span>Login name:</span><input type="text" name="userId" id="userId" class="iptxs"></li>
						<li><span>username:</span><input type="text" name="userName" id="userName" class="iptxs"></li>
						<li><span>cellphone number:</span><input type="text" name="mobile" id="mobile" class="iptxs"></li>
						<li><span>login password:</span><input type="password" name="password" id="password" class="iptxs"></li>
						<li><span>confirm password:</span><input type="password" name="confirmPwd" id="confirmPwd" class="iptxs"></li>
						<li><span>&nbsp;</span><a class="kaoshi_btn" href="javascript:void(0);" onclick="check();">Save</a></li>
					</ul>
					
				</div>
			</div>
		</div>
	</body>
</html>
	