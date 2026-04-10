package dk.bilbase.backend.service;

import dk.bilbase.backend.domain.AppUser;
import dk.bilbase.backend.domain.CarListing;
import dk.bilbase.backend.domain.Message;
import dk.bilbase.backend.dto.MessageResponse;
import dk.bilbase.backend.dto.SendMessageRequest;
import dk.bilbase.backend.repository.AppUserRepository;
import dk.bilbase.backend.repository.CarListingRepository;
import dk.bilbase.backend.repository.MessageRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MessageService {

    private final MessageRepository messageRepo;
    private final AppUserRepository userRepo;
    private final CarListingRepository listingRepo;

    public MessageService(MessageRepository messageRepo,
                          AppUserRepository userRepo,
                          CarListingRepository listingRepo) {
        this.messageRepo = messageRepo;
        this.userRepo = userRepo;
        this.listingRepo = listingRepo;
    }

    @Transactional(readOnly = true)
    public List<MessageResponse> getInbox(Long userId) {
        return messageRepo.findByReceiverIdOrderBySentAtDesc(userId).stream()
                .map(MessageResponse::from)
                .toList();
    }

    @Transactional(readOnly = true)
    public List<MessageResponse> getOutbox(Long userId) {
        return messageRepo.findBySenderIdOrderBySentAtDesc(userId).stream()
                .map(MessageResponse::from)
                .toList();
    }

    @Transactional
    public MessageResponse send(Long senderId, SendMessageRequest req) {
        AppUser sender = userRepo.findById(senderId)
                .orElseThrow(() -> new EntityNotFoundException("Sender not found: " + senderId));
        AppUser receiver = userRepo.findById(req.receiverId())
                .orElseThrow(() -> new EntityNotFoundException("Receiver not found: " + req.receiverId()));
        CarListing listing = listingRepo.findById(req.carListingId())
                .orElseThrow(() -> new EntityNotFoundException("Listing not found: " + req.carListingId()));

        // DB triggers validate: sender != receiver, listing not sold
        // DataIntegrityViolation with SQLState 45000 → 400 via GlobalExceptionHandler
        Message msg = messageRepo.save(new Message(sender, receiver, listing, req.content()));
        return MessageResponse.from(msg);
    }
}
