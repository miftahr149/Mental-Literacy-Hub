package my.utm.mentalhealthapp.security;

import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Custom password encoder that supports both plain text (for backward compatibility) and BCrypt
 * (for new passwords).
 * 
 * This allows existing users with plain text passwords to continue logging in while new
 * registrations use BCrypt encoding.
 */
public class DelegatingPasswordEncoder implements PasswordEncoder {

    private final org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder bcryptEncoder;

    public DelegatingPasswordEncoder() {
        this.bcryptEncoder = new org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder();
    }

    @Override
    public String encode(CharSequence rawPassword) {
        // Always encode new passwords with BCrypt
        return bcryptEncoder.encode(rawPassword);
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        // Handle null cases
        if (rawPassword == null || encodedPassword == null) {
            return false;
        }

        // Check if the encoded password is a BCrypt hash (starts with $2a$, $2b$, or $2y$)
        if (encodedPassword.startsWith("$2a$") || encodedPassword.startsWith("$2b$")
                || encodedPassword.startsWith("$2y$")) {
            // Use BCrypt to verify
            return bcryptEncoder.matches(rawPassword, encodedPassword);
        } else {
            // Plain text password (backward compatibility)
            // Compare directly (trim to handle whitespace)
            String rawPasswordStr = rawPassword.toString().trim();
            String encodedPasswordStr = encodedPassword.trim();
            return rawPasswordStr.equals(encodedPasswordStr);
        }
    }
}

