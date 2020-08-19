<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
		<style type="text/css">
		label{
            position: relative;
        }
        #file1{
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
        }
        #btn{
            padding: 5px 10px;
            background: #00b0f0;
            color: #FFF;
            border: none;
            border-radius: 5px;
        }
        #text{
            color: black;
        }
		</style>
	</head>
 	<body >
		<div class="face_header">
			<div class="face_header_con"><p class="face_header_lf">Parking Management System</p><a class="face_header_rg" href="javascript:void(0);"><span class="headsp"><img src="${pageContext.request.contextPath }/images/icon-user.png" ></span>${userinfo.userName}</a></div>
		</div>
		<div class="face_con">
			<div class="face_content">
				<div class="face_con_left">
					<h1 class="face_con_tit">Please start the license plate recognition verification</p></h1>
					<div class="face_yanzhen">
						<span>
	        			<img id="userImg" src="${faceBase64}"  width="280" height="230"/>
						<p>&nbsp;&nbsp;&nbsp;&nbsp;
						
						<label for="file1">
						        <input type="button" id="btn" value="upload image"><span id="text"></span>
						        <input id="file1" name="file1" accept="image/*" type="file" value="upload image"/>
						</label>
						</p>
						</span>
						<span>
						<video id="video" style='width:100%;height:100%'></video>
						<canvas id="canvas" width="320" height="240" style="display: none;"></canvas>
						<a class="face_yanzhen_btn" id="paizhao">Start license plate recognition</a>
						</span>
					</div>
					<p class="yanzhen_con">Note: Please adjust the camera to ensure that the camera can clearly capture the license plate number</p>
					<a class="face_login_btn" href="${pageContext.request.contextPath}/car/carInfo" style="width:200px">Enter The Main Interface</a>
				</div>
			</div>
		</div>
		
		
		
		
		<script type="text/javascript">
			$("#file1").change(function () {
		        $("#text").html($("#file1").val());
		    })
			var isSuccess=false; //Determine whether the recognition is successful
	        var video=document.getElementById("video");  
	        var context=canvas.getContext("2d");  
	
			function comein(){
				location.href="${pageContext.request.contextPath}/regUserServlet?action=list";
				/*
				if(isSuccess){
					location.href="${pageContext.request.contextPath}/loginAction!exam.action";
				}else{
					alert("Please enter the platform after successful identification");
				}
				*/
			}
	
	        var errocb=function(){
	            console.log("sth srong");  
	        }
	
	
	        if(navigator.webkitGetUserMedia){
	            navigator.webkitGetUserMedia({audio: false,video: true },function(stream){  
	                //video.src=window.URL.createObjectURL(stream);
	                video.srcObject = stream;
	                video.play();  
	            },errocb);
	        }
	        else if(navigator.mediaDevices.getUserMedia) {
	        	//var constraints = { audio: true, video: { width: 1280, height: 720 } };
	        	var constraints = {audio: false,video: true };
				navigator.mediaDevices.getUserMedia(constraints).then(function(stream) {
					//var video = document.querySelector('video');
					video.srcObject = stream;
					video.onloadedmetadata = function(e) {
						video.play();
					};
				});
			}
	        else if(navigator.getUserMedia){
	            navigator.getUserMedia({audio: false,video: true },function(stream){  
	                //video.src = window.webkitURL.createObjectURL(stream);
	                video.srcObject = stream;
	                video.play();  
	            },errocb);  
	        }
	        else {
	        	alert('Your browser does not support opening the camera');
	        }
	        var viewImg = document.getElementById("userImg");
	        document.getElementById("file1").addEventListener("change", function () {
	        	if(this.files.length==0) {
	        		return;
	        	}
	        	facefile = this.files[0];
	        	if(facefile.size>1024*1024) {
	        		alert("Please control the image size within 1M");
	        		return;
	        	}
	        	$("#paizhao").html("Recognizing ...");
	        	var reader = new FileReader();
	        	reader.onload = function( evt ){
	        		viewImg.src = evt.target.result;
	        		 //Prompt information before deleting the string "data:image/png;base64,"
	        		var data = evt.target.result;
		            var ext = data.substring(data.indexOf('/')+1,data.indexOf(';'));
		           	$("#extname").val(ext);
					var len = 19+ext.length; //data:image/jpeg;base64,
		            var b64 = data.substring(len);
		            //data:image/jpeg;base64,
		            $("#faceBase64").val(b64);
		            var url="${pageContext.request.contextPath }/car/paizhao";
			       	$.ajax({
			       		url:url,
			       		data:{"imageData":b64,"extName":ext},
						async:true,
						type:"POST",
						dataType:"json",
						success: function(data){
							$("#paizhao").html(data.msg);
							alert(data.msg);
						},
			       	});
			       	
	        	}
	        	reader.readAsDataURL(facefile);
	        }, false);
	        document.getElementById("paizhao").addEventListener("click",function(){  
	        	$("#paizhao").html("Recognizing ...");
	            context.drawImage(video,0,0,320,240);
	            //
	            //Output the image as a base64 compressed string. The default is image / png
	            var data = canvas.toDataURL();    // returns "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAYAAACt..."
	            //console.log(data);
	            //var data = canvas.toDataURL('image/jpeg');  //returns "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAA..."
				viewImg.src = data;
	            //Prompt message before deleting the string "data: image / png; base64,"
	            var b64 = data.substring( 22 );
	            //var head = data.substring(0,20);
	            //var ext = head.substring(head.indexOf('/')+1,head.indexOf(';'));
	           
	            //$("#faceBase64").val(b64);
	           	//$("#extname").val(ext);
				var url="${pageContext.request.contextPath }/car/paizhao";
		       	$.ajax({
		       		url:url,
		       		data:{"imageData":b64,"extName":'png'},
					async:true,
					type:"POST",
					dataType:"json",
					success: function(data){
						$("#paizhao").html(data.msg);
						alert(data.msg);
					},
		       	});
	        });
	    </script>  
	</body>
</html>
 