$(".swiper-slide").on('click',function(){
	var id_check = $(this).attr("id");
	/* alert(id_check); */
	$.ajax({
		type: 'POST',
		url: 'typeAjax.jsp',
		dataType: 'text',
		data: {
			clickItemId:id_check
		},
		success: function(res){
			/* res = res.replace(/[\[\]\;]/gi,''); */
			$('#results *').remove();
			res = res.replace(/\;/gi,''); //[ ] 대괄호 넣어주니깐 구문 , 에러 안남. 즉, Json 형태로 맞춤 (  [{key:value}]   )
			res = res.trim(); // 공백 제어
			if(res == '[]'){
				$('#results').html("유지관리 중입니다.");
			}else {
				$('#results').empty();
				/* alert(typeof res === 'object'); // false */
				let json = JSON.parse(res); 
				/* alert(typeof json === 'object'); //true */
				let keys = Object.keys(json);
	
				/*
					json[key].UNIT_COMPANY 이렇게 값을 따로따로 출력 가능.
				*/
				
				let $temp;
			     for (let i=0; i<keys.length; i++) {
			    	let key = keys[i];
			    	/* console.log("key : " + key + ", value : " + json[key].UNIT_COMPANY); */
			    	$temp = $('#results').append('<div class="item card mb-3 bs-light"><div id="card-block" class="card-body"><div class="card-title text-white" style="margin:auto 0;line-height: 50px;">'
				    + '<a href="#"><img src="./assets/img/location.png" style="cursor: pointer;max-width:80px; width:80%; height:auto;"></a></div><div class="card-sub-block">'
				    + '<div class="card-title text-white">'+json[key].UNIT_COMPANY+'<img src="./assets/img/phone-connection.png" onclick="document.location.href=&#39;tel:'+json[key].UNIT_PHONE+'&#39;" style="float:right;cursor: pointer;max-width:25px; width:40%; height:auto;box-shadow:0 0 4px gray;"></div>'
				    + '<div id="address'+i+'" class="card-title text-white" onclick="copy3(&#39;address'+i+'&#39;)" style="cursor: pointer;padding-top:10px;">'
				    + ''+json[key].UNIT_ADDRESS+'<img src="./assets/img/contents-copy.png" style="width:20px;height:15px;"></div></div></div></div>');
			    }
			}	 
		},
		error: function(){
			alert("False");
		}
	});
	
});

$(document).ready(function() {
    new Swiper('.swiper-container', {
        loop: true,
        slidesPerView: 5,
		loopedSlides: 5,
		centeredSlides: true,
        spaceBetween: 10,
		grabCursor: true,
		touchStartPreventDefault: true,
		touchReleaseOnEdges: true
	});
});