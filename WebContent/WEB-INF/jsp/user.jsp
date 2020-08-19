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
				<h2 class="exam_con_t">
					<a href="${pageContext.request.contextPath }/user/reg">New addition</a>
				</h2>
				<table  cellspacing="0" border="1" class="kaoshi_table">
				  <tr style="font-weight:bold" >
				    <td height="30">Login name</td>
				    <td>Username</td>
				    <td>Cellphone number</td>
				    <td>User status</td>
				    <td>Edit</td>
				  </tr>
				  <c:forEach items="${userList}" var="d">
					  <tr>
					    <td height="30">${d.userId }</td>
					    <td>${d.userName }</td>
					    <td>${d.mobile }</td>
					    <td>
					    	<c:if test="${d.status==0 }">Disable</c:if>
					    	<c:if test="${d.status==1 }">Enable</c:if>
					    </td>
					    <td>
					    <c:if test="${d.status==0 }">
					    	<a href="${pageContext.request.contextPath}/user/updStatus?status=1&userId=${d.userId}">Enable</a>
					    </c:if>
					    <c:if test="${d.status==1 }">
					    	<a href="${pageContext.request.contextPath}/user/updStatus?status=0&userId=${d.userId}">Disable</a>
					    </c:if>
					    </td>
					  </tr>
				  </c:forEach>
				</table>
			</div>
		</div>
	</body>
</html>
	