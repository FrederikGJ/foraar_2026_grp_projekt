package org.backend.repository;

import org.backend.document.Message;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface MessageRepository extends MongoRepository<Message, String> {

    List<Message> findByReceiverIdOrderBySentAtDesc(String receiverId);

    List<Message> findBySenderIdOrderBySentAtDesc(String senderId);

    List<Message> findByListingIdOrderBySentAtAsc(String listingId);
}
