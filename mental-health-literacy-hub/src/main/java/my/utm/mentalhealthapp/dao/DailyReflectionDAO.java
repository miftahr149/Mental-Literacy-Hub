package my.utm.mentalhealthapp.dao;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import my.utm.mentalhealthapp.entity.DailyReflection;

@Repository
@Transactional
public class DailyReflectionDAO {

    @Autowired
    private SessionFactory sessionFactory;

    /**
     * Helper method to get the current Hibernate session.
     */
    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * Save or update a daily reflection.
     */
    public void saveOrUpdate(DailyReflection reflection) {
        getSession().saveOrUpdate(reflection);
    }

    /**
     * Retrieve a reflection by its primary key ID.
     */
    public DailyReflection getById(int id) {
        return getSession().get(DailyReflection.class, id);
    }

    /**
     * Retrieve all reflections for a specific Mental Health Challenge. This uses the relationship
     * mapping we defined in the entity.
     */
    public List<DailyReflection> getByChallengeId(int challengeId) {
        String hql = "FROM DailyReflection WHERE challenge.id = :cId ORDER BY date DESC";
        Query<DailyReflection> query = getSession().createQuery(hql, DailyReflection.class);
        query.setParameter("cId", challengeId);
        return query.list();
    }

    /**
     * Retrieve all reflection records.
     */
    public List<DailyReflection> getAll() {
        return getSession().createQuery("FROM DailyReflection", DailyReflection.class).list();
    }

    /**
     * Delete a reflection by its ID.
     */
    public void delete(int id) {
        DailyReflection reflection = getById(id);
        if (reflection != null) {
            getSession().delete(reflection);
        }
    }
}
