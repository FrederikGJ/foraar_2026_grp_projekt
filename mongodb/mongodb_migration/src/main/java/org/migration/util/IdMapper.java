package org.migration.util;

import java.util.HashMap;
import java.util.Map;

public class IdMapper {

    // One map per entity type
    private final Map<Long, String> userIds     = new HashMap<>();
    private final Map<Long, String> listingIds  = new HashMap<>();

    public void putUser(long mysqlId, String mongoId) {
        userIds.put(mysqlId, mongoId);
    }

    public String getUser(long mysqlId) {
        return userIds.get(mysqlId);
    }

    public void putListing(long mysqlId, String mongoId) {
        listingIds.put(mysqlId, mongoId);
    }

    public String getListing(long mysqlId) {
        return listingIds.get(mysqlId);
    }
}
