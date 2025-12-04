package my.utm.mentalhealthapp.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MentalHealthChallenge {

  private int id;
  private String title;
  private String description;
  private String creator;
  private int totalDays;
  private int progressDays;
  private ArrayList<String> activities;

  private MentalHealthChallenge(Builder builder) {
    this.id = builder.id;
    this.title = builder.title;
    this.description = builder.description;
    this.creator = builder.creator;
    this.totalDays = builder.totalDays;
    this.progressDays = builder.progressDays;
    this.activities = builder.activities;
  }

  public static class Builder {
    private int id;
    private String title;
    private String description;
    private String creator;
    private int totalDays;
    private int progressDays;
    private ArrayList<String> activities;

    public Builder id(int id) {
      this.id = id;
      return this;
    }

    public Builder title(String title) {
      this.title = title;
      return this;
    }

    public Builder description(String description) {
      this.description = description;
      return this;
    }

    public Builder creator(String creator) {
      this.creator = creator;
      return this;
    }

    public Builder totalDays(int totalDays) {
      this.totalDays = totalDays;
      return this;
    }

    public Builder progressDays(int progressDays) {
      this.progressDays = progressDays;
      return this;
    }

    public Builder activities(ArrayList<String> activities) {
      this.activities = activities;
      return this;
    }

    public MentalHealthChallenge build() {
      return new MentalHealthChallenge(this);
    }
  }

  public static List<MentalHealthChallenge> getAll() {
    return Arrays.asList(new Builder().id(1).title("30-Day Gratitude Journey").description(
        "Develop a daily gratitude practice to improve mental well-being and positive thinking.")
        .creator("Dr. Sarah Johnson").totalDays(30).progressDays(2)
        .activities(new ArrayList<>(Arrays.asList("Write a gratitude journal",
            "Share gratitude with others", "Reflect on positive moments")))
        .build(),
        new Builder().id(2).title("Mindful Breathing Challenge").description(
            "Practice mindfulness through daily breathing exercises to reduce stress and anxiety.")
            .creator("Dr. Michael Chen").totalDays(21).progressDays(1)
            .activities(new ArrayList<>(Arrays.asList("Morning breathing exercise",
                "Midday mindfulness", "Evening relaxation")))
            .build(),
        new Builder().id(3).title("Self-Compassion Practice").description(
            "Learn to treat yourself with kindness and understanding through daily self-compassion exercises.")
            .creator("Dr. Sarah Johnson").totalDays(14).progressDays(0)
            .activities(new ArrayList<>(Arrays.asList("Daily affirmations",
                "Self-compassion meditation", "Journaling self-kindness")))
            .build(),
        new Builder().id(4).title("Stress Management Workshop")
            .description(
                "Learn effective techniques to manage stress and improve your mental resilience.")
            .creator("Dr. Emily Carter").totalDays(10).progressDays(5)
            .activities(new ArrayList<>(Arrays.asList("Identify stress triggers",
                "Practice stress-relief techniques", "Develop a stress management plan")))
            .build());
  }

  // Getters
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

  public int getProgressDays() {
    return progressDays;
  }

  public ArrayList<String> getActivities() {
    return activities;
  public static MentalHealthChallenge getChallengeById(int id) {
    return getAll().stream().filter(c -> c.getId() == id).findFirst().orElse(null);
  }
}
