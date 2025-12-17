package my.utm.mentalhealthapp.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MentalHealthChallengeType {
  private int id;
  private String title;
  private String description;
  private String creator;
  private int totalDays;
  private ArrayList<String> activities;

  private static List<MentalHealthChallengeType> list = Arrays.asList(
      new MentalHealthChallengeType().setId(1).setTitle("30-Day Gratitude Journey").setDescription(
          "Develop a daily gratitude practice to improve mental well-being and positive thinking.")
          .setCreator("Dr. Sarah Johnson").setTotalDays(30).setActivities(
              new ArrayList<>(Arrays.asList("Write a gratitude journal",
                  "Share gratitude with others", "Reflect on positive moments"))),
      new MentalHealthChallengeType().setId(2).setTitle("Mindful Breathing Challenge")
          .setDescription(
              "Practice mindfulness through daily breathing exercises to reduce stress and anxiety.")
          .setCreator("Dr. Michael Chen").setTotalDays(21)
          .setActivities(new ArrayList<>(Arrays.asList("Morning breathing exercise",
              "Midday mindfulness", "Evening relaxation"))),
      new MentalHealthChallengeType().setId(3).setTitle("Self-Compassion Practice").setDescription(
          "Learn to treat yourself with kindness and understanding through daily self-compassion exercises.")
          .setCreator("Dr. Sarah Johnson").setTotalDays(14)
          .setActivities(new ArrayList<>(Arrays.asList("Daily affirmations",
              "Self-compassion meditation", "Journaling self-kindness"))),
      new MentalHealthChallengeType().setId(4).setTitle("Stress Management Workshop")
          .setDescription(
              "Learn effective techniques to manage stress and improve your mental resilience.")
          .setCreator("Dr. Emily Carter").setTotalDays(10)
          .setActivities(new ArrayList<>(Arrays.asList("Identify stress triggers",
              "Practice stress-relief techniques", "Develop a stress management plan"))));

  public MentalHealthChallengeType() {

  }

  /* Setter Method */
  public MentalHealthChallengeType setId(int id) {
    this.id = id;
    return this; // Returns the current object for chaining
  }

  public MentalHealthChallengeType setTitle(String title) {
    this.title = title;
    return this; // Returns the current object for chaining
  }

  public MentalHealthChallengeType setDescription(String description) {
    this.description = description;
    return this; // Returns the current object for chaining
  }

  public MentalHealthChallengeType setCreator(String creator) {
    this.creator = creator;
    return this; // Returns the current object for chaining
  }

  public MentalHealthChallengeType setTotalDays(int totalDays) {
    this.totalDays = totalDays;
    return this; // Returns the current object for chaining
  }

  public MentalHealthChallengeType setActivities(ArrayList<String> activities) {
    this.activities = activities;
    return this; // Returns the current object for chaining
  }

  /* Getter Method */
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

  public ArrayList<String> getActivities() {
    return activities;
  }

  /* Static Method */
  public static List<MentalHealthChallengeType> getAll() {
    return list;
  }

  public static MentalHealthChallengeType getById(int id) {
    return getAll().stream().filter(c -> c.getId() == id).findFirst().orElse(null);
  }

  public static List<MentalHealthChallengeType> getByCreator(String creator) {
    return getAll().stream().filter(c -> c.getCreator().equals(creator)).toList();
  }
}
