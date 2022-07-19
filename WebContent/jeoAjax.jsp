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
	List<JSONObject> objList = new ArrayList<JSONObject>();
	
	if(latlong == null){
		System.out.println("init");
	}else {
		dto.setLatitude(Double.parseDouble(latlongArry[0]));
		dto.setLongitude(Double.parseDouble(latlongArry[1]));
		gpsArrayCondition = revNgeocoder.call(dto.getLatitude(),dto.getLongitude());
		objList = revNgeocoder.geoLocationCulcurate(dao.selectGeolocation(gpsArrayCondition),dto.getLatitude(),dto.getLongitude());
		
	}
%>