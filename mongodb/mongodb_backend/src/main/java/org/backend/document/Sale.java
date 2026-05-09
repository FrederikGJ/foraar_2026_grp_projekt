package org.backend.document;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document(collection = "sales")
public class Sale {

    @Id
    private String   id;
    private String   listingId;
    private String   buyerId;
    private Date     soldAt;
    private Snapshot snapshot;

    public record Snapshot(
            String brand,
            String model,
            int    year,
            double price,
            String sellerUsername
    ) {}

    public String   getId()        { return id; }
    public String   getListingId() { return listingId; }
    public String   getBuyerId()   { return buyerId; }
    public Date     getSoldAt()    { return soldAt; }
    public Snapshot getSnapshot()  { return snapshot; }
}
