class Education {
  final String id;
  final String institution;
  final String degree;
  final String field;
  final DateTime startDate;
  final DateTime? endDate; // null means ongoing
  final double? gpa;
  final String? description;
  final List<String> courses;
  final List<String> achievements;
  final String? institutionUrl;
  final String? institutionLogo;

  const Education({
    required this.id,
    required this.institution,
    required this.degree,
    required this.field,
    required this.startDate,
    this.endDate,
    this.gpa,
    this.description,
    required this.courses,
    required this.achievements,
    this.institutionUrl,
    this.institutionLogo,
  });

  bool get isOngoing => endDate == null;

  String get status {
    if (isOngoing) {
      return 'In Progress';
    } else {
      return 'Completed';
    }
  }

  String get period {
    final startYear = startDate.year;
    if (isOngoing) {
      return '$startYear - Present';
    } else {
      return '$startYear - ${endDate!.year}';
    }
  }

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] as String,
      institution: json['institution'] as String,
      degree: json['degree'] as String,
      field: json['field'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      gpa: json['gpa'] as double?,
      description: json['description'] as String?,
      courses: List<String>.from(json['courses'] as List),
      achievements: List<String>.from(json['achievements'] as List),
      institutionUrl: json['institutionUrl'] as String?,
      institutionLogo: json['institutionLogo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institution': institution,
      'degree': degree,
      'field': field,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'gpa': gpa,
      'description': description,
      'courses': courses,
      'achievements': achievements,
      'institutionUrl': institutionUrl,
      'institutionLogo': institutionLogo,
    };
  }
}
