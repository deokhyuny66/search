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
<title>Insert title here</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="./assets/img/favicon/favicon.ico" />
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

    <!-- Helpers -->
    <script src="./assets/vendor/js/helpers.js"></script>

    <script src="./assets/js/config.js"></script>

<style>
@import url(https://fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic,900,900italic);
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@700&display=swap');
body {

	-ms-overflow-style: none;
}
::-webkit-scrollbar { display: none; }

#container {
	width: 350px;
	height: 600px;
	border-radius: 0px;
	overflow: hidden;
	margin: auto;
	position: absolute;
	background: #fff;
	top:calc(50% - 300px);
	left:calc(50% - 175px);
	-ms-overflow-style: none;
}

#container::-webkit-scrollbar{ display:none; }

#header {
	background: #35394A;
	width: 100%;
	height: 100%;
	text-align: center;
	position: relative;
	z-index: 1;
	transition: 400ms ease-out;
}

#header.focus0 {
	height: 15% !important;
}

#continput {
	position: absolute;
	width: 100%;
	height: 100%;
	background: transparent;
	padding-left: 50px;
	padding-right: 50px;
	box-sizing: border-box;
	transition: 150ms cubic-bezier(0, 2.15, 0.97, 0.36);
	transition-delay: 500ms;
}

#continput.focus1 {
	padding-left: 25px !important;
	padding-right: 25px !important;
}

#input-group {
	width: 100%;
	height: 50px;
    background: #c8c8c8;
	border-radius: 3px;
	position: relative;
	z-index: 2;
	top: 320px;
	overflow: hidden;
	transition: top 350ms ease-in-out;
}

#input-group.focus2 {
	top: 70px !important;
}

#searchtext {
	width: 100%;
	height: 100%;
	border: none;
	outline: none;
	font-family: 'Roboto';
	font-weight: 100;
	font-size: 22px;
	padding: 10px;
	padding-right: 50px;
	box-sizing: border-box;
	background: #1B1B1D;
	color: #ccc;
}

#icon-src {
	position: absolute;
	top: 11px;
	right: -30px;
	border: none;
	background: transparent;
	font-size: 20px;
	cursor: pointer;
	color: #999;
	outline: none;
	transition: 150ms cubic-bezier(0.53, 0.88, 0.72, 1.26);
	transition-delay: 500ms;
}

#icon-src.focus3 {
	right: 10px !important;
	color: #999 !important;
}

#logo {
	position: absolute;
	top: 230px;
	z-index: 2;
	left: 30px;
	transition: 300ms cubic-bezier(0.96, 1.11, 0.86, 1.13);
	transition-delay: 150ms;
}

#logo.focus4 {
	top: 17px;
	transform: scale(0.6);
	transition-delay: 0ms;
}

#logo p {
	font-family: 'Roboto';
	text-transform: uppercase;
	font-weight: 900;
	color: #fff;
	font-size: 35px;
	margin: 0;
}

#logo p span {
	font-weight: 100;
	font-style: italic;
}

#results {
	position: absolute;
	left: 25px;
	top: 135px;
	width: 300px !important;
	background: transparent;
	border-radius: 3px;
	margin: 0;
	padding: 0;
	list-style-type: none;
	box-sizing:border-box;
	/* opacity: 0; */
	transition: 100ms ease-in;
}

#results li {
    background: #c8c8c8;
	padding: 5px 10px 5px 10px;
	transition: 200ms ease-in;
}

#results li:first-child {
	padding-top:10px;
	border-radius:3px 3px 0 0;
}

#results li:last-child {
	padding-bottom:10px;
	border-radius:0 0 3px 3px;
}

#results li a {
	color: #999;
	text-decoration: none;
	font-family: 'Roboto';
	font-weight: 100;
	font-size: 20px;
}

#results li a:hover {
	color: tomato;
}

#results.visible{
	opacity: 1 !important;
}

.card {
   box-shadow: 0 2px 6px 0 rgb(67 89 113 / 12%);
   border-radius: 0.7rem;
   text-align: center;
}

.mb-3 {
    margin-bottom: 1rem !important;
    padding-top: 1px;;
    padding-bottom: 1px;
}

.bs-light {
background:#fcfdfd;
}

#card-block {
 	display: flex;
}
#card-block > div {
	padding: 5px;
}
#card-block .card-sub-block {
	display: inline-block;
	width:100%;
	text-align:left;
	font-family: 'IBM Plex Sans KR', sans-serif;
	font-size:13px;
}
#card-block .card-sub-block > div:FIRST-CHILD {
	padding-top: 10px;
	font-size:20px;
	font-family: 'Nanum Gothic Coding', monospace;
    text-transform: uppercase;
}


/* Top Scroll */
.back-to-top {
  display: inline-block;
  background-color: #3fa3e3;
  width: 40px;
  height: 40px;
  text-align: center;
  border-radius: 4px;
  
  /*  특정 영역 안에서 Fixed로 엘리먼트 고정 시키기 */
  position: fixed;
  bottom:calc(50% - 280px);
  right:calc(50% - 150px);
  
  box-shadow:0 0 6px gray; 
  transition: background-color .3s, 
    opacity .5s, visibility .5s;
  opacity: 0;
  visibility: hidden;
  z-index: 1000;
}
.back-to-top::after {
  content: "\f077";
  font-family: FontAwesome;
  font-weight: normal;
  font-style: normal;
  font-size: 2em;
  line-height: 40px;
  color: #fff;
}
.back-to-top.show {
  opacity: 1;
  visibility: visible;
}

</style>

</head>
<body>
<div id="container">

	<div id="logo">
		<p>Coolinic<span> Search</span></p>
	</div>
	
	<div id="continput">
		<a class="back-to-top"></a>
		<div id="input-group">
			<input type="text" id="searchtext" class="searchInput">
			<button id="icon-src"><i class="fa fa-search" aria-hidden="true"></i></button>
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

		
<script>
var contInput = document.getElementById('continput');
var gInput = document.getElementById('input-group');
var input = document.getElementById('searchtext');
var button = document.getElementById('icon-src');
var logo = document.getElementById('logo');
var results = document.getElementById('results');
var redBg = document.getElementById('header');

/*  View Animation */
var element = [redBg, contInput, gInput, button, logo, results];
//원래의 인풋 박스 값을 받는다.
var oldVal = $(".searchInput");

input.addEventListener('focus', function(){
	$("#container").css("overflow-y","scroll");
	for (var i = 0; i < element.length; i++) {
		element[i].classList.add('focus' + i);
	}
	
	/* Top Scroll */
	$('.back-to-top').on('click',function(e){
	     e.preventDefault();
	     $('#container').animate({scrollTop:0},600);
	});
	$("#container").scroll(function() {
		if ($("#container").scrollTop() > 100) {
	      $('.back-to-top').addClass('show');
	    } else {
	      $('.back-to-top').removeClass('show');
	    }
	});
	
}, false);

input.addEventListener('keyup', function(){
	if (results.childNodes.length === 0) {
		results.classList.remove('visible');
	} else {
	results.classList.add('visible');
	}
},false);

/* jquery for autocomplete*/
jQuery(document).ready(function($) {
  $("#searchtext").keyup(function() {
    getAutoCompleteValues($("#searchtext").val());
  });
});

function getAutoCompleteValues(val) {
  $.ajax({
    dataType: "jsonp",
    jsonp: "cb",
    cache: 'false',
    // jsonpCallback: "callback",
    url: "http://autocomplete.wunderground.com/aq?query=" + val + "&format=json",
    // cache: false,
    success: function(data) {
      if (val == "") {
	      $("#results").html('');
	      $("#results").removeClass('result');
      }else{
	      $("#results").html('');
	      $("#results").addClass('result');
	      
		  for (var i = 0; i < 8; i++) {
	      	var city = data.RESULTS[i]['name'];
	      	$("#results").append('<li><a href="#">'+city+'</a></li>'); 
	      }
	  }
    }
  });
}

/* Filter Search  */
/* 검색 내용 변경 감지 */
$(".searchInput").on("propertychange change keyup paste input", function () {
  // 변화에 바로바로 반응하면 부하가 걸릴 수 있어서 1초 딜레이를 준다.
  setTimeout(function () {
    // 변경된 현재 박스 값을 받아온다.
    
    var currentVal = $(".searchInput").val();
    if (currentVal == oldVal) {
      return;
    }
    // 클래스로 box를 가지고 있는 태그들을 배열화 시킴
    var listArray = $(".item").toArray();
    
    // forEach의 첫번째 인자값 = 배열 내 현재 값
    // 두번째 값 = index
    // 세번째 값 = 현재 배열
    listArray.forEach(function (c, i) {
      var currentList = c;
      // 현재 배열값에서 내용 추출
      var currentListText = c.innerText;
      // 검색 내용을 포함하지 않을 경우
      if (currentListText.includes(currentVal) == false) {
        currentList.style.display = "none";
      }
      // 검색 내용을 포함할 경우
      if (currentListText.includes(currentVal)) {
        currentList.style.display = "block";
      }
      // 검색 내용이 없을 경우
      if (currentVal.trim() == "") {
        currentList.style.display = "block";
      }
    });
  }, 1000);
});


/*  Contents Copy */
var address;
function copy3(address) {
	var obj = document.getElementById(address);
	var range = document.createRange();
	range.selectNode(obj.childNodes[0]); //텍스트 정보를 Range 객체에 저장
	//range.setStart(obj.childNodes[0], 0); //추가
	//range.setEnd(obj.childNodes[0], 5); //추가
	var sel = window.getSelection();
	sel.removeAllRanges(); //기존 선택정보 삭제
	sel.addRange(range); //텍스트 정보 선택
	document.execCommand("copy"); //복사
	sel.removeRange(range); //선택 정보 삭제
	alert("주소가 복사 되었습니다.");
}

</script>
</body>
</html>