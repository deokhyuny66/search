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
	
}