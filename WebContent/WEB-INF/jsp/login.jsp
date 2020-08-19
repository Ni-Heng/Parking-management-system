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
    	var isSuccess=false;
		function toLogin(){
			var code = $("#loginName").val();
			var pwd = $("#password").val();
			var randCode = $("#randCode").val();
			if(code==""||pwd==""||randCode=="") {
				alert("Please fill in the complete username, password and verification code");
				return false;
			}
			$("#loginForm").submit();
			return true;
		}
		function refresh(){
			document.getElementById("codes").src= '${pageContext.request.contextPath }/enimg.jsp?'+Math.random();
		}
		if("${msg}"!=null&&"${msg}".length>0){
			alert("${msg}");
		}
	</script>
  </head>
<body>
<div class="login_b">
	<div class="header"><!--<div class="header_logo"><img src="images/logo.png" width="140" height="47"></div> -->
	<p class="header_con">Parking Management System</p>
</div>
<div class="lgn_bx">
	<div class="login_con">
		<div class="lgn_con">
			<div class="login_con_bx">
				<div class="login_tit">User login</div>
					<div class="login_con_bx_t"><span>Account login</span></div>
					<div>
						<ul class="login_con_bx_bl">
				  			<form action="${pageContext.request.contextPath}/user/login" id="loginForm" method="post">
								<li style="cursor: hand">
									<span style="cursor: hand"><img src="${pageContext.request.contextPath}/images/login_icon02.png" /></span>
									<div class="lgtel">
										<input type="text" name="loginName" id="loginName" placeholder="account number" class="telbt" onfocus="clearvalue(this);"/>
									</div>
								</li>
								<li>
									<span ><img src="${pageContext.request.contextPath}/images/login_icon01.png" /></span>
									<div class="lgtel">
										<input type="password" name="password" id="password" placeholder="password" class="telbt" onfocus="clearvalue(this);"/>
									</div>
								</li>
								<li style="border:none">
									<div class="lgtel" style="width:50%;border:1px solid #B7B7B7;">
					  					<input type="text" name="randCode" id="randCode" placeholder="confirmation code" class="telbt" onfocus="clearvalue(this);" style="width:120px;">
					  				</div>
					  				<div class="rzm_btn">
					  					<img src="${pageContext.request.contextPath }/enimg.jsp" width="70" height="42" id="codes" align="top" alt="Click to change"  onclick="refresh();">
					  				</div>
								</li>	      
					            <li  style="border:none; background:none">
							    	<a class="login_btn" href="javascript:void(0);" onclick="toLogin();">log in</a>
								</li>
				              	<p class="help_con"><!--<a class="sp1">Login help</a> --><a class="sp2" href="${pageContext.request.contextPath}/user/reg">User registration</a></p>
				              	<p>&nbsp;</p>
							</form>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
