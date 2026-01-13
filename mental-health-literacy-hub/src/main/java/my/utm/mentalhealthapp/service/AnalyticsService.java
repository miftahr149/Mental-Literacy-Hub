package my.utm.mentalhealthapp.service;

import java.util.HashMap;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import my.utm.mentalhealthapp.dao.AnalyticsDAO;

@Service
@Transactional
public class AnalyticsService {

    @Autowired
    private AnalyticsDAO analyticsDao;

    public Long getUserCount() {
        return analyticsDao.countUsers();
    }

    public Long getResourceCount() {
        return analyticsDao.countResourcesUsed();
    }

    public Long getFeedbackCount() {
        return analyticsDao.countFeedback();
    }

    public Map<String, Long> getFeedbackSummary() {
        Map<String, Long> result = new HashMap<>();
        for (Object[] row : analyticsDao.feedbackSummary()) {
            result.put((String) row[0], (Long) row[1]);
        }
        return result;
    }

}
