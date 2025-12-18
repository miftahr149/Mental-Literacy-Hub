package my.utm.mentalhealthapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/report-analytics")
public class ReportAnalyticsController {

    @GetMapping("/")
    public ModelAndView viewReportAnalytics() {
        System.out.println("Report Analytics Page Loaded");

        ModelAndView modelAndView = new ModelAndView("report_analytics");

        return modelAndView;
    }

    @GetMapping("/hello")
    public ModelAndView test() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("test");
        return modelAndView;
    }
}
