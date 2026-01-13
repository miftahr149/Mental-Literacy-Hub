package my.utm.mentalhealthapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpSession;
import my.utm.mentalhealthapp.entity.User;
import my.utm.mentalhealthapp.dao.UserDAO;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserDAO userDAO;

    @GetMapping("/login")
    public ModelAndView showLogin() {
        ModelAndView modelAndView = new ModelAndView("auth_login");
        return modelAndView;
    }

    @PostMapping("/login")
    public ModelAndView handleLogin(@RequestParam String role, @RequestParam String email,
            @RequestParam String password, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("auth_login");

        // Validate input
        if (role == null || role.trim().isEmpty()) {
            modelAndView.addObject("error", "Role is required");
            modelAndView.addObject("email", email);
            return modelAndView;
        }

        if (email == null || email.trim().isEmpty()) {
            modelAndView.addObject("error", "Email is required");
            modelAndView.addObject("role", role);
            modelAndView.addObject("email", email);
            return modelAndView;
        }

        if (password == null || password.trim().isEmpty()) {
            modelAndView.addObject("error", "Password is required");
            modelAndView.addObject("role", role);
            modelAndView.addObject("email", email);
            return modelAndView;
        }

        // Validate role
        if (!role.equals("student") && !role.equals("mhp") && !role.equals("admin")) {
            modelAndView.addObject("error", "Invalid role selected");
            modelAndView.addObject("role", role);
            modelAndView.addObject("email", email);
            return modelAndView;
        }

        // Authenticate user (trim inputs to handle whitespace)
        if (userDAO.authenticate(email.trim(), password)) {
            User user = userDAO.getByEmail(email.trim());

            // This should never be null if authenticate() returns true, but check for safety
            if (user == null) {
                modelAndView.addObject("error", "User account error. Please contact support.");
                modelAndView.addObject("role", role);
                modelAndView.addObject("email", email);
                return modelAndView;
            }

            // Verify that the selected role matches the user's actual role
            if (!user.getRole().equals(role)) {
                modelAndView.addObject("error",
                        "The selected role does not match your account. Please select the correct role.");
                modelAndView.addObject("role", role);
                modelAndView.addObject("email", email);
                return modelAndView;
            }

            session.setAttribute("username", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userId", user.getId());

            // Redirect to dashboard
            return new ModelAndView("redirect:/dashboard/");
        } else {
            modelAndView.addObject("error", "Invalid email or password");
            modelAndView.addObject("role", role);
            modelAndView.addObject("email", email);
            return modelAndView;
        }
    }

    @GetMapping("/register")
    public ModelAndView showRegister() {
        ModelAndView modelAndView = new ModelAndView("auth_register");
        return modelAndView;
    }

    @PostMapping("/register")
    public ModelAndView handleRegister(@RequestParam String name, @RequestParam String email,
            @RequestParam String role, @RequestParam String password,
            @RequestParam String confirmPassword, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("auth_register");

        // Validate input
        if (name == null || name.trim().isEmpty()) {
            modelAndView.addObject("error", "Name is required");
            modelAndView.addObject("name", name);
            modelAndView.addObject("email", email);
            modelAndView.addObject("role", role);
            return modelAndView;
        }

        if (email == null || email.trim().isEmpty()) {
            modelAndView.addObject("error", "Email is required");
            modelAndView.addObject("name", name);
            modelAndView.addObject("email", email);
            modelAndView.addObject("role", role);
            return modelAndView;
        }

        if (role == null || role.trim().isEmpty()) {
            modelAndView.addObject("error", "Role is required");
            modelAndView.addObject("name", name);
            modelAndView.addObject("email", email);
            modelAndView.addObject("role", role);
            return modelAndView;
        }

        // Only allow student and mhp roles for public registration (admin accounts must be created
        // by admins)
        if (!role.equals("student") && !role.equals("mhp")) {
            modelAndView.addObject("error",
                    "Invalid role selected. Admin accounts cannot be created through public registration.");
            modelAndView.addObject("name", name);
            modelAndView.addObject("email", email);
            modelAndView.addObject("role", role);
            return modelAndView;
        }

        if (password == null || password.trim().isEmpty()) {
            modelAndView.addObject("error", "Password is required");
            modelAndView.addObject("name", name);
            modelAndView.addObject("email", email);
            modelAndView.addObject("role", role);
            return modelAndView;
        }

        if (password.length() < 6) {
            modelAndView.addObject("error", "Password must be at least 6 characters long");
            modelAndView.addObject("name", name);
            modelAndView.addObject("email", email);
            modelAndView.addObject("role", role);
            return modelAndView;
        }

        if (!password.trim().equals(confirmPassword.trim())) {
            modelAndView.addObject("error", "Passwords do not match");
            modelAndView.addObject("name", name);
            modelAndView.addObject("email", email);
            modelAndView.addObject("role", role);
            return modelAndView;
        }

        // Check if email already exists
        if (userDAO.emailExists(email)) {
            modelAndView.addObject("error",
                    "Email already registered. Please use a different email or log in.");
            modelAndView.addObject("name", name);
            modelAndView.addObject("email", email);
            modelAndView.addObject("role", role);
            return modelAndView;
        }

        // Create new user (trim password to avoid whitespace issues)
        User newUser = new User(name.trim(), email.trim(), password.trim(), role);
        userDAO.saveOrUpdate(newUser);

        // Redirect to login page with success message
        ModelAndView loginView = new ModelAndView("auth_login");
        loginView.addObject("success", "Account created successfully! Please log in.");
        return loginView;
    }

    @GetMapping("/reset-password")
    public ModelAndView showResetPassword() {
        ModelAndView modelAndView = new ModelAndView("auth_reset_password");
        return modelAndView;
    }

    @PostMapping("/reset-password")
    public ModelAndView handleResetPassword(@RequestParam String email,
            @RequestParam String newPassword, @RequestParam String confirmPassword) {
        ModelAndView modelAndView = new ModelAndView("auth_reset_password");

        // Validate input
        if (email == null || email.trim().isEmpty()) {
            modelAndView.addObject("error", "Email is required");
            modelAndView.addObject("email", email);
            return modelAndView;
        }

        if (newPassword == null || newPassword.trim().isEmpty()) {
            modelAndView.addObject("error", "New password is required");
            modelAndView.addObject("email", email);
            return modelAndView;
        }

        if (newPassword.length() < 6) {
            modelAndView.addObject("error", "Password must be at least 6 characters long");
            modelAndView.addObject("email", email);
            return modelAndView;
        }

        if (!newPassword.trim().equals(confirmPassword.trim())) {
            modelAndView.addObject("error", "Passwords do not match");
            modelAndView.addObject("email", email);
            return modelAndView;
        }

        // Find user by email
        User user = userDAO.getByEmail(email.trim());
        if (user == null) {
            modelAndView.addObject("error", "Email not found. Please check your email address.");
            modelAndView.addObject("email", email);
            return modelAndView;
        }

        // Update password (trim to avoid whitespace issues)
        user.setPassword(newPassword.trim());
        userDAO.update(user);
        modelAndView.addObject("success",
                "Password reset successfully. You can now log in with your new password.");

        return modelAndView;
    }

    @GetMapping("/logout")
    public String handleLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }
}

