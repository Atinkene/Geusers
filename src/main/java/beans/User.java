package beans;

public class User {

    private int    id;
    private String firstName;
    private String lastName;
    private String username;
    private String password;

    // Constructors

    public User() {}

    // Used by UserService when creating a new user.
    public User(String firstName, String lastName, String username, String password) 
	{
        this.firstName = firstName;
        this.lastName  = lastName;
        this.username  = username;
        this.password  = password;
    }

    // Getters 
	
    public int getId() {	return id;	}
    public String getFirstName() {	return firstName;	}
    public String getLastName() {	return lastName;	}
    public String getUsername() {	return username;	}
    public String getPassword() {	return password;	}

	// Setters

    public void setId(int id) {	this.id = id; }
    public void setFirstName(String firstName) {	this.firstName = firstName;	}
    public void setLastName(String lastName) {	this.lastName = lastName;	}
    public void setUsername(String username) {	this.username = username;	}
    public void setPassword(String password) {	this.password = password;	}


    // Utility 

    public String getFullName() {
        return firstName + " " + lastName.toUpperCase();
    }

    @Override
    public String toString() {
        return "User{id=" + id
             + ", username='" + username + "'"
             + ", fullName='" + getFullName() + "'}";
    }
}