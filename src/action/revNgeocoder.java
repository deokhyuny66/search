package action;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.*;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/*import com.google.code.geocoder.Geocoder;
import com.google.code.geocoder.GeocoderRequestBuilder;
import java.io.IOException;
import java.util.Map;
import com.google.code.geocoder.model.GeocodeResponse;
import com.google.code.geocoder.model.GeocoderRequest;
import com.google.code.geocoder.model.GeocoderResult;
import com.google.code.geocoder.model.GeocoderStatus;
import com.google.code.geocoder.model.LatLng;
*/

class GpsToAddress {
	
	double latitude;
	double longitude;
	String regionAddress;

	public GpsToAddress(double latitude, double longitude) throws Exception {
		this.latitude = latitude;
		this.longitude = longitude;
		this.regionAddress = getRegionAddress(getJSONData(getApiAddress()));
	}
	
	private String getApiAddress() {
		String apiURL = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
				+ latitude + "," + longitude + "&language=ko&"+ "key=AIzaSyCi6weqlyOlMJWQcAvel4wcWAoxFaK2TSE";
		return apiURL;
	}

	private String getJSONData(String apiURL) throws Exception {
		String jsonString = new String();
		String buf;
		URL url = new URL(apiURL);
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(
				conn.getInputStream(), "UTF-8"));
		while ((buf = br.readLine()) != null) {
			jsonString += buf;
		}
		return jsonString;
	}

	private String getRegionAddress(String jsonString) {
		JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
		JSONArray jArray = (JSONArray) jObj.get("results");
		jObj = (JSONObject) jArray.get(0);
		return (String) jObj.get("formatted_address");
	}

	public String getAddress() {
		return regionAddress;
	}
}

public class revNgeocoder {
	public static String call(double latitudeParam, double longitudeParam) throws Exception{
			double latitude = latitudeParam; 
			double longitude = longitudeParam; 
			GpsToAddress gps = new GpsToAddress(latitude, longitude);
			String gpsAddr = gps.getAddress();
			String[] gpsArray = gpsAddr.split(" ");
			String gpsArrayCondition = gpsArray[1] + " " + gpsArray[2]; 
	
			return gpsArrayCondition;
	}
	
	@SuppressWarnings({ "unchecked" })
	public static List<JSONObject> geoLocationCulcurate(String objListParam,double latitudeParam, double longitudeParam) throws ParseException{
		List<JSONObject> geoLocationObjList = new ArrayList<JSONObject>();
		JSONParser parser = new JSONParser();

		//단순 String 형태이기 때문에 사용을 위해서 다시 JSONObject로 형변환 해줘야 한다.
		JSONObject univ = (JSONObject)parser.parse(objListParam);
		//System.out.println("JSONObject univ : " + univ.toJSONString());
		/*
		  JSONObject univ : {"univ":[{"UNIT_LONGITUDE":"127.122234345712","....
		 */
		
		//JSONObject 각 인덱스에 접근 해주기 위해서는 JSON배열 형태로 다시 형변환 해준다. 
		JSONArray arr = (JSONArray)univ.get("univ");
		//System.out.println("JSONArray arr : " + arr.toJSONString());
		/*
		 JSONArray arr : [{"UNIT_LONGITUDE":"127.122234345712","... 
		 */
		
		//[중요]※※※※※새로운 JSONObject에 다시 담아서 처리하기 위해 선언※※※※※※※
		//새로운곳에 담지 않고 기존에 사용했던거에 담으려고 하면 중복으로 쌓이게 되고, 문제있었음...
		JSONObject tmp = new JSONObject();
		/*
		  [참고] 
		  tmp.put()은 인덱스에 새로 값을 추가하기 위함이고
		  tmp = (JSONObject)arr.get(i)는 꺼낸 JSON배열을 JSONObject 형태로 형변환 해주는것이다.
		      =====> 이 상태가 되어야 각 인덱스에 새로 추가할수 있는 상태가 된다.
		*/
		/*
		  [목표]
		 * Object 각 인덱스를 꺼내서, DB에서 가져와서 거리 계산한 위경도의 각각의 값을 각 인덱스 별로 넣는 것이 목표다.
		 * 근데, JSON 파싱하는게 잘 안됐음......
		 */
		//꺼내기 위한 반복문 선언
		for(int i=0;i<arr.size();i++){
			//System.out.println("for arr : " + arr.get(i));
			/*
				for arr : {"UNIT_LONGITUDE":"127.122234345712","...
				for arr : {"UNIT_LONGITUDE":"127.130989691795","...
				for arr : {"UNIT_LONGITUDE":"127.122466163227","...
				for arr : {"UNIT_LONGITUDE":"127.121920707304","...
				for arr : {"UNIT_LONGITUDE":"127.128886032298","...
			 */
			
			tmp = (JSONObject)arr.get(i); //각 인덱스 번호로 접근해서 가져온다.
			//System.out.println("for tmp : " + tmp);
			/*
			 	"for arr" 결과와 똑같음.
			 	-> 이 상태 일 때야말로 각 인덱스에 접근해서 데이터를 추가할 수 있는 상태가 된거임.
			 */
			
			double distanceMeter =
			        distance(latitudeParam, longitudeParam, Double.parseDouble((String)tmp.get("UNIT_LATITUDE")), 
			        		Double.parseDouble((String)tmp.get("UNIT_LONGITUDE")), "meter");
			
		    double distanceKiloMeter = 
		    		distance(latitudeParam, longitudeParam, Double.parseDouble((String)tmp.get("UNIT_LATITUDE")),
		    				Double.parseDouble((String)tmp.get("UNIT_LONGITUDE")), "kilometer");
		    
		   //각 인덱스에 접근해서 값들 추가 한다.
		   tmp.put("Meter", String.valueOf(Math.round(distanceMeter))); //소수점 반올림
		   tmp.put("KiloMeter", String.format("%.1f",distanceKiloMeter)); //소수점 2재짜리 반올림
		   /*
		     {"Meter":1629,"KiloMeter":"1.63","
		     {"Meter":1629,"KiloMeter":"1.63","
		     {"Meter":1629,"KiloMeter":"1.63","
		   */
		   
		   geoLocationObjList.add(i,tmp);
		}
		//System.out.println(geoLocationObjList);
		/*
		  [{"Meter":1629,"KiloMeter":"1.63","UNIT_PHONE"....}, {"Meter":1900,"....
		 */
		//최종 목표인 ArrayList<JSONObject> 형태로 반환
		return geoLocationObjList;
	}
         
	private static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
        double theta = lon1 - lon2;
        double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
         
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515;
         
        if (unit == "kilometer") {
            dist = dist * 1.609344;
        } else if(unit == "meter"){
            dist = dist * 1609.344;
        }
        return (dist);
    }
	private static double deg2rad(double deg) {
	    return (deg * Math.PI / 180.0);
	}
	private static double rad2deg(double rad) {
	    return (rad * 180 / Math.PI);
	}
}