package org.backend.document;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document(collection = "messages")
public class Message {

    @Id
    private String  id;
    private String  listingId;
    private String  senderId;
    private String  receiverId;
    private String  content;
    private boolean isRead;
    private Date    sentAt;

    public String  getId()         { return id; }
    public String  getListingId()  { return listingId; }
    public String  getSenderId()   { return senderId; }
    public String  getReceiverId() { return receiverId; }
    public String  getContent()    { return content; }
    public boolean isRead()        { return isRead; }
    public Date    getSentAt()     { return sentAt; }
}
