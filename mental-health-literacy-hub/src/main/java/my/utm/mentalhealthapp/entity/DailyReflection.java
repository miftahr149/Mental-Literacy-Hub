package my.utm.mentalhealthapp.entity;

import my.utm.mentalhealthapp.model.Feeling;
import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "daily_reflections")
public class DailyReflection {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id; // Added a primary key for the table

    @Column(name = "reflection", length = 1000)
    private String reflection;

    @Enumerated(EnumType.STRING) // Maps the Enum as a String in the DB
    @Column(name = "feeling", nullable = false)
    private Feeling feeling;

    @Column(name = "date_created", nullable = false)
    private LocalDateTime date;

    // Relationship: Multiple reflections belong to one challenge
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "challenge_id")
    private MentalHealthChallenge challenge;

    // Default Constructor required by Hibernate [cite: 4]
    public DailyReflection() {}

    // --- Getters ---

    public int getId() {
        return id;
    }

    public String getReflection() {
        return reflection;
    }

    public Feeling getFeeling() {
        return feeling;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public MentalHealthChallenge getChallenge() {
        return challenge;
    }

    // --- Setters (Fluent Pattern) ---

    public DailyReflection setId(int id) {
        this.id = id;
        return this;
    }

    public DailyReflection setReflection(String reflection) {
        this.reflection = reflection;
        return this;
    }

    public DailyReflection setFeeling(Feeling feeling) {
        this.feeling = feeling;
        return this;
    }

    public DailyReflection setDate(LocalDateTime date) {
        this.date = date;
        return this;
    }

    public DailyReflection setChallenge(MentalHealthChallenge challenge) {
        this.challenge = challenge;
        return this;
    }
}
