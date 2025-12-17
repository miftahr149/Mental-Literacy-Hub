package my.utm.mentalhealthapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import my.utm.mentalhealthapp.model.DailyReflection;
import my.utm.mentalhealthapp.model.Feeling;
import my.utm.mentalhealthapp.model.MentalHealthChallenge;
import my.utm.mentalhealthapp.model.MentalHealthChallengeType;

@Controller
@RequestMapping("/mental-health-challenge")
public class MentalHealthChallengeController {

  private String getUserFromSession(HttpSession session) {
    String user = (String) session.getAttribute("username");
    return user;
  }

  private ModelAndView setStudentHome(HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("display_mental_health_challenge");

    String user = this.getUserFromSession(session);
    modelAndView.addObject("challenges", MentalHealthChallenge.getByUser(user));

    return modelAndView;
  }

  private ModelAndView setMHPHome(HttpSession session) {
    ModelAndView modelAndView = new ModelAndView("manage_mental_health_challenge");

    String user = this.getUserFromSession(session);
    modelAndView.addObject("challengeTypes", MentalHealthChallengeType.getByCreator(user));

    return modelAndView;
  }


  @GetMapping("/")
  public ModelAndView home(HttpSession session) {
    String userRole = (String) session.getAttribute("userRole");

    if (userRole == null) {
      return new ModelAndView("redirect:/mental-health-challenge/demo");
    }

    boolean isStudent = userRole.equals("student");
    ModelAndView modelAndView = isStudent ? this.setStudentHome(session) : this.setMHPHome(session);
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

    String username = role.equals("student") ? "user" : "Dr. Sarah Johnson";
    session.setAttribute("username", username);

    return "redirect:/mental-health-challenge/";
  }

  @GetMapping("/challenge/{id}")
  public ModelAndView challengeDetails(@PathVariable("id") int id, HttpSession session) {
    String user = this.getUserFromSession(session);
    MentalHealthChallenge challenge = MentalHealthChallenge.getUserChallengeById(user, id);

    ModelAndView modelAndView = new ModelAndView("challenge_details");

    List<Feeling> feelings = Arrays.asList(Feeling.values());
    modelAndView.addObject("feelings", feelings);
    modelAndView.addObject("mode", "overview");


    if (challenge != null) {
      modelAndView.addObject("challenge", challenge);
    } else {
      modelAndView.setViewName("redirect:/mental-health-challenge/");
    }
    return modelAndView;
  }

  @GetMapping("/challenge/{id}/manage")
  public ModelAndView manageChallengeDetails(@PathVariable("id") int id, HttpSession session) {
    ModelAndView errorView = new ModelAndView("redirect:/mental-health-challenge/");

    String userRole = (String) session.getAttribute("userRole");
    if (!userRole.equals("mhp")) {
      return errorView;
    }

    String username = this.getUserFromSession(session);
    MentalHealthChallengeType challengeType = MentalHealthChallengeType.getById(id);
    if (!challengeType.getCreator().equals(username)) {
      return errorView;
    }

    ModelAndView modelAndView = new ModelAndView("manage_challenge_details");
    modelAndView.addObject("challengeType", challengeType);
    return modelAndView;
  }

  @PostMapping("/challenge/{id}/submit")
  public ModelAndView submitDailyReflection(@ModelAttribute DailyReflection reflection,
      @PathVariable int id, HttpSession session) {

    String user = this.getUserFromSession(session);

    reflection.setMentalHealthChallengeID(id);
    reflection.setDate(LocalDateTime.now());
    MentalHealthChallenge challenge = MentalHealthChallenge.getUserChallengeById(user, id);
    challenge.addDailyReflection(reflection);

    String viewName = String.format("redirect:/mental-health-challenge/challenge/%d", id);
    ModelAndView modelAndView = new ModelAndView(viewName);
    return modelAndView;
  }

  @GetMapping("/challenge/{id}/progress")
  public ModelAndView challengeProgress(@PathVariable int id, HttpSession session) {
    String user = this.getUserFromSession(session);
    MentalHealthChallenge challenge = MentalHealthChallenge.getUserChallengeById(user, id);

    ModelAndView modelAndView = new ModelAndView("challenge_progress");

    List<Feeling> feelings = Arrays.asList(Feeling.values());
    modelAndView.addObject("mode", "progress");


    if (challenge != null) {
      modelAndView.addObject("challenge", challenge);
    } else {
      modelAndView.setViewName("redirect:/mental-health-challenge/");
    }
    return modelAndView;
  }
}
