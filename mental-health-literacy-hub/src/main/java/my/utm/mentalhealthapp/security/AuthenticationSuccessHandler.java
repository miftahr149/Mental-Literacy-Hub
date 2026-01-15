package my.utm.mentalhealthapp.security;

import my.utm.mentalhealthapp.entity.User;
import my.utm.mentalhealthapp.dao.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component
public class AuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    @Autowired
    private UserDAO userDAO;

    public AuthenticationSuccessHandler() {
        super();
        // Set the default target URL
        setDefaultTargetUrl("/dashboard/");
        setAlwaysUseDefaultTargetUrl(true);
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {

        // Get the authenticated user's email
        String email = authentication.getName();

        // Load user from database
        User user = userDAO.getByEmail(email);

        if (user != null) {
            // Set session attributes for backward compatibility with existing controllers
            HttpSession session = request.getSession();
            session.setAttribute("username", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userId", user.getId());
        }

        // Call parent to handle the redirect
        super.onAuthenticationSuccess(request, response, authentication);
    }
}

