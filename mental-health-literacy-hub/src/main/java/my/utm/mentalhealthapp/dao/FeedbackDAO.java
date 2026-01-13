package my.utm.mentalhealthapp.dao;

import my.utm.mentalhealthapp.entity.Feedback;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class FeedbackDAO {

    @Autowired
    private SessionFactory sessionFactory;

    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * Save or update a feedback.
     */
    public void saveOrUpdate(Feedback feedback) {
        getSession().saveOrUpdate(feedback);
    }

    /**
     * Update a feedback.
     */
    public void update(Feedback feedback) {
        getSession().merge(feedback);
    }

    /**
     * Retrieve a feedback by its primary key ID.
     */
    public Feedback getById(int id) {
        return getSession().get(Feedback.class, id);
    }

    /**
     * Retrieve all feedback records, ordered by creation date descending.
     */
    public List<Feedback> getAll() {
        String hql = "FROM Feedback ORDER BY createdAt DESC";
        return getSession().createQuery(hql, Feedback.class).list();
    }

    /**
     * Retrieve feedback by user ID, ordered by creation date descending.
     */
    public List<Feedback> getByUserId(int userId) {
        String hql = "FROM Feedback WHERE userId = :uId ORDER BY createdAt DESC";
        return getSession().createQuery(hql, Feedback.class).setParameter("uId", userId).list();
    }

    /**
     * Retrieve feedback by student role, ordered by creation date descending.
     */
    public List<Feedback> getByStudentRole() {
        String hql = "FROM Feedback WHERE userRole = 'student' ORDER BY createdAt DESC";
        return getSession().createQuery(hql, Feedback.class).list();
    }
}
