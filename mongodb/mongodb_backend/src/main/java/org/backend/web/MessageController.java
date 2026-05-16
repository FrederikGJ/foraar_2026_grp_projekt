package org.backend.web;

import org.backend.document.Message;
import org.backend.repository.MessageRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/messages")
public class MessageController {

    private final MessageRepository messageRepository;

    public MessageController(MessageRepository messageRepository) {
        this.messageRepository = messageRepository;
    }

    // GET /api/messages/inbox?userId=user_3
    @GetMapping("/inbox")
    public List<Message> inbox(@RequestParam(name = "userId") String userId) {
        return messageRepository.findByReceiverIdOrderBySentAtDesc(userId);
    }

    // GET /api/messages/outbox?userId=user_3
    @GetMapping("/outbox")
    public List<Message> outbox(@RequestParam(name = "userId") String userId) {
        return messageRepository.findBySenderIdOrderBySentAtDesc(userId);
    }

    // GET /api/messages/listing/listing_4
    @GetMapping("/listing/{listingId}")
    public List<Message> byListing(@PathVariable(name = "listingId") String listingId) {
        return messageRepository.findByListingIdOrderBySentAtAsc(listingId);
    }
}
