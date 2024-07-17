class InternshipModel {
  final String title;
  final String companyName;
  final List<String> location;
  final String startDate;
  final String duration;
  final String salary;

  InternshipModel({
    required this.title,
    required this.companyName,
    required this.location,
    required this.startDate,
    required this.duration,
    required this.salary,
  });

  factory InternshipModel.fromMap(Map<String, dynamic> map) {
    return InternshipModel(
      title: map['title'] as String,
      companyName: map['company_name'] as String,
      location: List<String>.from((map['location_names'] as List<String>)),
      startDate: map['start_date'] as String,
      duration: map['duration'] as String,
      salary: map["stipend"]['salary'] as String,
    );
  }
}
