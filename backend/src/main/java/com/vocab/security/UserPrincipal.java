package com.vocab.security;

import com.vocab.entity.User;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.Collection;
import java.util.List;

@Getter
public class UserPrincipal implements UserDetails {

    private final Long id;
    private final String username;
    private final String displayName;
    private final String email;
    private final String password;
    private final String role;

    public UserPrincipal(Long id, String username, String displayName, String email, String password, String role) {
        this.id = id;
        this.username = username;
        this.displayName = displayName;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public static UserPrincipal create(User user) {
        return new UserPrincipal(
            user.getId(),
            user.getUsername(),
            user.getDisplayName(),
            user.getEmail(),
            user.getPassword(),
            user.getRole()
        );
    }

    /** Returns displayName if set, otherwise falls back to username. */
    public String getEffectiveName() {
        return (displayName != null && !displayName.isBlank()) ? displayName : username;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role));
    }

    @Override
    public boolean isAccountNonExpired() { return true; }

    @Override
    public boolean isAccountNonLocked() { return true; }

    @Override
    public boolean isCredentialsNonExpired() { return true; }

    @Override
    public boolean isEnabled() { return true; }
}
