<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="action.actionDAO"%>
<%@ page import="action.actionDTO"%>
<%@ page import="action.revNgeocoder"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%
	String latlong = request.getParameter("geolocation");
	actionDAO dao = new actionDAO();
	actionDTO dto = new actionDTO();
	String[] latlongArry = latlong.split(",");
	String gpsArrayCondition = null;
	List<JSONObject> objNList = new ArrayList<JSONObject>();
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
		dto.setLatitude(Double.parseDouble(latlongArry[0]));
		dto.setLongitude(Double.parseDouble(latlongArry[1]));
		gpsArrayCondition = revNgeocoder.call(dto.getLatitude(),dto.getLongitude());
		String json = dao.selectGeolocation(gpsArrayCondition, dto.getTypeGubun());
		objNList = revNgeocoder.geoLocationCulcurate(json,dto.getLatitude(),dto.getLongitude());
	}
%>

<%= objNList %>