package my.utm.mentalhealthapp.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class User {
  private int id;
  private String name;
  private String email;
  private String password;
  private String role; // "student", "mhp", or "admin"

  private static int nextId = 1;
  private static List<User> users = new ArrayList<>(Arrays.asList(
      new User("Student User", "student@example.com", "password", "student"),
      new User("Dr. Sarah Johnson", "mhp@example.com", "password", "mhp"),
      new User("Admin User", "admin@example.com", "password", "admin")
  ));

  public User() {
    this.id = nextId++;
  }

  public User(String name, String email, String password, String role) {
    this.id = nextId++;
    this.name = name;
    this.email = email;
    this.password = password;
    this.role = role;
  }

  /* Getter Methods */
  public int getId() {
    return id;
  }

  public String getName() {
    return name;
  }

  public String getEmail() {
    return email;
  }

  public String getPassword() {
    return password;
  }

  public String getRole() {
    return role;
  }

  /* Setter Methods */
  public User setName(String name) {
    this.name = name;
    return this;
  }

  public User setEmail(String email) {
    this.email = email;
    return this;
  }

  public User setPassword(String password) {
    this.password = password;
    return this;
  }

  public User setRole(String role) {
    this.role = role;
    return this;
  }

  /* Static Methods */
  public static List<User> getAll() {
    return users;
  }

  public static User getByEmail(String email) {
    return users.stream()
        .filter(u -> u.getEmail().equalsIgnoreCase(email))
        .findFirst()
        .orElse(null);
  }

  public static User getById(int id) {
    return users.stream()
        .filter(u -> u.getId() == id)
        .findFirst()
        .orElse(null);
  }

  public static boolean emailExists(String email) {
    return getByEmail(email) != null;
  }

  public static void add(User user) {
    users.add(user);
  }

  public static boolean authenticate(String email, String password) {
    User user = getByEmail(email);
    return user != null && user.getPassword().equals(password);
  }
}

