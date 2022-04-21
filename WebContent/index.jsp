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

<style>
body{
  margin: 0;
  padding: 0;
  font-family: "Montserrat";
}
.searchbox {
  width: 90%;
  margin: 10px auto;
}
.header{
  background: #ECDFBF;
  overflow: hidden;
  padding: 20px;
  text-align: center;
}
.header h1{
  text-transform: uppercase;
  color: white;
  margin: 0;
  margin-bottom: 8px;
}
#value{
  border: none;
  background: #E0D3B6;
  padding: 6px;
  font-size: 18px;
  width: 80%;
  border-radius: 6px;
  color: white;
}
#value:focus{
  outline: none;
}
.container{
  background: #FFFFF5;
  padding: 1%;
}
.item{
  margin: 3% 0px;
  display: flex;
  align-items: center;
}
.icon{
  width: 25px;
  height: 25px;
  background: #E0D3B6;
  color: white;
  font-size: 15px;
  text-align: center;
  line-height: 25px;
  border-radius: 50%;
  margin-right: 8px;
}
.name{
  font-size: 17px;
  font-weight: 470;
  color: #333;
}

</style>
</head>
<body>
   <div class="searchbox">
      <div class="header">
        <h1>Search</h1>
        <input class="searchInput" type="text" id="value" placeholder="Type to Search">
      </div>
      <div class="container">
		<% for (j=0;j<rs_dao_list.size();j++) {%>
		    <div class="item">
				<% for(Entry<String, String> elem : rs_dao_list.get(j).entrySet() ){%>
					 <% if(!elem.getKey().equals("id") && !elem.getKey().equals("type") ){ %>
		         	 	<span><%= elem.getValue() %></span>
		         	 <%}%>
				<%}%>
		    </div>
		<%}%>
	 </div>
  </div>
<script>
//원래의 인풋 박스 값을 받는다.
var oldVal = $(".searchInput");

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
</script>
</body>
</html>