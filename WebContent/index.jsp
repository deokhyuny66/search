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
<title>Insert title here</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="./assets/img/favicon/favicon.ico" />

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

body {
	background: linear-gradient(to left, #FF00C7 0%,#00c7ff 100%);
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


/* root color */
.bs-blue {
background:#007bff;
}
.bs-indigo {
background:#6610f2;
}

.bs-purple {
 background:#696cff;
}
.bs-pink{
background:#e83e8c;
} 
.bs-red{
background:#ff3e1d;
} 
.bs-orange {
 background:#fd7e14;
}
.bs-yellow {
 background:#ffab00;
}
.bs-green {
background:#71dd37;
}
.bs-teal {
background:#20c997;
}
.bs-cyan {
background:#03c3ec;
}
.bs-white {
background:#fff;
}
.bs-gray {
background:rgba(67, 89, 113, 0.6);
}
.bs-gray-dark {
background:rgba(67, 89, 113, 0.8);
}
.bs-gray-25 {
background:rgba(67, 89, 113, 0.025);
}
.bs-gray-50 {
background:rgba(67, 89, 113, 0.05);
}
.bs-primary {
background:#696cff;
}
.bs-secondary {
background:#8592a3;
}
.bs-success {
background:#71dd37;
}
.bs-info {
background:#03c3ec;
}
.bs-warning {
background:#ffab00;
}
.bs-danger {
background:ff3e1d;
}
.bs-light {
background:#fcfdfd;
}
.bs-dark {
background:#233446;
}

#card-block {
 	display: flex;
}
#card-block > div {
	padding: 10px;
}
#card-block .card-sub-block {
	display: inline-block;
	width:100%;
	text-align:left;
}

</style>
</head>
<body>

<!--
<ul class="menu-inner py-1">
	<li class="menu-item">
       <a href="ui-list-groups.html" class="menu-link">
         <div data-i18n="List Groups">List groups</div>
       </a>
     </li>
</ul>

  -->


<div id="container">
	<div id="logo">
		<p>Coolinic<span> Search</span></p>
	</div>
	
	<div id="continput">
		<div id="input-group">
			<input type="text" id="searchtext" class="searchInput">
			<button id="icon-src"><i class="fa fa-search" aria-hidden="true"></i></button>
		</div>
	</div>

<%-- 	<div class="row mb-5">
        <div id="results" class="col-md-6 col-lg-4">
           <% for (j=0;j<rs_dao_list.size();j++) {%>
           <div class="item card mb-3 bs-light">

	             <% for(Entry<String, String> elem : rs_dao_list.get(j).entrySet() ){%>
					 <% if(!elem.getKey().equals("id") && !elem.getKey().equals("type") && !elem.getKey().equals("phone")){ %>

		                 <div class="card-body">
		                 	<% if(elem.getKey().equals("company")){ %>
			                   	<div class="card-title text-white" style="padding-left:20px;padding-right:23px;"><h2><%= elem.getValue() %> <span style="text-aling:center;">
			                   		<img alt="" src="./assets/img/phoneImg01.png" style="width:23px;height:30px;float: right;"></span></h2></div>
			                   <%}else if(elem.getKey().equals("address")){%>
			                   	<div id="address<%=j%>" class="card-title text-white" style="padding-left:20px;padding-right:20px;" 
			                   		onclick="copy3('address<%=j%>')"><h4><img alt="" src="./assets/img/copy.png" 
			                   			style="width:20px;height:20px;"><%= elem.getValue() %></h4></div>
			                   <%}else{%>
			                   	<div class="card-title bg-primary text-white"><h4><%= elem.getValue() %></h4></div>
			                 <%}%>
		                 </div>
		                 
	               <%}%>
	             <%}%>
             </div>
             <%}%>
        </div>
	</div>  --%>
	
	<div class="row mb-5">
        <div id="results" class="col-md-6 col-lg-4">
    
        <% for (j=0;j<rs_dao_list.size();j++) {%>
           <div class="item card mb-3 bs-light">
           	
           	 
	             <div id="card-block" class="card-body"> 
	                  	<div class="card-title text-white" style="margin:auto 0;line-height: 50px;"><img src="./assets/img/logos.png" style="width:40px;height:60px;"></div>

	                  	<div class="card-sub-block">
		                  		<div class="card-title text-white"><h3><%= rs_dao_list.get(j).get("company") %></h3></div>
		                  		<div id="address" class="card-title text-white" onclick="copy3('address')"><h5><%= rs_dao_list.get(j).get("address") %>
		                  		<img src="./assets/img/copy.png" style="width:20px;height:15px;"></h5></div>
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

var element = [redBg, contInput, gInput, button, logo, results];
//������ ��ǲ �ڽ� ���� �޴´�.
var oldVal = $(".searchInput");

input.addEventListener('focus', function(){
	for (var i = 0; i < element.length; i++) {
		element[i].classList.add('focus' + i);
	}
	$("#container").css("overflow-y","scroll");
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


/* �˻� ���� ���� ���� */
$(".searchInput").on("propertychange change keyup paste input", function () {
  // ��ȭ�� �ٷιٷ� �����ϸ� ���ϰ� �ɸ� �� �־ 1�� �����̸� �ش�.
  setTimeout(function () {
    // ����� ���� �ڽ� ���� �޾ƿ´�.
    
    var currentVal = $(".searchInput").val();
    if (currentVal == oldVal) {
      return;
    }
    // Ŭ������ box�� ������ �ִ� �±׵��� �迭ȭ ��Ŵ
    var listArray = $(".item").toArray();
    
    // forEach�� ù��° ���ڰ� = �迭 �� ���� ��
    // �ι�° �� = index
    // ����° �� = ���� �迭
    listArray.forEach(function (c, i) {
      var currentList = c;
      // ���� �迭������ ���� ����
      var currentListText = c.innerText;
      // �˻� ������ �������� ���� ���
      if (currentListText.includes(currentVal) == false) {
        currentList.style.display = "none";
      }
      // �˻� ������ ������ ���
      if (currentListText.includes(currentVal)) {
        currentList.style.display = "block";
      }
      // �˻� ������ ���� ���
      if (currentVal.trim() == "") {
        currentList.style.display = "block";
      }
    });
  }, 1000);
});

var address;
function copy3(address) {
	var obj = document.getElementById(address);
	var range = document.createRange();
	range.selectNode(obj.childNodes[0]); //�ؽ�Ʈ ������ Range ��ü�� ����
	//range.setStart(obj.childNodes[0], 0); //�߰�
	//range.setEnd(obj.childNodes[0], 5); //�߰�
	var sel = window.getSelection();
	sel.removeAllRanges(); //���� �������� ����
	sel.addRange(range); //�ؽ�Ʈ ���� ����
	document.execCommand("copy"); //����
	sel.removeRange(range); //���� ���� ����
	alert("�ּҰ� ���� �Ǿ����ϴ�.");
}


</script>
</body>
</html>