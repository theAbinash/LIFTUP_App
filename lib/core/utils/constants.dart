class Constants {

  static const String baseUrl = "https://raw.githubusercontent.com/theAbinash/workout-exercises/refs/heads/main/exercises.json";
  static const String userTokenKey = "USER_TOKEN";

  static const int personSexMale = 1;
  static const int personSexFemale = 2;

  static const int exerciseScopePublic = 1;
  static const int exerciseScopePrivate = 2;

  static const bool restDB = false;

  static const int exerciseTypeWithReps = 1;
  static const int exerciseTypeWithWeightAndReps = 2;
  static const int exerciseTypeWithWeightAndDuration = 3;
  static const int exerciseTypeWithDurationOnly = 4;
  static const int exerciseTypeWithDistanceOnly = 5;
  static const int exerciseTypeWithDistanceAndWeight = 6;

  static const int mediaTypePhoto = 1;
  static const int mediaTypeVideo = 2;

  static const int _avgSecondsPerSet = 30;
}