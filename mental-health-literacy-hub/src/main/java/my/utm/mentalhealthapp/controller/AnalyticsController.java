package my.utm.mentalhealthapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import my.utm.mentalhealthapp.service.AnalyticsService;

@Controller
@RequestMapping("/analytics")
public class AnalyticsController {

    @Autowired
    private AnalyticsService analyticsService;

    @GetMapping
    public String analyticsPage(Model model) {

        model.addAttribute("usersEngaged", analyticsService.getUserCount());
        model.addAttribute("resourcesUsed", analyticsService.getResourceCount());
        model.addAttribute("feedbackCount", analyticsService.getFeedbackCount());

        String feedbackJson = new Gson().toJson(analyticsService.getFeedbackSummary());

        model.addAttribute("feedbackSummaryJson", feedbackJson);

        return "report_analytics"; // analytics.jsp
    }
}
