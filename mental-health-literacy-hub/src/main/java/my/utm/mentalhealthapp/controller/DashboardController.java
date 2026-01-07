package my.utm.mentalhealthapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpSession;
import my.utm.mentalhealthapp.model.MentalHealthChallenge;
import my.utm.mentalhealthapp.model.MentalHealthChallengeType;
import java.util.List;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

  @GetMapping("/")
  public ModelAndView dashboard(HttpSession session) {
    String userRole = (String) session.getAttribute("userRole");
    String username = (String) session.getAttribute("username");

    if (userRole == null || username == null) {
      return new ModelAndView("redirect:/auth/login");
    }

    ModelAndView modelAndView = new ModelAndView("dashboard");
    
    // Get user-specific data
    if (userRole.equals("student")) {
      List<MentalHealthChallenge> challenges = MentalHealthChallenge.getByUser(username);
      modelAndView.addObject("challenges", challenges);
      
      // Calculate stats
      int totalChallenges = challenges.size();
      int activeChallenges = (int) challenges.stream()
          .filter(c -> c.getProgressDays() > 0 && c.getProgressDays() < c.getTotalDays())
          .count();
      int completedChallenges = (int) challenges.stream()
          .filter(c -> c.getProgressDays() >= c.getTotalDays())
          .count();
      int totalProgressDays = challenges.stream()
          .mapToInt(MentalHealthChallenge::getProgressDays)
          .sum();
      
      modelAndView.addObject("totalChallenges", totalChallenges);
      modelAndView.addObject("activeChallenges", activeChallenges);
      modelAndView.addObject("completedChallenges", completedChallenges);
      modelAndView.addObject("totalProgressDays", totalProgressDays);
    } else if (userRole.equals("mhp")) {
      List<MentalHealthChallengeType> challengeTypes = MentalHealthChallengeType.getByCreator(username);
      modelAndView.addObject("challengeTypes", challengeTypes);
      modelAndView.addObject("totalChallenges", challengeTypes.size());
    }
    
    modelAndView.addObject("userRole", userRole);
    modelAndView.addObject("username", username);
    
    return modelAndView;
  }
}





