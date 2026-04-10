package dk.bilbase.backend.web;

import dk.bilbase.backend.dto.MessageResponse;
import dk.bilbase.backend.dto.SendMessageRequest;
import dk.bilbase.backend.security.AppUserPrincipal;
import dk.bilbase.backend.service.MessageService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/messages")
@PreAuthorize("isAuthenticated()")
public class MessageController {

    private final MessageService messageService;

    public MessageController(MessageService messageService) {
        this.messageService = messageService;
    }

    @GetMapping("/inbox")
    public List<MessageResponse> inbox(@AuthenticationPrincipal AppUserPrincipal principal) {
        return messageService.getInbox(principal.getId());
    }

    @GetMapping("/outbox")
    public List<MessageResponse> outbox(@AuthenticationPrincipal AppUserPrincipal principal) {
        return messageService.getOutbox(principal.getId());
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public MessageResponse send(@Valid @RequestBody SendMessageRequest req,
                                @AuthenticationPrincipal AppUserPrincipal principal) {
        return messageService.send(principal.getId(), req);
    }
}
