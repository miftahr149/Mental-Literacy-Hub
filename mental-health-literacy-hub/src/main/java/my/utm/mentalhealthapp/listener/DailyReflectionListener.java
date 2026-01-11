package my.utm.mentalhealthapp.listener;

import java.time.LocalDateTime;
import javax.persistence.PostPersist;
import my.utm.mentalhealthapp.dao.AuditLogDAO;
import my.utm.mentalhealthapp.entity.AuditLog;
import my.utm.mentalhealthapp.entity.DailyReflection;
import my.utm.mentalhealthapp.util.BeanUtil;

public class DailyReflectionListener {
    @PostPersist
    public void afterSubmit(DailyReflection reflection) {
        AuditLogDAO logDAO = BeanUtil.getBean(AuditLogDAO.class);
        logDAO.save(
                new AuditLog().setAction("SUBMIT_REFLECTION").setTargetEntity("DailyReflection")
                        .setTargetId(reflection.getId())
                        .setPerformedBy(reflection.getChallenge().getUser())
                        .setLogMessage("You completed a daily reflection for "
                                + reflection.getChallenge().getTitle())
                        .setTimestamp(reflection.getDate()));
    }
}
