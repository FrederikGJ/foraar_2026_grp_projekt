package dk.bilbase.backend.web.auth;

import dk.bilbase.backend.domain.AppUser;
import dk.bilbase.backend.domain.Role;
import dk.bilbase.backend.repository.AppUserRepository;
import dk.bilbase.backend.repository.RoleRepository;
import dk.bilbase.backend.security.AppUserPrincipal;
import dk.bilbase.backend.security.JwtService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private static final String DEFAULT_ROLE_FOR_REGISTRATION = "CUSTOMER";

    private final AppUserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    public AuthController(AppUserRepository userRepository,
                          RoleRepository roleRepository,
                          PasswordEncoder passwordEncoder,
                          AuthenticationManager authenticationManager,
                          JwtService jwtService) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
    }

    @PostMapping("/register")
    public ResponseEntity<AuthResponse> register(@Valid @RequestBody RegisterRequest req) {
        if (userRepository.existsByUsername(req.username())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Username already taken");
        }
        if (userRepository.existsByEmail(req.email())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Email already registered");
        }

        Role role = roleRepository.findByName(DEFAULT_ROLE_FOR_REGISTRATION)
                .orElseThrow(() -> new IllegalStateException(
                        "Default role '" + DEFAULT_ROLE_FOR_REGISTRATION + "' not found in DB"));

        AppUser user = new AppUser(
                req.username(),
                req.email(),
                passwordEncoder.encode(req.password()),
                req.firstName(),
                req.lastName(),
                req.phone(),
                role
        );
        AppUser saved = userRepository.save(user);

        String token = jwtService.generateToken(saved.getId(), saved.getUsername(), role.getName());
        return ResponseEntity.status(HttpStatus.CREATED).body(
                AuthResponse.bearer(token, jwtService.getExpirationMs(),
                        saved.getId(), saved.getUsername(), role.getName())
        );
    }

    @PostMapping("/login")
    public AuthResponse login(@Valid @RequestBody LoginRequest req) {
        try {
            Authentication auth = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(req.username(), req.password())
            );
            AppUserPrincipal principal = (AppUserPrincipal) auth.getPrincipal();
            String token = jwtService.generateToken(
                    principal.getId(), principal.getUsername(), principal.getRoleName());
            return AuthResponse.bearer(token, jwtService.getExpirationMs(),
                    principal.getId(), principal.getUsername(), principal.getRoleName());
        } catch (BadCredentialsException ex) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid username or password");
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<Map<String, String>> logout() {
        // Stateless JWT — server-side logout er en no-op.
        // Klienten kasserer selv tokenet. (En blacklist kan tilføjes senere hvis nødvendigt.)
        return ResponseEntity.ok(Map.of("message", "Logged out"));
    }

    @GetMapping("/me")
    @PreAuthorize("isAuthenticated()")
    public Map<String, Object> me(@AuthenticationPrincipal AppUserPrincipal principal) {
        return Map.of(
                "id", principal.getId(),
                "username", principal.getUsername(),
                "role", principal.getRoleName()
        );
    }
}
