package my.utm.mentalhealthapp.service;

import my.utm.mentalhealthapp.dao.UserDAO;
import my.utm.mentalhealthapp.dao.MentalHealthChallengeDAO;
import my.utm.mentalhealthapp.dao.MentalHealthChallengeTypeDAO;
import my.utm.mentalhealthapp.entity.User;
import my.utm.mentalhealthapp.entity.MentalHealthChallenge;
import my.utm.mentalhealthapp.entity.MentalHealthChallengeType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MentalHealthChallengeService {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private MentalHealthChallengeTypeDAO typeDAO;

    @Autowired
    private MentalHealthChallengeDAO challengeDAO;

    @Transactional
    public void generateMentalHealth(User user) {
        // 2. Logic for student auto-enrollment
        if (!"student".equals(user.getRole()))
            return;
        List<MentalHealthChallengeType> allTypes = typeDAO.getAll();

        for (MentalHealthChallengeType type : allTypes) {
            MentalHealthChallenge challenge = new MentalHealthChallenge();
            challenge.setUser(user.getName()) // Linking by name as per your entity
                    .setTChallengeType(type);

            challengeDAO.saveOrUpdate(challenge);
        }
    }
}
