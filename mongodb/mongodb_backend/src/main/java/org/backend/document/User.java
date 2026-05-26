package org.backend.document;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;
import java.util.List;

@Document(collection = "users")
public class User {

    @Id
    private String      id;
    private String      username;
    private String      email;
    private String      passwordHash;
    private String      firstName;
    private String      lastName;
    private String      phone;
    private String      role;
    private List<String> favorites;  // listing mongo-ids
    private Date        createdAt;
    private Date        updatedAt;

    public String       getId()           { return id; }
    public String       getUsername()     { return username; }
    public String       getEmail()        { return email; }
    public String       getPasswordHash() { return passwordHash; }
    public String       getFirstName()    { return firstName; }
    public String       getLastName()     { return lastName; }
    public String       getPhone()        { return phone; }
    public String       getRole()         { return role; }
    public List<String> getFavorites()    { return favorites; }
    public Date         getCreatedAt()    { return createdAt; }
    public Date         getUpdatedAt()    { return updatedAt; }
}
