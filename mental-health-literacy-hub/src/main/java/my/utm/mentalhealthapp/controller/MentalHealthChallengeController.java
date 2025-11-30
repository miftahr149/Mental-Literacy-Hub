package my.utm.mentalhealthapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/mental-health-challenge")
public class MentalHealthChallengeController {

  @GetMapping("/")
  public ModelAndView home() {
    ModelAndView modelAndView = new ModelAndView("mental_health_challenge");
    return modelAndView;
  }
}
