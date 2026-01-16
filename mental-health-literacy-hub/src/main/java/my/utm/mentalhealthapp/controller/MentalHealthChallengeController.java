package my.utm.mentalhealthapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import my.utm.mentalhealthapp.dao.AuditLogDAO;
// Import DAOs
import my.utm.mentalhealthapp.dao.DailyReflectionDAO;
import my.utm.mentalhealthapp.dao.MentalHealthChallengeDAO;
import my.utm.mentalhealthapp.dao.MentalHealthChallengeTypeDAO;
import my.utm.mentalhealthapp.dao.UserDAO;
// Import Entities
import my.utm.mentalhealthapp.entity.DailyReflection;
import my.utm.mentalhealthapp.entity.MentalHealthChallenge;
import my.utm.mentalhealthapp.entity.MentalHealthChallengeType;
import my.utm.mentalhealthapp.entity.User;
import my.utm.mentalhealthapp.model.Feeling;
import my.utm.mentalhealthapp.util.BeanUtil;
import my.utm.mentalhealthapp.model.MoodDataDTO;

@Controller
@RequestMapping("/mental-health-challenge")
public class MentalHealthChallengeController {

    // Inject the DAOs
    @Autowired
    private DailyReflectionDAO reflectionDAO;

    @Autowired
    private MentalHealthChallengeDAO challengeDAO;

    @Autowired
    private MentalHealthChallengeTypeDAO typeDAO;

    @Autowired
    private UserDAO userDAO;

    private String getUserFromSession(HttpSession session) {
        return (String) session.getAttribute("username");
    }

    private ModelAndView setStudentHome(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("display_mental_health_challenge");
        String user = this.getUserFromSession(session);

        AuditLogDAO auditLogDAO = BeanUtil.getBean(AuditLogDAO.class);

        // Refactored: Use DAO to get challenges from DB
        modelAndView.addObject("challenges", challengeDAO.getByUser(user));
        modelAndView.addObject("log_activity", auditLogDAO.getLogsByUser(user));

        return modelAndView;
    }

    private ModelAndView setMHPHome(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("manage_mental_health_challenge");
        String user = this.getUserFromSession(session);
        AuditLogDAO auditLogDAO = BeanUtil.getBean(AuditLogDAO.class);

        // Refactored: Use DAO to get challenge types by creator
        modelAndView.addObject("challengeTypes", typeDAO.getByCreator(user));
        modelAndView.addObject("mhp_activity", auditLogDAO.getLogsByUser(user));
        return modelAndView;
    }

    @GetMapping("/")
    public ModelAndView home(HttpSession session) {
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null) {
            return new ModelAndView("redirect:/mental-health-challenge/demo");
        }
        return userRole.equals("student") ? this.setStudentHome(session) : this.setMHPHome(session);
    }

    @GetMapping("/challenge/{id}")
    public ModelAndView challengeDetails(@PathVariable("id") int id, HttpSession session) {
        // Refactored: Fetch specific challenge from DB
        MentalHealthChallenge challenge = challengeDAO.getById(id);

        ModelAndView modelAndView = new ModelAndView("challenge_details");
        modelAndView.addObject("feelings", Arrays.asList(Feeling.values()));
        modelAndView.addObject("mode", "overview");

        // Verify ownership
        if (challenge != null && challenge.getUser().equals(getUserFromSession(session))) {
            modelAndView.addObject("challenge", challenge);
        } else {
            modelAndView.setViewName("redirect:/mental-health-challenge/");
        }
        return modelAndView;
    }

    @GetMapping("/challenge/{id}/progress")
    public ModelAndView challengeProgress(@PathVariable("id") int id, HttpSession session) {
        // Refactored: Fetch specific challenge from DB
        MentalHealthChallenge challenge = challengeDAO.getById(id);

        ModelAndView modelAndView = new ModelAndView("challenge_progress");
        modelAndView.addObject("mode", "progress");

        // Verify ownership
        if (challenge != null && challenge.getUser().equals(getUserFromSession(session))) {
            modelAndView.addObject("challenge", challenge);
        } else {
            modelAndView.setViewName("redirect:/mental-health-challenge/");
        }
        return modelAndView;
    }

    @PostMapping("/challenge/{id}/submit")
    public String submitDailyReflection(@RequestParam String reflection,
            @RequestParam String feeling, @PathVariable int id, HttpSession session) {

        MentalHealthChallenge challenge = challengeDAO.getById(id);
        if (challenge != null) {
            DailyReflection newReflection = new DailyReflection().setDate(LocalDateTime.now())
                    .setFeeling(feeling).setReflection(reflection);

            // Use helper method in entity to set the bidirectional link
            challenge.addDailyReflection(newReflection);
            this.challengeDAO.update(challenge);
        }

        return "redirect:/mental-health-challenge/challenge/" + id;
    }

    @GetMapping("/challenge/{id}/manage")
    public ModelAndView manageDetailChallenge(@PathVariable("id") int id, HttpSession session) {
        // Refactored: Fetch specific challenge from DB
        MentalHealthChallengeType challengeType = typeDAO.getById(id);
        ModelAndView modelAndView = new ModelAndView("manage_challenge_details");

        // Verify ownership
        if (challengeType != null
                && challengeType.getCreator().equals(getUserFromSession(session))) {
            modelAndView.addObject("challengeType", challengeType);
        } else {
            modelAndView.setViewName("redirect:/mental-health-challenge/");
        }
        return modelAndView;
    }

    @PostMapping("/create")
    public String createChallenge(@RequestParam String title, @RequestParam String description,
            @RequestParam int totalDays, @RequestParam Set<String> activities,
            HttpSession session) {

        List<String> users =
                this.userDAO.getAll().stream().filter(user -> user.getRole().equals("student"))
                        .map(User::getName).collect(Collectors.toList());
        String userRole = (String) session.getAttribute("userRole");
        if (!"mhp".equals(userRole))
            return "redirect:/mental-health-challenge/";

        MentalHealthChallengeType challengeType =
                new MentalHealthChallengeType().setTitle(title).setDescription(description)
                        .setTotalDays(totalDays).setActivities(new LinkedHashSet(activities))
                        .setCreator(getUserFromSession(session));

        // Refactored: Save to DB via DAO
        typeDAO.saveOrUpdate(challengeType);

        // Create Mental Health Challenge for each user
        for (String user : users) {
            this.challengeDAO.saveOrUpdate(
                    new MentalHealthChallenge().setTChallengeType(challengeType).setUser(user));
        }
        return "redirect:/mental-health-challenge/";
    }

    @PostMapping("/challenge/{id}/delete")
    public String deleteChallenge(@PathVariable("id") int id, HttpSession session) {
        String userRole = (String) session.getAttribute("userRole");
        if ("mhp".equals(userRole)) {
            // Refactored: Use DAO for deletion
            typeDAO.delete(id);
        }
        return "redirect:/mental-health-challenge/";
    }

    @PostMapping("/challenge/{id}/update")
    public String updateChallenge(@RequestParam String title, @RequestParam String description,
            @RequestParam int totalDays, @RequestParam Set<String> activities, @PathVariable int id,
            HttpSession session) {

        if (!"mhp".equals(session.getAttribute("userRole"))) {
            return "redirect:/mental-health-challenge/";
        }

        // Refactored: Get from DB, update, and save
        MentalHealthChallengeType existingType = typeDAO.getById(id);
        if (existingType != null) {
            existingType.setTitle(title).setDescription(description).setTotalDays(totalDays)
                    .setActivities(new LinkedHashSet<String>(activities));
            typeDAO.saveOrUpdate(existingType);
        }

        return "redirect:/mental-health-challenge/";
    }

    // Demo mappings remain similar as they mostly handle session
    @GetMapping("/demo")
    public ModelAndView demo() {
        return new ModelAndView("demo_choose_role");
    }

    @PostMapping("/demo")
    public String handleDemoRoleSelection(@RequestParam String role, HttpSession session) {
        session.setAttribute("userRole", role);
        String username = role.equals("student") ? "user" : "Dr. Sarah Johnson";
        session.setAttribute("username", username);
        return "redirect:/mental-health-challenge/";
    }

    @GetMapping(value = "/daily-reflection/{id}", produces = "application/json")
    @ResponseBody
    public List<MoodDataDTO> getMoodChartData(@PathVariable("id") int id) {

        // 1. Fetch the entity
        MentalHealthChallenge challenge = challengeDAO.getById(id);

        if (challenge == null)
            return null;

        // 2. Map reflections to the DTO format the Chart needs
        return challenge.getDailyReflections().stream()
                .map(ref -> new MoodDataDTO(ref.getDate().toLocalDate().getDayOfWeek().toString(),

                        ref.getFeeling().getFeelingValue()))
                .collect(Collectors.toList());
    }
}
