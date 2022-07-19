package action;

import java.util.*;

public class actionDTO {
	String name = null;
	String id = null;
	String age = null;
	double latitude = 0.0;
	double longitude = 0.0;
	List<String> items_arr = null;

	public double getLongitude() {
		return this.longitude;
	}
	  
	public void setLongitude(double paramLongitude) {
		 this.longitude = paramLongitude;
	}
	
	public double getLatitude() {
		return this.latitude;
	}
	  
	public void setLatitude(double paramLatitude) {
		 this.latitude = paramLatitude;
	}
	
	public String getName() {
		return this.name;
	}
	  
	public void setName(String paramName) {
		 this.name = paramName;
	}
	
	public String getAge() {
		return this.age;
	}
	  
	public void setAge(String paramAge) {
		 this.age = paramAge;
	}

	public String getId() {
		return this.id;
	}
	  
	public void setId(String paramId) {
		 this.id = paramId;
	}
	
	public List<String> getList() {
		return this.items_arr;
	}

	public void setList(List<String> item) {
		this.items_arr = item;
	}
}

