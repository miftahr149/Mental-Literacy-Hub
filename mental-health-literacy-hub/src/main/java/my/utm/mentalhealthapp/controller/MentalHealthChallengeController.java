package my.utm.mentalhealthapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpSession;

import my.utm.mentalhealthapp.model.Feeling;
import my.utm.mentalhealthapp.model.MentalHealthChallenge;

@Controller
@RequestMapping("/mental-health-challenge")
public class MentalHealthChallengeController {

  @GetMapping("/")
  public ModelAndView home(HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("display_mental_health_challenge");
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

  @GetMapping("/challenge/{id}")
  public ModelAndView challengeDetails(@PathVariable("id") int id) {
    MentalHealthChallenge challenge = MentalHealthChallenge.getChallengeById(id);

    ModelAndView modelAndView = new ModelAndView("challenge_details");

    List<Feeling> feelings = Arrays.asList(Feeling.values());
    modelAndView.addObject("feelings", feelings);


    if (challenge != null) {
      modelAndView.addObject("challenge", challenge);
    } else {
      modelAndView.setViewName("redirect:/mental-health-challenge/");
    }
    return modelAndView;
  }
}
