package my.utm.mentalhealthapp.listener;

import javax.persistence.PostPersist;
import javax.persistence.PreRemove;
import my.utm.mentalhealthapp.dao.AuditLogDAO;
import my.utm.mentalhealthapp.entity.AuditLog;
import my.utm.mentalhealthapp.entity.MentalHealthChallenge;
import my.utm.mentalhealthapp.util.BeanUtil;

public class MentalHealthChallengeListener {
    @PostPersist
    public void afterSave(MentalHealthChallenge challenge) {
        AuditLogDAO logDAO = BeanUtil.getBean(AuditLogDAO.class);

        AuditLog audit = new AuditLog().setAction("CHALLENGE_CREATE")
                .setLogMessage(String.format("Create Challenge %s for user %s",
                        challenge.getTitle(), challenge.getUser()))
                .setPerformedBy(challenge.getCreator()).setTargetEntity("MentalHealthChallenge")
                .setTargetId(challenge.getTypeId());

        logDAO.save(audit);
        // You can use a DAO here to save an AuditLog record to the DB
    }
}
