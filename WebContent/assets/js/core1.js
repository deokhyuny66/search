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
    url: "http://autocomplete.wunderground.com/aq?query=" + encodeURI(val) + "&format=json",
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