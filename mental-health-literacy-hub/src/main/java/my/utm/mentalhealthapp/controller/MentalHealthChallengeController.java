package my.utm.mentalhealthapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpSession;

import my.utm.mentalhealthapp.model.MentalHealthChallenge;

@Controller
@RequestMapping("/mental-health-challenge")
public class MentalHealthChallengeController {

  @GetMapping("/")
  public ModelAndView home(HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("mental_health_challenge");
    if (session.getAttribute("userRole") == null) {
      modelAndView.setViewName("redirect:/mental-health-challenge/demo");
      return modelAndView;
    }

    modelAndView.addObject("challenges", MentalHealthChallenge.getAll());
    return modelAndView;
  }

  @GetMapping("/demo")
  public ModelAndView demo() {
    ModelAndView modelAndView = new ModelAndView("demo_choose_role");
    return modelAndView;
  }

  @PostMapping("/demo")
  public String handleDemoRoleSelection(@RequestParam(name = "role", required = true) String role,
      HttpSession session) {
    session.setAttribute("userRole", role);
    return "redirect:/mental-health-challenge/";
  }
}
