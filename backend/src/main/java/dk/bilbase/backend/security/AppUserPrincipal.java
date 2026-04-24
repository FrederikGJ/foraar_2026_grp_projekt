package dk.bilbase.backend.security;

import dk.bilbase.backend.domain.AppUser;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

/**
 * Custom UserDetails impl der bærer både Spring Security-felter
 * og vores egne (id, role-navn) så controllers og services kan tilgå dem.
 */
public class AppUserPrincipal implements UserDetails {

    private final Long id;
    private final String username;
    private final String passwordHash;
    private final String roleName;
    private final Collection<? extends GrantedAuthority> authorities;

    public AppUserPrincipal(AppUser user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.passwordHash = user.getPasswordHash();
        this.roleName = user.getRole().getName();
        this.authorities = List.of(new SimpleGrantedAuthority("ROLE_" + this.roleName));
    }

    public AppUserPrincipal(Long id, String username, String roleName) {
        this.id = id;
        this.username = username;
        this.passwordHash = null;
        this.roleName = roleName;
        this.authorities = List.of(new SimpleGrantedAuthority("ROLE_" + roleName));
    }

    public Long getId() {
        return id;
    }

    public String getRoleName() {
        return roleName;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return passwordHash;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override public boolean isAccountNonExpired() { return true; }
    @Override public boolean isAccountNonLocked() { return true; }
    @Override public boolean isCredentialsNonExpired() { return true; }
    @Override public boolean isEnabled() { return true; }
}
