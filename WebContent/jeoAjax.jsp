<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="action.actionDAO"%>
<%@ page import="action.actionDTO"%>
<%@ page import="action.revNgeocoder"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%
	//ajax 전달 값 받음.
	String latlong = request.getParameter("geolocation");

	actionDAO dao = new actionDAO();
	actionDTO dto = new actionDTO();
	String[] latlongArry = latlong.split(",");
	String gpsArrayCondition = null;
	List<JSONObject> objNList = new ArrayList<JSONObject>();
	
	//항목별에 따라 구분자 추가
	if(latlongArry[2].equals("#prd-000")){
		dto.setTypeGubun("ALL");
	}else if(latlongArry[2].equals("#prd-001")){
		dto.setTypeGubun("FC");
	}else if(latlongArry[2].equals("#prd-002")){
		dto.setTypeGubun("AC");
	}
	
	if(latlong == null){
		System.out.println("init");
	}else {
		//dto에 각 좌표 저장
		dto.setLatitude(Double.parseDouble(latlongArry[0]));
		dto.setLongitude(Double.parseDouble(latlongArry[1]));
		
		//현재 위경도 기준으로 거리 계산하고 현재 위치의 주소 반환
		gpsArrayCondition = revNgeocoder.call(dto.getLatitude(),dto.getLongitude());
		
		//주소 및 구분자로 해당하는 업체 list DB 조회해서 Json 문자열 형태로 가져옴.
		String json = dao.selectGeolocation(gpsArrayCondition, dto.getTypeGubun());
		
		//조건에 맞는 업체의 위경도를 전달하고 거리를 계산하여 리스트로 반환.
		objNList = revNgeocoder.geoLocationCulcurate(json,dto.getLatitude(),dto.getLongitude());
	}
%>

<%= objNList %>