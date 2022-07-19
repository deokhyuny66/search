package action;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.*;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

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
	
	public static List<JSONObject> geoLocationCulcurate(List<JSONObject> geoLocationList,double latitudeParam, double longitudeParam){
		List<JSONObject> geoLocationNewList = new ArrayList<JSONObject>();
		geoLocationNewList = geoLocationList;
		
		//1.반복문으로 위경도 값 꺼내서
		for(int i=0;i<geoLocationList.size();i++){
		    double distanceMeter =
		        distance(latitudeParam, longitudeParam, Double.parseDouble(geoLocationList.get(i).get("UNIT_LATITUDE").toString()), 
		        		Double.parseDouble(geoLocationList.get(i).get("UNIT_LONGITUDE").toString()), "meter");
		     
		    double distanceKiloMeter = 
		    		distance(latitudeParam, longitudeParam, Double.parseDouble(geoLocationList.get(i).get("UNIT_LATITUDE").toString()),
		    				Double.parseDouble(geoLocationList.get(i).get("UNIT_LONGITUDE").toString()), "kilometer");
		    
		    //잘 나옴.
		    //System.out.println(geoLocationList.get(i).get("UNIT_COMPANY").toString() + " = " + String.format("%.2f",distanceMeter) + "m /" + String.format("%.2f",distanceKiloMeter) + "km");
		    
		    //3.반환 된 M, KM 값을 기존 LIST를 새로운 LIST에 담고 해당 인덱스에 추가하기.
		    //geoLocationNewList.add(i, Double.String(String.format("%.2f",distanceMeter)) );
		}

	    //5.List 결과 반환
		return null;
		
	    //System.out.println(Math.round(distanceMeter)+"m");
	    //System.out.println(Math.round(distanceKiloMeter)+"km");
	    
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
/*	public static Float[] geoCoding(String location) throws IOException {
		 
        if (location == null)
            return null;
 
        Geocoder geocoder = new Geocoder();
        
        // setAddress : 변환하려는 주소 (경기도 성남시 분당구 등)
        // setLanguate : 인코딩 설정
        
        GeocoderRequest geocoderRequest = new GeocoderRequestBuilder().setAddress(location).setLanguage("en").getGeocoderRequest();
        GeocodeResponse geocoderResponse;
       
    	geocoderResponse = geocoder.geocode(geocoderRequest);
        
        System.out.println(geocoderResponse);
        
		if (geocoderResponse.getStatus() == GeocoderStatus.OK & !geocoderResponse.getResults().isEmpty()) {
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		    GeocoderResult geocoderResult = geocoderResponse.getResults().iterator().next();
		    LatLng latitudeLongitude = geocoderResult.getGeometry().getLocation();
		    Float[] coords = new Float[2];
		    coords[0] = latitudeLongitude.getLat().floatValue();
		    coords[1] = latitudeLongitude.getLng().floatValue();
		    return coords;
		}
        return null;
 
    }*/