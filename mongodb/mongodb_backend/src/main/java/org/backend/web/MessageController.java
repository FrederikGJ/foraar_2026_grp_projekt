package org.backend.web;

import io.swagger.v3.oas.annotations.Parameter;
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

    @GetMapping("/inbox")
    public List<Message> inbox(
            @Parameter(example = "user_2")
            @RequestParam(name = "userId") String userId) {
        return messageRepository.findByReceiverIdOrderBySentAtDesc(userId);
    }

    @GetMapping("/outbox")
    public List<Message> outbox(
            @Parameter(example = "user_22")
            @RequestParam(name = "userId") String userId) {
        return messageRepository.findBySenderIdOrderBySentAtDesc(userId);
    }

    @GetMapping("/listing/{listingId}")
    public List<Message> byListing(
            @Parameter(example = "listing_1")
            @PathVariable(name = "listingId") String listingId) {
        return messageRepository.findByListingIdOrderBySentAtAsc(listingId);
    }
}
