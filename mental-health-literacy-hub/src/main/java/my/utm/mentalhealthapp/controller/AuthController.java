package my.utm.mentalhealthapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpSession;
import my.utm.mentalhealthapp.model.User;

@Controller
@RequestMapping("/auth")
public class AuthController {

  @GetMapping("/login")
  public ModelAndView showLogin() {
    ModelAndView modelAndView = new ModelAndView("auth_login");
    return modelAndView;
  }

  @PostMapping("/login")
  public ModelAndView handleLogin(@RequestParam String email, @RequestParam String password,
      HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("auth_login");

    // Validate input
    if (email == null || email.trim().isEmpty()) {
      modelAndView.addObject("error", "Email is required");
      modelAndView.addObject("email", email);
      return modelAndView;
    }

    if (password == null || password.trim().isEmpty()) {
      modelAndView.addObject("error", "Password is required");
      modelAndView.addObject("email", email);
      return modelAndView;
    }

    // Authenticate user (trim inputs to handle whitespace)
    if (User.authenticate(email.trim(), password)) {
      User user = User.getByEmail(email);
      session.setAttribute("username", user.getName());
      session.setAttribute("userEmail", user.getEmail());
      session.setAttribute("userRole", user.getRole());
      session.setAttribute("userId", user.getId());

      // Redirect to dashboard
      return new ModelAndView("redirect:/dashboard/");
    } else {
      modelAndView.addObject("error", "Invalid email or password");
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

    if (!role.equals("student") && !role.equals("mhp") && !role.equals("admin")) {
      modelAndView.addObject("error", "Invalid role selected");
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
    if (User.emailExists(email)) {
      modelAndView.addObject("error", "Email already registered. Please use a different email or log in.");
      modelAndView.addObject("name", name);
      modelAndView.addObject("email", email);
      modelAndView.addObject("role", role);
      return modelAndView;
    }

    // Create new user (trim password to avoid whitespace issues)
    User newUser = new User(name.trim(), email.trim(), password.trim(), role);
    User.add(newUser);

    // Auto-login after registration
    session.setAttribute("username", newUser.getName());
    session.setAttribute("userEmail", newUser.getEmail());
    session.setAttribute("userRole", newUser.getRole());
    session.setAttribute("userId", newUser.getId());

    // Redirect to dashboard
    return new ModelAndView("redirect:/dashboard/");
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
    User user = User.getByEmail(email.trim());
    if (user == null) {
      modelAndView.addObject("error", "Email not found. Please check your email address.");
      modelAndView.addObject("email", email);
      return modelAndView;
    }

    // Update password (trim to avoid whitespace issues)
    user.setPassword(newPassword.trim());
    modelAndView.addObject("success", "Password reset successfully. You can now log in with your new password.");

    return modelAndView;
  }

  @GetMapping("/logout")
  public String handleLogout(HttpSession session) {
    session.invalidate();
    return "redirect:/auth/login";
  }
}

