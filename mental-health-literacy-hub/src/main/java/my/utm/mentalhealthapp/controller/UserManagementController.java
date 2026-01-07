package my.utm.mentalhealthapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpSession;
import my.utm.mentalhealthapp.model.User;
import java.util.ArrayList;
import java.util.List;

/**
 * Frontend-only controller - serves JSP views only
 * Backend logic to be added later
 */
@Controller
@RequestMapping("/user-management")
public class UserManagementController {

  /**
   * View Profile - Frontend only
   * GET /user-management/profile
   */
  @GetMapping("/profile")
  public ModelAndView viewProfile(HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("user_management_view_profile");
    
    // Get user from session or create dummy data for display
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId != null) {
      User user = User.getById(userId);
      if (user != null) {
        modelAndView.addObject("user", user);
        return modelAndView;
      }
    }
    
    // Fallback: Create dummy user from session data for UI display
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("userEmail");
    String role = (String) session.getAttribute("userRole");
    
    if (username != null && email != null && role != null) {
      User dummyUser = new User(username, email, "", role);
      modelAndView.addObject("user", dummyUser);
    }
    
    return modelAndView;
  }

  /**
   * Edit Profile - Frontend only
   * GET /user-management/profile/edit
   */
  @GetMapping("/profile/edit")
  public ModelAndView showEditProfile(HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("user_management_edit_profile");
    
    // Get user from session or create dummy data for display
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId != null) {
      User user = User.getById(userId);
      if (user != null) {
        modelAndView.addObject("user", user);
        return modelAndView;
      }
    }
    
    // Fallback: Create dummy user from session data for UI display
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("userEmail");
    String role = (String) session.getAttribute("userRole");
    
    if (username != null && email != null && role != null) {
      User dummyUser = new User(username, email, "", role);
      modelAndView.addObject("user", dummyUser);
    }
    
    return modelAndView;
  }

  /**
   * Update Profile - POST handler
   * POST /user-management/profile/edit
   */
  @PostMapping("/profile/edit")
  public ModelAndView updateProfile(@RequestParam String name, @RequestParam String email,
      HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("user_management_edit_profile");
    
    // Validate input
    if (name == null || name.trim().isEmpty()) {
      modelAndView.addObject("error", "Name is required");
      Integer userId = (Integer) session.getAttribute("userId");
      if (userId != null) {
        User user = User.getById(userId);
        if (user != null) {
          modelAndView.addObject("user", user);
          return modelAndView;
        }
      }
      return modelAndView;
    }

    if (email == null || email.trim().isEmpty()) {
      modelAndView.addObject("error", "Email is required");
      Integer userId = (Integer) session.getAttribute("userId");
      if (userId != null) {
        User user = User.getById(userId);
        if (user != null) {
          modelAndView.addObject("user", user);
          return modelAndView;
        }
      }
      return modelAndView;
    }

    // Get user and update
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId != null) {
      User user = User.getById(userId);
      if (user != null) {
        // Check if email is being changed and if it already exists
        if (!user.getEmail().equalsIgnoreCase(email) && User.emailExists(email)) {
          modelAndView.addObject("error", "Email already exists. Please use a different email.");
          modelAndView.addObject("user", user);
          return modelAndView;
        }
        
        user.setName(name);
        user.setEmail(email);
        
        // Update session
        session.setAttribute("username", name);
        session.setAttribute("userEmail", email);
        
        modelAndView.addObject("success", "Profile updated successfully!");
        modelAndView.addObject("user", user);
        return modelAndView;
      }
    }
    
    // If user not found, redirect to profile
    return new ModelAndView("redirect:/user-management/profile");
  }

  /**
   * Change Password - Frontend only
   * GET /user-management/profile/change-password
   */
  @GetMapping("/profile/change-password")
  public ModelAndView showChangePassword(HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("user_management_change_password");
    // No data needed for change password form
    return modelAndView;
  }

  /**
   * Change Password - POST handler
   * POST /user-management/profile/change-password
   */
  @PostMapping("/profile/change-password")
  public ModelAndView changePassword(@RequestParam String currentPassword,
      @RequestParam String newPassword, @RequestParam String confirmPassword,
      HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("user_management_change_password");

    // Validate input
    if (currentPassword == null || currentPassword.trim().isEmpty()) {
      modelAndView.addObject("error", "Current password is required");
      return modelAndView;
    }

    if (newPassword == null || newPassword.trim().isEmpty()) {
      modelAndView.addObject("error", "New password is required");
      return modelAndView;
    }

    if (newPassword.length() < 6) {
      modelAndView.addObject("error", "Password must be at least 6 characters long");
      return modelAndView;
    }

    if (!newPassword.equals(confirmPassword)) {
      modelAndView.addObject("error", "New passwords do not match");
      return modelAndView;
    }

    // Get user and verify current password
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId != null) {
      User user = User.getById(userId);
      if (user != null) {
        // Verify current password
        if (!user.getPassword().equals(currentPassword)) {
          modelAndView.addObject("error", "Current password is incorrect");
          return modelAndView;
        }

        // Update password
        user.setPassword(newPassword);
        modelAndView.addObject("success", "Password changed successfully!");
        return modelAndView;
      }
    }

    modelAndView.addObject("error", "User not found. Please log in again.");
    return modelAndView;
  }

  /**
   * View Users (Admin) - Frontend only
   * GET /user-management/admin/users
   */
  @GetMapping("/admin/users")
  public ModelAndView viewUsers(HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("user_management_view_users");
    
    // Get all users for display (or empty list if none)
    try {
      List<User> users = User.getAll();
      modelAndView.addObject("users", users);
    } catch (Exception e) {
      // If User.getAll() doesn't work, provide empty list
      modelAndView.addObject("users", new ArrayList<User>());
    }
    
    return modelAndView;
  }
}

