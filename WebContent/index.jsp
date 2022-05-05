<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="action.actionDAO"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Map.Entry" %>
<%
	request.setCharacterEncoding("UTF-8"); 
	actionDAO actionDAO = new actionDAO();
	int j = 0;
	ArrayList<HashMap<String,String>> rs_dao_list = new ArrayList<HashMap<String,String>>();
	HashMap<String,String> map = new HashMap<String,String>();
	rs_dao_list = actionDAO.selectAll();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>전국 냉동기·에어컨 자재상 검색 서비스</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="./assets/vendor/js/helpers.js"></script>
    <script src="./assets/js/config.js"></script>
    
	<!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="./assets/img/favicon/logos.png" />
	<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link rel="stylesheet" href="./assets/css/core1.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

</head>
<body>
<div id="container">

	<div id="logo">
		<p>Coolinic<span> Search</span></p>
	</div>
	
	<div id="continput">
		<a class="back-to-top fas fa-angle-up"></a>
		<div id="input-group">
			<input type="text" id="searchtext" class="searchInput">
			<button id="icon-src"><i class="fas fa-search"></i></button>
		</div>
	</div>
	
	<div class="row mb-5">
		
        <div id="results" class="col-md-6 col-lg-4">
    
        <% for (j=0;j<rs_dao_list.size();j++) {%>
           <div class="item card mb-3 bs-light">
           	
	             <div id="card-block" class="card-body"> 
	                  	<div class="card-title text-white" style="margin:auto 0;line-height: 50px;">
	                  		<a href="#"><img src="./assets/img/location.png" style="cursor: pointer;max-width:80px; width:80%; height:auto;"></a></div>
	                  	<div class="card-sub-block">
		                  		<div class="card-title text-white"><%= rs_dao_list.get(j).get("UNIT_COMPANY") %>
	                  				<img src="./assets/img/phone-connection.png" onclick="document.location.href='tel:<%= rs_dao_list.get(j).get("UNIT_PHONE") %>'" 
	                  						style="float:right;cursor: pointer;max-width:25px; width:40%; height:auto;box-shadow:0 0 4px gray;"></div>
	                  						
		                  		<div id="address<%=j%>" class="card-title text-white" onclick="copy3('address<%=j%>')" style="cursor: pointer;padding-top:10px;"><%= rs_dao_list.get(j).get("UNIT_ADDRESS") %>
	                  				<img src="./assets/img/contents-copy.png" style="width:20px;height:15px;"></div>
	                  	</div>
             	 </div> 

           </div> 
	    <%}%>
	    
        </div>
	</div> 
	
	<div id="header"></div>
	
</div>      
<script language="JavaScript" src="./assets/js/core1.js" charset='utf-8'></script>
</body>
</html>