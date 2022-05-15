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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import util.DatabaseUtil;
import action.actionDTO;

public class actionDAO {
	Connection conn = DatabaseUtil.getConnection();
	actionDTO actionDTO = new actionDTO();
	ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
	ArrayList<HashMap<String,String>> listOfIndex = new ArrayList<HashMap<String,String>>();
	JSONArray jsonList = new JSONArray();
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
	
}