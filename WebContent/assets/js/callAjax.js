var startPos;
var latlong;

/* 항목 버튼 클릭 시 호출 */
function fNCall(param){
	
	
	//위치기반 지원 여부 확인
	if(!navigator.geolocation){
		console.log("위치기반을 지원하지 않습니다.");
	}else {
		//위치 정확도 개선 옵션
		var options = {
				  enableHighAccuracy: true,
				  timeout: 5000,
				  maximumAge: 0
		};
		
		//현재 위치 가져옴.
		var geoSuccess = function(position) {
			startPos = position;
			
			//좌표 형태의 문자열로 만들어서 넘기기 위함.
			latlong = startPos.coords.latitude + "," + startPos.coords.longitude;
		}
		function error(err) {
			  console.warn("error");
		}
		
		//현재 위경도 1회로 가져으는 함수(실시간으로 가져오는 함수 따로 있음)
		navigator.geolocation.getCurrentPosition(geoSuccess,error,options);
		
		//위경도 없는 경우 error 발생
		if(latlong == "" || latlong == null || typeof latlong == "undefined"){
			navigator.geolocation.getCurrentPosition(geoSuccess,error,options);
		}
		
		//전체 버튼이 아닐 경우, 즉, 전체 버튼인 경우에는 위경도 표시안함.
		if(param != "ALL"){
			if(latlong == "" || latlong == null || typeof latlong == "undefined"){
				console.log("init value.");
			}else {
		  	    $.ajax({
			    	type: 'POST',
			    	url: 'jeoAjax.jsp',
			    	dataType: 'text',
			    	data: {
			    		//2개의 문자열을 보냄
			    		"geolocation":latlong,
			    		"typeGubun":param
			    	},
			    	success: function(res){
			    		//alert(res);
			    		$('#results *').remove();
			    		//정규식으로 불필요한 특수문자 치환
			    		res = res.replace(/\;/gi,'');
			    		//JSON 파서로 변환
		                let json = JSON.parse(res);
		                if(json == "[]" || json == null || json == "undefined" || json == ""){
		                	$temp = $('#results').append("<div class='item card mb-3 bs-light'><div id='card-block' style='justify-content: center;justify-items: center;text-align: center;align-items: center;width:120px;height:50px;margin:0 auto;vertical-align: middle;font-size:13px;font-weight:700;'>근처 자재상이<br>조회되지 않습니다.</div></div>");
		                }else {
		                	//Object 형태로 변경하기(괄호 구분 : JSONArray[ JSONObject{ Object{} } ] )
		                	let keys = Object.keys(json);
			                
			                //json형태의 key:value 값을  value 기준으로 내림차순 정렬하기.
				    		for(var i=0;i<keys.length;i++) {
				    			let key = keys[i];
				    			json.sort(function(a,b){
				    				if(a.Meter < b.Meter) return -1;
				    				if(a.Meter > b.Meter) return 1;
				    				
				    				return 0;
				    			});
				    			
				    			//Meter 기준으로 10KM 이내만 조회
				    			if(Number(json[key].Meter < 10000)){
				    				//Meter 기준으로 1KM 이내이면  Meter로 표시, 아니면  Kilo로 표시
				    				if(Number(json[key].Meter) > 1000){
					    				$temp = $('#results').append("<div class='item card mb-3 bs-light'><div id='card-block' class='card-body'> <div class='card-title text-white' style='margin:auto 0;line-height: 50px;'>"
						    					+ "<img src='./assets/img/location.png' style='margin-bottom: 5px;cursor: pointer;max-width:80px; width:80%; height:auto;'><div class='swiper-slide' style='background-color:" + json[key].UNIT_COLOR + ";width: 50px;height: 15px;font-size: 10px;margin:0 auto;'>"+json[key].UNIT_LOGO+"</div><div class='swiper-slide-location'>"+json[key].KiloMeter+"<span style='font-size:8px;font-weight:700;'>km</span></div></div>"
						    					+ "<div class='card-sub-block'><div class='card-title text-white'>"+json[key].UNIT_COMPANY+"<img src='./assets/img/phone-connection.png' onclick=document.location.href='tel:"+json[key].UNIT_PHONE+"' style='float:right;cursor: pointer;max-width:25px; width:40%; height:auto;box-shadow:0 0 4px gray;'></div>"
						    					+ "<div id='address"+i+"' class='card-title text-white' onclick=copy3('address"+i+"') style='cursor: pointer;padding-top:10px;'>"+json[key].UNIT_ADDRESS+"</div></div></div>");
					    			}else {
					    				$temp = $('#results').append("<div class='item card mb-3 bs-light'><div id='card-block' class='card-body'> <div class='card-title text-white' style='margin:auto 0;line-height: 50px;'>"
						    					+ "<img src='./assets/img/location.png' style='margin-bottom: 5px;cursor: pointer;max-width:80px; width:80%; height:auto;'><div class='swiper-slide' style='background-color:" + json[key].UNIT_COLOR + ";width: 50px;height: 15px;font-size: 10px;margin:0 auto;'>"+json[key].UNIT_LOGO+"</div><div class='swiper-slide-location'>"+json[key].Meter+"<span style='font-size:8px;font-weight:700;'>m</span></div></div>"
						    					+ "<div class='card-sub-block'><div class='card-title text-white'>"+json[key].UNIT_COMPANY+"<img src='./assets/img/phone-connection.png' onclick=document.location.href='tel:"+json[key].UNIT_PHONE+"' style='float:right;cursor: pointer;max-width:25px; width:40%; height:auto;box-shadow:0 0 4px gray;'></div>"
						    					+ "<div id='address"+i+"' class='card-title text-white' onclick=copy3('address"+i+"') style='cursor: pointer;padding-top:10px;'>"+json[key].UNIT_ADDRESS+"</div></div></div>");	
					    			}
				    			}
				    		}
		                }
			    	},
			    	error: function(){
			    		console.log("false");
			    	}
			    });
			  }
		}
	}
}