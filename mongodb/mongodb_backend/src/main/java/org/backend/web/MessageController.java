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

    /**
     * GET /api/messages/inbox?userId=user_3
     * All messages received by a user, newest first.
     */
    @GetMapping("/inbox")
    public List<Message> inbox(@RequestParam String userId) {
        return messageRepository.findByReceiverIdOrderBySentAtDesc(userId);
    }

    /**
     * GET /api/messages/outbox?userId=user_3
     * All messages sent by a user, newest first.
     */
    @GetMapping("/outbox")
    public List<Message> outbox(@RequestParam String userId) {
        return messageRepository.findBySenderIdOrderBySentAtDesc(userId);
    }

    /**
     * GET /api/messages/listing/{listingId}
     * Full message thread for a listing, oldest first.
     */
    @GetMapping("/listing/{listingId}")
    public List<Message> byListing(@PathVariable String listingId) {
        return messageRepository.findByListingIdOrderBySentAtAsc(listingId);
    }
}
