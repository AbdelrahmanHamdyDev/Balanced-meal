class CalorieService {
  int Calories_Calculation({
    required String gender,
    required int weight,
    required int height,
    required int age,
  }) {
    if (gender == 'Female') {
      return (655.1 + (9.56 * weight) + (1.85 * height) - (4.67 * age)).round();
    } else {
      return (666.47 + (13.75 * weight) + (5 * height) - (6.75 * age)).round();
    }
  }
}
