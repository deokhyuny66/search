<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" trimDirectiveWhitespaces="true" %>
<%@ page import="action.actionDAO"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Map.Entry" %>
<%
	request.setCharacterEncoding("UTF-8"); 
	int j = 0;
	actionDAO actionDAO = new actionDAO();
	ArrayList<HashMap<String,String>> rs_dao_list = new ArrayList<HashMap<String,String>>();
	HashMap<String,String> map = new HashMap<String,String>();
	rs_dao_list = actionDAO.selectAll();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1, maximum-scale=1, user-scalable=no"">
<title>전국 냉동기·에어컨 자재상 검색 서비스</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="./assets/vendor/js/helpers.js"></script>
    <script src="./assets/js/config.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.2.0/js/swiper.js"></script>
    
	<!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="./assets/img/favicon/logos.png" />
	<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link rel="stylesheet" href="./assets/css/core3.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.2.0/css/swiper.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

<style>
	@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
	
    .swiper-container {
    	position: absolute;
        width: 100%;
        height: 30px;
        top: 50px;
        padding-top: 8px;
        padding-bottom: 8px;
        
    }
    .swiper-slide {
    	cursor: pointer;
     	box-sizing: content-box;
        text-align: center;
        font-family: 'IBM Plex Sans KR', sans-serif;
		font-size: 12px;
		font-weight: 600;
        background: #fff;
        border-radius: 43px;
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex; 
        display: flex;
         -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
         -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center; 
        align-items: center;
        -webkit-transition: 0.3s;
  		transition: 0.3s;
    }
    .swiper-slide:hover {
    	z-index: 1;
  		-webkit-transform: scale(2);
  		transform: scale(1.2);
  		transition: .2s;
  		border-radius: 43px;
  		font-family: 'IBM Plex Sans KR', sans-serif;
		font-size: 12px;
		box-shadow: 0 0 6px gray; 
	}
</style>
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
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	        	<div id="prd-000" class="swiper-slide" style="background-color: #CC95C0;">전체</div>
	            <div id="prd-001" class="swiper-slide" style="background-color: #FFC837;">냉동기</div>
	            <div id="prd-002" class="swiper-slide" style="background-color: #93F9B9;">에어컨</div>
	            <div id="prd-003" class="swiper-slide" style="background-color: #F45C43;">오버홀</div>
	            <div id="prd-004" class="swiper-slide" style="background-color: #F7BB97;">인버터</div>
	            <div id="prd-005" class="swiper-slide" style="background-color: #3CD3AD;">방열도어</div>
	            <div id="prd-006" class="swiper-slide" style="background-color: #F8CDDA;">스크류</div>
	            <div id="prd-007" class="swiper-slide" style="background-color: #F09819;">히트펌프</div>
	            <!-- <div id="prd-008" class="swiper-slide" style="background-color: #CC95C0;">공조기</div> -->
	            <div id="prd-008" class="swiper-slide" style="background-color: #26D0CE;">쇼케이스</div>
	            <div id="prd-009" class="swiper-slide" style="background-color: #E1F5C4;">항온항습기</div>
	            <div id="prd-010" class="swiper-slide" style="background-color: #EDDE5D;">열교환기</div>
	            <!-- <div id="prd-013" class="swiper-slide" style="background-color: #5FC3E4;">냉장냉동</div> -->
	        </div>
	    </div>
	

       <div id="results" class="col-md-6 col-lg-4">
        <% for (j=0;j<rs_dao_list.size();j++) {%>
           <div class="item card mb-3 bs-light">
           	
	             <div id="card-block" class="card-body"> 
	                  	<div class="card-title text-white" style="margin:auto 0;line-height: 50px;">
	                  		<img src="./assets/img/location.png" style="margin-bottom: 5px;cursor: pointer;max-width:80px; width:80%; height:auto;">
	                  		<div class="swiper-slide" style="background-color: <%= rs_dao_list.get(j).get("UNIT_COLOR") %>;width: 50px;height: 15px;font-size: 10px;margin:0 auto;"><%= rs_dao_list.get(j).get("UNIT_LOGO") %></div>
	                  	</div>
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
<script language="JavaScript" src="./assets/js/typeAjax.js" charset='utf-8'></script>
<script language="JavaScript" src="./assets/js/core1.js" charset='utf-8'></script>
</body>
</html>