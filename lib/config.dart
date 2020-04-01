abstract class Config {
  static final baseUrl = "http://95.179.142.220";

  static String STATE = "$baseUrl/states";
  static String PATIENTS = "$baseUrl/patients";

  static final FirstName = "First Name";
  static final LastName = "Last Name";
  static final Street = "Street";
  static final City = "City";
  static final State = "State";
  static final Gender = "Gender";
  static final Latitude = "Latitude";
  static final Longitude = "Longitude";

  static final SelectState = "Select State";

  static List<String> genderList = ["Select Gender", "Female", "Male"];
}
