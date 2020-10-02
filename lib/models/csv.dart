class Csv {
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String country;
  final String car_model;
  final int car_model_year;
  final String car_color;
  final String gender;
  final String job_title;
  final String bio;

  Csv({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.country,
    this.car_model,
    this.car_model_year,
    this.car_color,
    this.gender,
    this.job_title,
    this.bio,
  });

  @override
  String toString() {
    return '${this.id} ${this.first_name} ${this.last_name} ${this.email} ${this.country}';
  }
}
