package my.utm.mentalhealthapp.dao;

import my.utm.mentalhealthapp.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class UserDAO {

    @Autowired
    private SessionFactory sessionFactory;

    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * Save or update a user.
     */
    public void saveOrUpdate(User user) {
        getSession().saveOrUpdate(user);
    }

    /**
     * Update a user.
     */
    public void update(User user) {
        getSession().merge(user);
    }

    /**
     * Retrieve a user by its primary key ID.
     */
    public User getById(int id) {
        return getSession().get(User.class, id);
    }

    /**
     * Retrieve a user by email.
     */
    public User getByEmail(String email) {
        String hql = "FROM User WHERE email = :email";
        return getSession().createQuery(hql, User.class).setParameter("email", email)
                .uniqueResult();
    }

    /**
     * Retrieve all users.
     */
    public List<User> getAll() {
        return getSession().createQuery("FROM User", User.class).list();
    }

    /**
     * Check if an email exists.
     */
    public boolean emailExists(String email) {
        return getByEmail(email) != null;
    }

    /**
     * Authenticate a user by email and password.
     */
    public boolean authenticate(String email, String password) {
        if (email == null || password == null) {
            return false;
        }
        User user = getByEmail(email.trim());
        if (user == null) {
            return false;
        }
        // Trim password to handle whitespace issues
        return user.getPassword().equals(password.trim());
    }
}
