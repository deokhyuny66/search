$('.content-wrapper #pagination-div').twbsPagination({
		    totalPages: 35,	// 총 페이지 번호 수
		    visiblePages: 7,	// 하단에서 한번에 보여지는 페이지 번호 수
		    startPage : 1, // 시작시 표시되는 현재 페이지
		    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
		    first : "첫 페이지",	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		    prev : "이전 페이지",	// 이전 페이지 버튼에 쓰여있는 텍스트
		    next : "다음 페이지",	// 다음 페이지 버튼에 쓰여있는 텍스트
		    last : "마지막 페이지",	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		    nextClass : "page-item next",	// 이전 페이지 CSS class
		    prevClass : "page-item prev",	// 다음 페이지 CSS class
		    lastClass : "page-item last",	// 마지막 페이지 CSS calss
		    firstClass : "page-item first",	// 첫 페이지 CSS class
		    pageClass : "page-item",	// 페이지 버튼의 CSS class
		    activeClass : "active",	// 클릭된 페이지 버튼의 CSS class
		    disabledClass : "disabled",	// 클릭 안된 페이지 버튼의 CSS class
		    anchorClass : "page-link",	//버튼 안의 앵커에 대한 CSS class
		    
		    onPageClick: function (event, page) {
		    	//클릭 이벤트
				console.log("클릭");
		    }
});

$(".content-wrapper #pagination-div").twbsPagination('enable');

//전체 페이지 개수
$(".content-wrapper #pagination-div").twbsPagination("getTotalPages");

// 현재 선택된 페이지 번호
$(".content-wrapper #pagination-div").twbsPagination("getCurrentPage");


// 페이지 네이션 총 페이지 숫자 변경
// 이 함수가 호출 되면 변경되고 난 후 선택될 페이지 번호에 대한 클릭이벤트가 발생이 되는 점에 유의
//$(".content-wrapper #pagination-div").twbsPagination("changeTotalPages", 총 페이지, 변경되고 난 후 선택될 페이지 번호);