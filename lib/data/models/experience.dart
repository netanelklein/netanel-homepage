class Experience {
  final String id;
  final String company;
  final String position;
  final String description;
  final DateTime startDate;
  final DateTime? endDate; // null means current position
  final List<String> technologies;
  final List<String> achievements;
  final String? companyUrl;
  final String? companyLogo;

  const Experience({
    required this.id,
    required this.company,
    required this.position,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.technologies,
    required this.achievements,
    this.companyUrl,
    this.companyLogo,
  });

  bool get isCurrent => endDate == null;

  String get duration {
    final end = endDate ?? DateTime.now();
    final difference = end.difference(startDate);
    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;

    if (years > 0) {
      return months > 0 ? '$years yr $months mo' : '$years yr';
    } else {
      return '$months mo';
    }
  }

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as String,
      company: json['company'] as String,
      position: json['position'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      technologies: List<String>.from(json['technologies'] as List),
      achievements: List<String>.from(json['achievements'] as List),
      companyUrl: json['companyUrl'] as String?,
      companyLogo: json['companyLogo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'position': position,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'technologies': technologies,
      'achievements': achievements,
      'companyUrl': companyUrl,
      'companyLogo': companyLogo,
    };
  }
}
