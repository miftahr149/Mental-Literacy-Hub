package my.utm.mentalhealthapp.dao;

import my.utm.mentalhealthapp.entity.MentalHealthChallenge;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class MentalHealthChallengeDAO {

    @Autowired
    private SessionFactory sessionFactory;

    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * Saves or updates the challenge. Uses the fluent pattern returning 'this' from the entity.
     */
    public void saveOrUpdate(MentalHealthChallenge challenge) {
        getSession().saveOrUpdate(challenge);
    }

    public MentalHealthChallenge getById(int id) {
        return getSession().get(MentalHealthChallenge.class, id);
    }

    /**
     * Replaces your static getByUser(String user) method.
     */
    public List<MentalHealthChallenge> getByUser(String user) {
        String hql = "FROM MentalHealthChallenge WHERE user = :userName";
        return getSession().createQuery(hql, MentalHealthChallenge.class)
                .setParameter("userName", user).list();
    }

    public List<MentalHealthChallenge> getAll() {
        return getSession().createQuery("FROM MentalHealthChallenge", MentalHealthChallenge.class)
                .list();
    }

    /**
     * Replaces your static removeById(int id) method.
     */
    public void delete(int id) {
        MentalHealthChallenge challenge = getById(id);
        if (challenge != null) {
            getSession().delete(challenge);
        }
    }
}
