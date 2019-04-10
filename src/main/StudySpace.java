package main;

public class StudySpace {
	private String name;
	private double longitude;
	private double latitude;
	private String photoURL;
	private String outlet;
	private String seats;
	private String lights;
	private int noise;
	private Boolean outside; //true is outside, false is inside
	private Boolean cafe;
	private String hourOpen;
	private String hourClose;
	private String phone;
	private String address;
	private String building;
	
	public StudySpace() {
		
	}
	//construct using this one
	public StudySpace(String n, double lon, double lat, String p, String o, String s, String l,
			int noi, Boolean i, Boolean c, String op, String cl, String pho, String a, String b) {
		name = n;
		longitude = lon;
		latitude = lat;
		photoURL = p;
		outlet = o;
		seats =s;
		lights = l;
		noise = noi;
		outside = i;
		cafe = c;
		hourOpen = op;
		hourClose = cl;
		phone = pho;
		address = a;
		building = b;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public float getLongitude() {
		return longitude;
	}
	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}
	public float getLatitude() {
		return latitude;
	}
	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}
	public String getPhotoURL() {
		return photoURL;
	}
	public void setPhotoURL(String photoURL) {
		this.photoURL = photoURL;
	}
	public String getOutlet() {
		return outlet;
	}
	public void setOutlet(String outlet) {
		this.outlet = outlet;
	}
	public String getSeats() {
		return seats;
	}
	public void setSeats(String seats) {
		this.seats = seats;
	}
	public String getLights() {
		return lights;
	}
	public void setLights(String lights) {
		this.lights = lights;
	}
	public int getNoise() {
		return noise;
	}
	public void setNoise(int noise) {
		this.noise = noise;
	}
	public Boolean getOutside() {
		return outside;
	}
	public void setOutside(Boolean outside) {
		this.outside = outside;
	}
	public Boolean getCafe() {
		return cafe;
	}
	public void setCafe(Boolean cafe) {
		this.cafe = cafe;
	}
	public String getHourOpen() {
		return hourOpen;
	}
	public void setHourOpen(String hourOpen) {
		this.hourOpen = hourOpen;
	}
	public String getHourClose() {
		return hourClose;
	}
	public void setHourClose(String hourClose) {
		this.hourClose = hourClose;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBuilding() {
		return building;
	}

	public void setBuilding(String building) {
		this.building = building;
	}
}
