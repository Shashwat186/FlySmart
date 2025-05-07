package smart.fly.adult.model;

//We use it in booking service while selecting the number of adults during the booking service.
public class Adult {
	private String name;
	private String email;

	public Adult() {
	}

	public Adult(String name, String email) {
		this.name = name;
		this.email = email;
	}

	
	public String getName() {
		return name;
	}

	public String getEmail() {
		return email;
	}

	// Setter methods
	public void setName(String name) {
		this.name = name;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
