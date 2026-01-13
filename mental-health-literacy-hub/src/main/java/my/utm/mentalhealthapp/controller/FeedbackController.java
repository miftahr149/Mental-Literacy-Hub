package my.utm.mentalhealthapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpSession;
import my.utm.mentalhealthapp.entity.Feedback;
import my.utm.mentalhealthapp.dao.FeedbackDAO;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/feedback")
public class FeedbackController {

    @Autowired
    private FeedbackDAO feedbackDAO;

    /**
     * File Feedback - GET (Students and MHP) GET /feedback/file
     */
    @GetMapping("/file")
    public ModelAndView showFileFeedback(HttpSession session) {
        String userRole = (String) session.getAttribute("userRole");

        // Only students and MHP can file feedback
        if (userRole == null || (!userRole.equals("student") && !userRole.equals("mhp"))) {
            return new ModelAndView("redirect:/dashboard/");
        }

        ModelAndView modelAndView = new ModelAndView("feedback_file");
        return modelAndView;
    }

    /**
     * File Feedback - POST (Students and MHP) POST /feedback/file
     */
    @PostMapping("/file")
    public ModelAndView handleFileFeedback(@RequestParam String message, HttpSession session) {
        String userRole = (String) session.getAttribute("userRole");

        // Only students and MHP can file feedback
        if (userRole == null || (!userRole.equals("student") && !userRole.equals("mhp"))) {
            return new ModelAndView("redirect:/dashboard/");
        }

        ModelAndView modelAndView = new ModelAndView("feedback_file");

        // Validate input
        if (message == null || message.trim().isEmpty()) {
            modelAndView.addObject("error", "Feedback message is required");
            return modelAndView;
        }

        // Get user info from session
        Integer userId = (Integer) session.getAttribute("userId");
        String userName = (String) session.getAttribute("username");
        String userEmail = (String) session.getAttribute("userEmail");

        if (userId == null || userName == null || userEmail == null) {
            modelAndView.addObject("error", "Session error. Please log in again.");
            return modelAndView;
        }

        // Create feedback
        Feedback feedback = new Feedback(userId, userName, userEmail, userRole, message.trim());
        feedbackDAO.saveOrUpdate(feedback);

        modelAndView.addObject("success", "Feedback submitted successfully!");
        return modelAndView;
    }

    /**
     * View My Feedback - GET (Students only) GET /feedback/my-feedback
     */
    @GetMapping("/my-feedback")
    public ModelAndView viewMyFeedback(HttpSession session) {
        String userRole = (String) session.getAttribute("userRole");

        // Only students can view their own feedback
        if (userRole == null || !userRole.equals("student")) {
            return new ModelAndView("redirect:/dashboard/");
        }

        ModelAndView modelAndView = new ModelAndView("feedback_my_feedback");

        // Get user's feedback
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId != null) {
            List<Feedback> myFeedback = feedbackDAO.getByUserId(userId);
            modelAndView.addObject("feedbacks", myFeedback);
        } else {
            modelAndView.addObject("feedbacks", new ArrayList<>());
        }

        return modelAndView;
    }

    /**
     * View Student Feedback - GET (MHP only) GET /feedback/view
     */
    @GetMapping("/view")
    public ModelAndView viewStudentFeedback(HttpSession session) {
        String userRole = (String) session.getAttribute("userRole");

        // Only MHP can view student feedback
        if (userRole == null || !userRole.equals("mhp")) {
            return new ModelAndView("redirect:/dashboard/");
        }

        ModelAndView modelAndView = new ModelAndView("feedback_view");

        // Get all student feedback
        List<Feedback> studentFeedback = feedbackDAO.getByStudentRole();
        modelAndView.addObject("feedbacks", studentFeedback);

        return modelAndView;
    }

    /**
     * Admin Feedback Management - GET (Admin only) GET /feedback/admin
     */
    @GetMapping("/admin")
    public ModelAndView adminFeedbackManagement(HttpSession session) {
        String userRole = (String) session.getAttribute("userRole");

        // Only admin can access
        if (userRole == null || !userRole.equals("admin")) {
            return new ModelAndView("redirect:/dashboard/");
        }

        ModelAndView modelAndView = new ModelAndView("feedback_admin");

        // Get all feedback
        List<Feedback> allFeedback = feedbackDAO.getAll();
        modelAndView.addObject("feedbacks", allFeedback);

        return modelAndView;
    }

    /**
     * Admin Update Feedback Status - POST (Admin only) POST /feedback/admin/update-status
     */
    @PostMapping("/admin/update-status")
    public ModelAndView updateFeedbackStatus(@RequestParam int feedbackId,
            @RequestParam String status, HttpSession session) {
        String userRole = (String) session.getAttribute("userRole");

        // Only admin can update status
        if (userRole == null || !userRole.equals("admin")) {
            return new ModelAndView("redirect:/dashboard/");
        }

        ModelAndView modelAndView = new ModelAndView("redirect:/feedback/admin");

        // Validate status
        if (!status.equals("pending") && !status.equals("in-review")
                && !status.equals("responded")) {
            modelAndView.addObject("error", "Invalid status");
            return modelAndView;
        }

        // Get feedback and update
        Feedback feedback = feedbackDAO.getById(feedbackId);
        if (feedback != null) {
            feedback.setStatus(status);
            feedbackDAO.update(feedback);
            modelAndView.addObject("success", "Status updated successfully");
        } else {
            modelAndView.addObject("error", "Feedback not found");
        }

        List<Feedback> allFeedback = feedbackDAO.getAll();
        modelAndView.addObject("feedbacks", allFeedback);
        return modelAndView;
    }

    /**
     * Admin Respond to Feedback - POST (Admin only) POST /feedback/admin/respond
     */
    @PostMapping("/admin/respond")
    public ModelAndView respondToFeedback(@RequestParam int feedbackId,
            @RequestParam String response, HttpSession session) {
        String userRole = (String) session.getAttribute("userRole");

        // Only admin can respond
        if (userRole == null || !userRole.equals("admin")) {
            return new ModelAndView("redirect:/dashboard/");
        }

        ModelAndView modelAndView = new ModelAndView("feedback_admin");

        // Validate input
        if (response == null || response.trim().isEmpty()) {
            modelAndView.addObject("error", "Response message is required");
            List<Feedback> allFeedback = feedbackDAO.getAll();
            modelAndView.addObject("feedbacks", allFeedback);
            return modelAndView;
        }

        // Get feedback and update
        Feedback feedback = feedbackDAO.getById(feedbackId);
        if (feedback != null) {
            feedback.setResponse(response.trim());
            feedback.setStatus("responded");
            feedbackDAO.update(feedback);
            modelAndView.addObject("success", "Response submitted successfully");
        } else {
            modelAndView.addObject("error", "Feedback not found");
        }

        List<Feedback> allFeedback = feedbackDAO.getAll();
        modelAndView.addObject("feedbacks", allFeedback);
        return modelAndView;
    }
}

