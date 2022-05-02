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
	<script src="./assets/vendor/js/helpers.js"></script>
    <script src="./assets/js/config.js"></script>
    
	<!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="./assets/img/favicon/favicon.ico" />
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link rel="stylesheet" href="./assets/css/core.css" />
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
$(".searchInput").on("propertychange change keyup paste input", function () {
  setTimeout(function () {
    var currentVal = $(".searchInput").val();
    if (currentVal == oldVal) {
      return;
    }

    var listArray = $(".item").toArray();
    listArray.forEach(function (c, i) {
      var currentList = c;
      var currentListText = c.innerText;
      if (currentListText.includes(currentVal) == false) {
        currentList.style.display = "none";
      }
      if (currentListText.includes(currentVal)) {
        currentList.style.display = "block";
      }
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
	range.selectNode(obj.childNodes[0]);
	var sel = window.getSelection();
	sel.removeAllRanges();
	sel.addRange(range); 
	document.execCommand("copy");
	sel.removeRange(range);
	alert("주소가 복사 되었습니다.");
}

</script>
</body>
</html>