package my.utm.mentalhealthapp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AnalyticsDAO {

    @Autowired
    private org.hibernate.SessionFactory sessionFactory;

    public Long countUsers() {
        return sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(u) FROM User u", Long.class)
                .uniqueResult();
    }

    public Long countResourcesUsed() {
        return sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(r) FROM ResourceUsage r", Long.class)
                .uniqueResult();
    }

    public Long countFeedback() {
        return sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(f) FROM Feedback f", Long.class)
                .uniqueResult();
    }

    public List<Object[]> feedbackSummary() {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT f.status, COUNT(f) FROM Feedback f GROUP BY f.status",
                        Object[].class)
                .list();
    }
}
