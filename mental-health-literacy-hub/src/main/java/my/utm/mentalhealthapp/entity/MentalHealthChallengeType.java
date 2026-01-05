package my.utm.mentalhealthapp.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "challenge_types")
public class MentalHealthChallengeType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "description", length = 1000)
    private String description;

    @Column(name = "creator")
    private String creator;

    @Column(name = "total_days")
    private int totalDays;

    // Stores the list of activities in a collection table
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "challenge_activities",
            joinColumns = @JoinColumn(name = "challenge_type_id"))
    @Column(name = "activity_name")
    private List<String> activities = new ArrayList<>();

    // Default Constructor required by Hibernate
    public MentalHealthChallengeType() {}

    /* --- Setters (Fluent Pattern) --- */

    public MentalHealthChallengeType setId(int id) {
        this.id = id;
        return this;
    }

    public MentalHealthChallengeType setTitle(String title) {
        this.title = title;
        return this;
    }

    public MentalHealthChallengeType setDescription(String description) {
        this.description = description;
        return this;
    }

    public MentalHealthChallengeType setCreator(String creator) {
        this.creator = creator;
        return this;
    }

    public MentalHealthChallengeType setTotalDays(int totalDays) {
        this.totalDays = totalDays;
        return this;
    }

    public MentalHealthChallengeType setActivities(List<String> activities) {
        this.activities = activities;
        return this;
    }

    /* --- Getters --- */

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getCreator() {
        return creator;
    }

    public int getTotalDays() {
        return totalDays;
    }

    public List<String> getActivities() {
        return activities;
    }
}
