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
				<li><a href="${pageContext.request.contextPath }/car/stopCar?cardNo=&cur_page=1">Parking Information</a></li>
				<li><a href="${pageContext.request.contextPath }/car/finance">Payment list</a></li>
				<li><a href="${pageContext.request.contextPath }/user/user">Administrator Account</a></li>
				<li><a href="${pageContext.request.contextPath }/user/pwd">Change The Password</a></li>
				<li><a href="${pageContext.request.contextPath }/user/sysSet">System Settings</a></li>
				<li><a href="${pageContext.request.contextPath }/user/faceCheck">Back To Monitoring</a></li>
				<li><a href="${pageContext.request.contextPath }/user/login">Exit</a></li>
			</ul>
		</div>
		<div class="exam_content">
			<div class="exam_con">
				<form name="form1" action="${pageContext.request.contextPath }/car/carInfo" method="post">
				<h2 class="exam_con_t">
					<a href="${pageContext.request.contextPath }/car/carAdd">New addition</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" name="carNo" id="carNo" style="height:30px;width:180px"/>
					<input type="submit"  value=" Check  "  style="height:30px;width:80px">
				</h2>
				</form>
				<table  cellspacing="0" border="1" class="kaoshi_table">
				  <tr style="font-weight:bold" >
				    <td height="30">Number Plate</td>
				    <td>Owner's name</td>
				    <td>Contact Information</td>
				    <td>Start Date</td>
				    <td>Deadline</td>
				    <td>Remarks</td>
				    <td>Edit</td>
				  </tr>
				  <c:forEach items="${carInfoList}" var="d">
					  <tr>
					    <td height="30">${d.carNo }</td>
					    <td>${d.userName }</td>
					    <td>${d.mobile }</td>
					    <td>${d.startDate}</td>
					    <td>${d.expireDate}</td>
					    <td>${d.remark }</td>
					    <td>
					    	<a href="${pageContext.request.contextPath}/car/financeAdd?carInfoId=${d.carInfoId}">Payment</a>&nbsp;&nbsp;
					    	<a href="${pageContext.request.contextPath}/car/updateCar?carInfoId=${d.carInfoId}">Modify</a>&nbsp;&nbsp;
					    	<a href="${pageContext.request.contextPath}/car/delCar?carInfoId=${d.carInfoId}" onclick="return confirm('Delete Confirmation')">Delete</a>
					    </td>
					  </tr>
				  </c:forEach>
				</table>
			</div>
		</div>
	</body>
</html>
	