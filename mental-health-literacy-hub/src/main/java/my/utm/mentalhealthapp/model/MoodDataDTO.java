package my.utm.mentalhealthapp.model;

public class MoodDataDTO {
  private String day;
  private int mood;

  public MoodDataDTO(String day, int mood) {
    this.day = day;
    this.mood = mood;
  }

  // Getters and Setters
  public String getDay() {
    return day;
  }

  public int getMood() {
    return mood;
  }
}
