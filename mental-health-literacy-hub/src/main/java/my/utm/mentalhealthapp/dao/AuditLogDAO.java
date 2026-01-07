package my.utm.mentalhealthapp.dao;

import my.utm.mentalhealthapp.entity.AuditLog;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class AuditLogDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    // Save a new log entry
    public void save(AuditLog log) {
        getSession().save(log);
    }

    // Retrieve all logs (useful for an admin dashboard)
    public List<AuditLog> getAllLogs() {
        return getSession().createQuery("from AuditLog order by timestamp desc", AuditLog.class)
                .list();
    }

    // Retrieve logs for a specific user
    public List<AuditLog> getLogsByUser(String username) {
        return getSession()
                .createQuery("from AuditLog where performedBy = :user order by timestamp desc",
                        AuditLog.class)
                .setParameter("user", username).list();
    }
}
