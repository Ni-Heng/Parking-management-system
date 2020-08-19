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
				<form name="form1" action="${pageContext.request.contextPath }/car/stopCar" method="post">
				<h2 class="exam_con_t">
					<a href="javascript:void(0)">Parking information</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="date" name="inTime" id="inTime" style="height:30px;width:120px" value="${carVo.inTime}"/>
					<input type="date" name="outTime" id="outTime" style="height:30px;width:120px" value="${carVo.outTime}"/>
					<input type="text" name="cardNo" id="cardNo" style="height:30px;width:200px" value="${carVo.cardNo}"/>
					<input type="submit"  value=" Check  "  style="height:30px;width:100px">
				</h2>
				</form>
				<table  cellspacing="0" border="1" class="kaoshi_table">
					<tr height="30">
						<td><a href="${pageContext.request.contextPath}/car/stopCar?cur_page=1">Home</a></td>
						<td><a href="${pageContext.request.contextPath}/car/stopCar?cur_page=${pager.cur_page-1}">previous page</a></td>
						<td><a href="${pageContext.request.contextPath}/car/stopCar?cur_page=${pager.cur_page+1}">Next page</a></td>
						<td><a href="${pageContext.request.contextPath}/car/stopCar?cur_page=${pager.pageCount}">last page</a></td>
						<td>Present ${pager.cur_page}/Total ${pager.pageCount} page</td>
						<td>Total records${pager.totalRows}</td>
					</tr>
				</table>
				<table  cellspacing="0" border="1" class="kaoshi_table">
				  <tr style="font-weight:bold" >
				    <td height="30">number plate</td>
				    <td>Admission time</td>
				    <td>Departure time</td>
				    <td>Charge amount</td>
				    <td>Charge type</td>
				    <td>Car status</td>
				    <td>Toll collector</td>
				    <td>Admission pictures</td>
				    <td>Departure picture</td>
				  </tr>
				  <c:forEach items="${carList}" var="d">
					  <tr>
					    <td height="30">${d.cardNo }</td>
					    <td>${d.inTime }</td>
					    <td>${d.outTime }</td>
					    <td>${d.carFee }</td>
					    <td>
					    <c:if test="${d.financeType==1}">Vip</c:if>
					    <c:if test="${d.financeType==2}">temporary</c:if>
					    </td>
					    <td>
					    <c:if test=""></c:if>
					    <c:if test="${d.status==0}">No departure</c:if>
					    <c:if test="${d.status==1}">Departure</c:if>
					    <c:if test="${d.status==2}">Departure</c:if>
					    </td>
					    <td>${d.userName}</td>
					    <td><img src="${pageContext.request.contextPath }/attached/face/${d.inPic}" height="50px"></td>
					    <td><img src="${pageContext.request.contextPath }/attached/face/${d.outPic}" height="50px"></td>
					  </tr>
				  </c:forEach>
				</table>
			</div>
		</div>
	</body>
</html>
	