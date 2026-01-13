package my.utm.mentalhealthapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpSession;
import my.utm.mentalhealthapp.entity.MentalHealthChallenge;
import my.utm.mentalhealthapp.entity.MentalHealthChallengeType;
import my.utm.mentalhealthapp.entity.User;
import my.utm.mentalhealthapp.dao.UserDAO;
import my.utm.mentalhealthapp.dao.MentalHealthChallengeDAO;
import my.utm.mentalhealthapp.dao.MentalHealthChallengeTypeDAO;
import java.util.List;

@Controller
@RequestMapping("/analytics")
public class AnalyticsController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private MentalHealthChallengeDAO mentalHealthChallengeDAO;

    @Autowired
    private MentalHealthChallengeTypeDAO mentalHealthChallengeTypeDAO;

    @GetMapping("/")
    public ModelAndView analytics(HttpSession session) {
        String userRole = (String) session.getAttribute("userRole");

        if (userRole == null) {
            return new ModelAndView("redirect:/auth/login");
        }

        ModelAndView modelAndView = new ModelAndView("report_analytics");

        // Calculate real analytics data
        List<User> allUsers = userDAO.getAll();
        List<MentalHealthChallengeType> allChallenges = mentalHealthChallengeTypeDAO.getAll();
        List<MentalHealthChallenge> allUserChallenges = mentalHealthChallengeDAO.getAll();

        // Calculate statistics
        int totalUsers = allUsers.size();
        int totalChallenges = allChallenges.size();
        int totalReflections =
                allUserChallenges.stream().mapToInt(c -> c.getDailyReflections().size()).sum();

        // Active users (users with at least one challenge)
        long activeUsers =
                allUserChallenges.stream().map(MentalHealthChallenge::getUser).distinct().count();

        // Calculate challenge completion rate
        int completedChallenges = (int) allUserChallenges.stream()
                .filter(c -> c.getProgressDays() >= c.getTotalDays()).count();

        // Calculate average mood across all reflections
        double totalMood = 0;
        int moodCount = 0;
        for (MentalHealthChallenge challenge : allUserChallenges) {
            if (challenge.getDailyReflections().size() > 0) {
                totalMood += challenge.getAverageMood();
                moodCount++;
            }
        }
        double averageMood = moodCount > 0 ? totalMood / moodCount : 0;

        // Add data to model
        modelAndView.addObject("totalUsers", totalUsers);
        modelAndView.addObject("activeUsers", activeUsers);
        modelAndView.addObject("totalChallenges", totalChallenges);
        modelAndView.addObject("totalReflections", totalReflections);
        modelAndView.addObject("completedChallenges", completedChallenges);
        modelAndView.addObject("averageMood", String.format("%.1f", averageMood));
        modelAndView.addObject("userRole", userRole);

        // For charts - get challenge participation data
        modelAndView.addObject("challenges", allChallenges);
        modelAndView.addObject("userChallenges", allUserChallenges);

        return modelAndView;
    }
}

