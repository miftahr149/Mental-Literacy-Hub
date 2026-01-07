package my.utm.mentalhealthapp.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "audit_logs")
public class AuditLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String action;

    @Column(name = "target_entity")
    private String targetEntity;

    @Column(name = "target_id")
    private int targetId;

    @Column(name = "performed_by")
    private String performedBy;

    @Column(name = "log_message", length = 500)
    private String logMessage;

    @Column(name = "timestamp")
    private LocalDateTime timestamp;

    // Default Constructor
    public AuditLog() {
        this.timestamp = LocalDateTime.now();
    }

    // Parameterized Constructor
    public AuditLog(String action, String targetEntity, int targetId, String performedBy,
            String logMessage) {
        this.action = action;
        this.targetEntity = targetEntity;
        this.targetId = targetId;
        this.performedBy = performedBy;
        this.logMessage = logMessage;
        this.timestamp = LocalDateTime.now();
    }

    /* --- Fluent Setters --- */

    public AuditLog setId(int id) {
        this.id = id;
        return this;
    }

    public AuditLog setAction(String action) {
        this.action = action;
        return this;
    }

    public AuditLog setTargetEntity(String targetEntity) {
        this.targetEntity = targetEntity;
        return this;
    }

    public AuditLog setTargetId(int targetId) {
        this.targetId = targetId;
        return this;
    }

    public AuditLog setPerformedBy(String performedBy) {
        this.performedBy = performedBy;
        return this;
    }

    public AuditLog setLogMessage(String logMessage) {
        this.logMessage = logMessage;
        return this;
    }

    public AuditLog setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
        return this;
    }

    /* --- Standard Getters --- */

    public int getId() {
        return id;
    }

    public String getAction() {
        return action;
    }

    public String getTargetEntity() {
        return targetEntity;
    }

    public int getTargetId() {
        return targetId;
    }

    public String getPerformedBy() {
        return performedBy;
    }

    public String getLogMessage() {
        return logMessage;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }
}
