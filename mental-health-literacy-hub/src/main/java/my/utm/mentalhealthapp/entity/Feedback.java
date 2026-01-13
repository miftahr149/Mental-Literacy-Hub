package my.utm.mentalhealthapp.entity;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "feedback")
public class Feedback {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "user_id", nullable = false)
    private int userId;

    @Column(name = "user_name", nullable = false)
    private String userName;

    @Column(name = "user_email", nullable = false)
    private String userEmail;

    @Column(name = "user_role", nullable = false)
    private String userRole;

    @Column(name = "message", nullable = false, columnDefinition = "TEXT")
    private String message;

    @Column(name = "status")
    private String status; // "pending", "in-review", "responded"

    @Column(name = "response", columnDefinition = "TEXT")
    private String response;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    public Feedback() {
        this.status = "pending";
    }

    public Feedback(int userId, String userName, String userEmail, String userRole,
            String message) {
        this.userId = userId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userRole = userRole;
        this.message = message;
        this.status = "pending";
        this.response = null;
    }

    /* Getter Methods */
    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getUserName() {
        return userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public String getUserRole() {
        return userRole;
    }

    public String getMessage() {
        return message;
    }

    public String getStatus() {
        return status;
    }

    public String getResponse() {
        return response;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public String getCreatedAtFormatted() {
        if (createdAt == null)
            return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return createdAt.format(formatter);
    }

    /* Setter Methods */
    public Feedback setId(int id) {
        this.id = id;
        return this;
    }

    public Feedback setUserId(int userId) {
        this.userId = userId;
        return this;
    }

    public Feedback setUserName(String userName) {
        this.userName = userName;
        return this;
    }

    public Feedback setUserEmail(String userEmail) {
        this.userEmail = userEmail;
        return this;
    }

    public Feedback setUserRole(String userRole) {
        this.userRole = userRole;
        return this;
    }

    public Feedback setMessage(String message) {
        this.message = message;
        return this;
    }

    public Feedback setStatus(String status) {
        this.status = status;
        return this;
    }

    public Feedback setResponse(String response) {
        this.response = response;
        return this;
    }

    public Feedback setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
        return this;
    }
}
