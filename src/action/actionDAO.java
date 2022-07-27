package action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.*;

import org.json.simple.JSONValue;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import util.DatabaseUtil;
import action.actionDTO;

public class actionDAO {
	Connection conn = DatabaseUtil.getConnection();
	actionDTO actionDTO = new actionDTO();
	ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
	ArrayList<HashMap<String,String>> listOfIndex = new ArrayList<HashMap<String,String>>();
	List<JSONObject> jsonObj = new ArrayList<JSONObject>();
	
	public ArrayList<HashMap<String,String>> selectAll() throws SQLException {
    	try {
    		Statement stmt = conn.createStatement();
			//ResultSet rs = stmt.executeQuery("select * from TB_INTEGRATION WHERE UNIT_YN = 'Y' ORDER BY RAND()");
    		ResultSet rs = stmt.executeQuery("select * from TB_INTEGRATION ORDER BY RAND()");
    		ResultSetMetaData md = rs.getMetaData();
    		int columns = md.getColumnCount();

    		while(rs.next()) {
    			HashMap<String,String> row = new HashMap<String, String>(columns);
    			for(int i=1; i<=columns; ++i ) { //++i	
    				if(md.getColumnName(i).equals("UNIT_ID")){
    					row.put(md.getColumnName(i), String.valueOf(rs.getObject(i)));
    				}else {
    					row.put(md.getColumnName(i), (String) rs.getObject(i));
    				}
		        }
    			list.add(row);
    		}

    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return list;
    }
	
	public List<JSONObject> selectOfIndex(String paramItemsIndex) throws SQLException {
		ResultSet rs = null;
    	try {
    		Statement stmt = conn.createStatement();
    		if(paramItemsIndex.equals("prd-000")) {
    			rs = stmt.executeQuery("select * from TB_INTEGRATION ORDER BY RAND()");
    		}else if(paramItemsIndex.equals("prd-001") || paramItemsIndex.equals("prd-002")){
    			rs = stmt.executeQuery("select * from TB_INTEGRATION WHERE UNIT_PRD_TYPE='"+paramItemsIndex+"' ORDER BY RAND()");
    		}
    		
    		if(rs == null) {
    			System.out.println("is not data.");
    		}else {
    			ResultSetMetaData md = rs.getMetaData();
        		int columns = md.getColumnCount();
        		HashMap<String,String> row = new HashMap<String, String>(columns);
        		JSONObject obj = new JSONObject();
        		while(rs.next()) {   			
        			for(int i=1; i<=columns; ++i) {
    					if(md.getColumnName(i).equals("UNIT_ID")){
    						row.put(md.getColumnName(i), String.valueOf(rs.getObject(i)));
    					}else {
    						row.put(md.getColumnName(i), (String) rs.getObject(i));    	
    					}
    				}
        			obj = new JSONObject(row);
        			jsonObj.add(obj);
        		}
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return jsonObj;
    }
	
	@SuppressWarnings("unchecked")
	public String selectGeolocation(String paramItemsIndex, String paramType) throws SQLException {
		ResultSet rs = null;
		JSONObject objJson = new JSONObject();
		JSONArray jsonArry = new JSONArray();
		String json = null;
    	try {
    		Statement stmt = conn.createStatement();
    		rs = stmt.executeQuery("SELECT * FROM TB_INTEGRATION WHERE UNIT_TYPE LIKE '"+paramType+"-%' AND UNIT_ADDRESS LIKE '"+paramItemsIndex+"%' ");
    		if(rs == null) {
    			System.out.println("is not data.");
    		}else {
    			ResultSetMetaData md = rs.getMetaData();
        		int columns = md.getColumnCount();
        		HashMap<String,String> row = new HashMap<String, String>(columns);
        		while(rs.next()) {   			
        			for(int i=1; i<=columns; ++i) {
    					if(md.getColumnName(i).equals("UNIT_ID")){
    						row.put(md.getColumnName(i), String.valueOf(rs.getObject(i)));
    					}else {
    						row.put(md.getColumnName(i), (String) rs.getObject(i));    	
    					}
    					objJson = new JSONObject(row);
    				}
        			//JSONObject 값을 담아서 배열에 담기.
        			JSONObject[] objsa = new JSONObject[]{objJson};
        			for(int i=0;i<objsa.length;i++){
        				jsonArry.add(i, objsa[i]);
        			}
        			//System.out.println("jsonArry : " + jsonArry);
        			/*
        			 jsonArry : [{"UNIT_LINK":"null","UNIT_ID":"392","...
					 jsonArry : [{"UNIT_LINK":"null","UNIT_ID":"393","...
					 jsonArry : [{"UNIT_LINK":"null","UNIT_ID":"397","...
					 jsonArry : [{"UNIT_LINK":"null","UNIT_ID":"398","...
					 jsonArry : [{"UNIT_LINK":"null","UNIT_ID":"399","...
        			 */
        		}
    		}
    		JSONObject univ = new JSONObject();
    		univ.put("univ", jsonArry);
			//System.out.println("JSONObject univ : " + univ);
			/*
			 	JSONObject univ : {"univ":[{"UNIT_LINK":"null","UNIT_ID":"399",""},{"UNIT_LINK":"null","UNIT_ID":"398","....
			 */
	
			//문자열로 만들어서 전달한다. JSONObject로 보내려고 하니깐 연속적으로 담지 못하고, 마지막번쨰 값만 전달되는 문제가 있었음....
    		
    		json = univ.toJSONString();
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	//json String univ : {"univ":[{"UNIT_LINK":"null","UNIT_ID":"399",""},{"UNIT_LINK":"null","UNIT_ID":"398","....
    	return json;
    }
	
}