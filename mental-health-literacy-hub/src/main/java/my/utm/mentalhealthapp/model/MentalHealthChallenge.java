package my.utm.mentalhealthapp.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MentalHealthChallenge {

  private MentalHealthChallengeType tChallengeType;
  private String user;
  private ArrayList<DailyReflection> dailyReflections;

  private static List<MentalHealthChallenge> list = Arrays.asList(
      new MentalHealthChallenge().setTChallengeType(MentalHealthChallengeType.getById(1))
          .setUser("user")
          .setDailyReflections(new ArrayList<>(Arrays.asList(
              new DailyReflection(1, "Feeling grateful", "Good", LocalDateTime.now().minusDays(1)),
              new DailyReflection(1, "Reflecting on positive moments", "Great",
                  LocalDateTime.now())))),

      new MentalHealthChallenge().setTChallengeType(MentalHealthChallengeType.getById(2))
          .setUser("user")
          .setDailyReflections(new ArrayList<>(Arrays.asList(
              new DailyReflection(2, "Feeling calm", "Good", LocalDateTime.now().minusDays(1)),
              new DailyReflection(2, "Reflecting on positive moments", "Great",
                  LocalDateTime.now())))),

      new MentalHealthChallenge().setTChallengeType(MentalHealthChallengeType.getById(3))
          .setUser("user")
          .setDailyReflections(new ArrayList<>(Arrays.asList(
              new DailyReflection(3, "Feeling grateful", "Good", LocalDateTime.now().minusDays(1)),
              new DailyReflection(3, "Reflecting on positive moments", "Great",
                  LocalDateTime.now())))),

      new MentalHealthChallenge().setTChallengeType(MentalHealthChallengeType.getById(4))
          .setUser("user")
          .setDailyReflections(new ArrayList<>(Arrays.asList(
              new DailyReflection(4, "Feeling calm", "Good", LocalDateTime.now().minusDays(1)),
              new DailyReflection(4, "Reflecting on positive moments", "Great",
                  LocalDateTime.now())))));


  public MentalHealthChallenge() {

  }

  /* Setter Method */
  public MentalHealthChallenge setTChallengeType(MentalHealthChallengeType tChallengeType) {
    this.tChallengeType = tChallengeType;
    return this; // Returns the current object for chaining
  }

  // (The setUser method you provided):
  public MentalHealthChallenge setUser(String user) {
    this.user = user;
    return this; // Returns the current object for chaining
  }

  public MentalHealthChallenge setDailyReflections(ArrayList<DailyReflection> dailyReflections) {
    this.dailyReflections = dailyReflections;
    return this; // Returns the current object for chaining
  }

  /* Getter Method */
  public int getId() {
    return this.tChallengeType.getId();
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

  public ArrayList<String> getActivities() {
    return this.tChallengeType.getActivities();
  }

  public ArrayList<DailyReflection> getDailyReflections() {
    return dailyReflections;
  }

  public String getUser() {
    return user;
  }

  public void addDailyReflection(DailyReflection reflection) {
    this.dailyReflections.add(reflection);
  }

  public int getProgressDays() {
    return this.dailyReflections.size();
  }

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
      LocalDate currentReflectionDate = dailyReflection.getLocalDate().toLocalDate();

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

  /* Static Method */
  public static List<MentalHealthChallenge> getAll() {
    return list;
  }

  public static MentalHealthChallenge getUserChallengeById(String user, int id) {
    return getByUser(user).stream().filter(c -> c.getId() == id).findFirst().orElse(null);
  }

  public static List<MentalHealthChallenge> getByUser(String user) {
    return getAll().stream().filter(c -> c.getUser().equals(user)).toList();
  }
}
