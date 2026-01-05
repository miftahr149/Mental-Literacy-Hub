package my.utm.mentalhealthapp.entity;

import javax.persistence.*;
import my.utm.mentalhealthapp.entity.MentalHealthChallengeType;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "mental_health_challenges")
public class MentalHealthChallenge {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "user_name", nullable = false)
    private String user;

    // Establishing a relationship with the ChallengeType entity
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "challenge_type_id")
    private MentalHealthChallengeType tChallengeType;

    // OrphanRemoval ensures reflections are deleted from DB if removed from this list
    @OneToMany(mappedBy = "challenge", cascade = CascadeType.ALL, orphanRemoval = true,
            fetch = FetchType.EAGER)
    @OrderColumn(name = "reflection_index")
    private List<DailyReflection> dailyReflections = new ArrayList<>();

    // Default Constructor required by Hibernate
    public MentalHealthChallenge() {}

    /* --- Setters (Fluent Pattern) --- */

    public MentalHealthChallenge setId(int id) {
        this.id = id;
        return this;
    }

    public MentalHealthChallenge setTChallengeType(MentalHealthChallengeType tChallengeType) {
        this.tChallengeType = tChallengeType;
        return this;
    }

    public MentalHealthChallenge setUser(String user) {
        this.user = user;
        return this;
    }

    public MentalHealthChallenge setDailyReflections(List<DailyReflection> dailyReflections) {
        this.dailyReflections = dailyReflections;
        return this;
    }

    /* --- Getters --- */
    public int getId() {
        return id;
    }

    public String getUser() {
        return user;
    }

    public MentalHealthChallengeType getTChallengeType() {
        return tChallengeType;
    }

    public List<DailyReflection> getDailyReflections() {
        return dailyReflections;
    }

    public String getTitle() {
        return this.tChallengeType.getTitle();
    }

    public String getDescription() {
        return this.tChallengeType.getDescription();
    }

    public String getCreator() {
        return this.tChallengeType.getCreator();
    }

    public int getTotalDays() {
        return this.tChallengeType.getTotalDays();
    }

    public List<String> getActivities() {
        return this.tChallengeType.getActivities();
    }

    /* --- Helper Methods for Business Logic --- */

    public void addDailyReflection(DailyReflection reflection) {
        dailyReflections.add(reflection);
        reflection.setChallenge(this); // Maintain bidirectional relationship
    }

    public int getProgressDays() {
        return this.dailyReflections.size();
    }

    // You can keep your logic for getAverageMood() and getCurrentStreak() here
    // as they operate on the loaded dailyReflections list.
    public double getAverageMood() {
        double totalMood = 0;
        for (DailyReflection reflection : this.getDailyReflections()) {
            totalMood += reflection.getFeeling().getFeelingValue();
        }
        return totalMood / this.getDailyReflections().size();
    }

    public int getCurrentStreak() {
        if (this.getDailyReflections().size() == 0) {
            return 0;
        }

        int currentStreak = 1;
        LocalDate previousReflectionDate = null;

        for (DailyReflection dailyReflection : this.getDailyReflections()) {
            LocalDate currentReflectionDate = dailyReflection.getDate().toLocalDate();

            if (previousReflectionDate == null) {
                previousReflectionDate = currentReflectionDate;
                continue;
            }

            LocalDate expectedReflectionDate = previousReflectionDate.plusDays(1);
            previousReflectionDate = currentReflectionDate;

            boolean isStreak = currentReflectionDate.isEqual(expectedReflectionDate);

            if (isStreak) {
                currentStreak++;
                continue;
            }

            currentStreak = 0;
        }

        return currentStreak;
    }

}
