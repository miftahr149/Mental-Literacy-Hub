package my.utm.mentalhealthapp.model;

public enum Feeling {
  VERY_BAD(1, "btn-outline-danger", "emoji-angry"), BAD(2, "btn-outline-secondary",
      "emoji-frown"), OKAY(3, "btn-outline-primary", "emoji-neutral"), GOOD(4,
          "btn-outline-success", "emoji-smile"), GREAT(5, "btn-outline-info", "emoji-laughing");

  private int feelingValue;
  private String btnClass;
  private String imageClass;

  private Feeling(int feelingValue, String btnClass, String imageClass) {
    this.feelingValue = feelingValue;
    this.btnClass = btnClass;
    this.imageClass = imageClass;
  }

  public int getFeelingValue() {
    return this.feelingValue;
  }

  public String getBtnClass() {
    return this.btnClass;
  }

  public String getImageClass() {
    return this.imageClass;
  }

  public String getDisplayName() {
    String name = super.toString().toLowerCase();
    char[] nameStr = name.toCharArray();

    int index = name.indexOf("_");
    if (index == -1) {
      return new String(nameStr);
    }

    nameStr[index] = ' ';
    return new String(nameStr);
  }

  public String getName() {
    return super.toString();
  }
}
