package my.utm.mentalhealthapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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

