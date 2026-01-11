package my.utm.mentalhealthapp.listener;

import java.time.LocalDateTime;
import javax.persistence.PostPersist;
import javax.persistence.PostUpdate;
import javax.persistence.PreRemove;
import my.utm.mentalhealthapp.dao.AuditLogDAO;
import my.utm.mentalhealthapp.entity.AuditLog;
import my.utm.mentalhealthapp.entity.MentalHealthChallengeType;
import my.utm.mentalhealthapp.util.BeanUtil;

public class MentalHealthChallengeTypeListener {
    @PostPersist
    public void afterCreate(MentalHealthChallengeType type) {
        AuditLogDAO logDAO = BeanUtil.getBean(AuditLogDAO.class);
        logDAO.save(
                new AuditLog().setAction("MHP_CREATE_CHALLENGE").setTargetEntity("ChallengeType")
                        .setTargetId(type.getId()).setPerformedBy(type.getCreator())
                        .setLogMessage("MHP created a new challenge template: " + type.getTitle())
                        .setTimestamp(LocalDateTime.now()));
    }

    @PreRemove
    public void beforeDelete(MentalHealthChallengeType type) {
        AuditLogDAO logDAO = BeanUtil.getBean(AuditLogDAO.class);
        logDAO.save(
                new AuditLog().setAction("MHP_DELETE_CHALLENGE").setTargetEntity("ChallengeType")
                        .setTargetId(type.getId()).setPerformedBy(type.getCreator())
                        .setLogMessage("MHP deleted the challenge " + type.getTitle())
                        .setTimestamp(LocalDateTime.now()));
    }

    @PostUpdate
    public void afterUpdate(MentalHealthChallengeType type) {
        AuditLogDAO logDAO = BeanUtil.getBean(AuditLogDAO.class);

        logDAO.save(
                new AuditLog().setAction("MHP_UPDATE_CHALLENGE").setTargetEntity("ChallengeType")
                        .setTargetId(type.getId()).setPerformedBy(type.getCreator())
                        .setLogMessage("MHP updated the challenge " + type.getTitle()));
    }
}
