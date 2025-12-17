package my.utm.mentalhealthapp.model;

import java.time.LocalDateTime;
import java.util.ArrayList;

public class DailyReflection {
  private int mentalHealthChallengeID;
  private String reflection;
  private Feeling feeling;
  private LocalDateTime date;

  public DailyReflection() {}

  public DailyReflection(int MentalHealthChallengeID, String reflection, String feeling,
      LocalDateTime date) {

    this.mentalHealthChallengeID = mentalHealthChallengeID;
    this.reflection = reflection;
    this.feeling = Feeling.valueOf(feeling.toUpperCase());
    this.date = date;
  }

  public void setReflection(String newReflection) {
    this.reflection = newReflection;
  }

  public void setMentalHealthChallengeID(int mentalHealthChallengeID) {
    this.mentalHealthChallengeID = mentalHealthChallengeID;
  }

  public void setFeeling(String feeling) {
    this.feeling = Feeling.valueOf(feeling);
  }

  public void setDate(LocalDateTime date) {
    this.date = date;
  }

  public int getMentalHealthChallengeID() {
    return this.mentalHealthChallengeID;
  }

  public String getReflection() {
    return this.reflection;
  }

  public String getDate() {
    return this.date.toString();
  }

  public LocalDateTime getLocalDate() {
    return this.date;
  }

  public Feeling getFeeling() {
    return this.feeling;
  }
}
