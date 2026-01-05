package my.utm.mentalhealthapp.dao;

import my.utm.mentalhealthapp.entity.MentalHealthChallengeType;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class MentalHealthChallengeTypeDAO {

    @Autowired
    private SessionFactory sessionFactory;

    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * Replaces the static add() and manual update logic.
     */
    public void saveOrUpdate(MentalHealthChallengeType type) {
        getSession().saveOrUpdate(type);
    }

    /**
     * Replaces the static getById() method.
     */
    public MentalHealthChallengeType getById(int id) {
        return getSession().get(MentalHealthChallengeType.class, id);
    }

    /**
     * Replaces the static getByCreator() method.
     */
    public List<MentalHealthChallengeType> getByCreator(String creator) {
        String hql = "FROM MentalHealthChallengeType WHERE creator = :creatorName";
        return getSession().createQuery(hql, MentalHealthChallengeType.class)
                .setParameter("creatorName", creator).list();
    }

    /**
     * Replaces the static getAll() method.
     */
    public List<MentalHealthChallengeType> getAll() {
        return getSession()
                .createQuery("FROM MentalHealthChallengeType", MentalHealthChallengeType.class)
                .list();
    }

    /**
     * Replaces the static removeById() method.
     */
    public void delete(int id) {
        MentalHealthChallengeType type = getById(id);
        if (type != null) {
            getSession().delete(type);
        }
    }
}
