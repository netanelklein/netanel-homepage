enum SkillLevel { beginner, intermediate, advanced, expert }

class Skill {
  final String id;
  final String name;
  final SkillLevel level;
  final String category;
  final int yearsOfExperience;
  final String? description;
  final String? iconName;
  final bool isHighlighted; // for featuring key skills

  const Skill({
    required this.id,
    required this.name,
    required this.level,
    required this.category,
    required this.yearsOfExperience,
    this.description,
    this.iconName,
    this.isHighlighted = false,
  });

  String get levelLabel {
    switch (level) {
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
      case SkillLevel.expert:
        return 'Expert';
    }
  }

  double get levelPercentage {
    switch (level) {
      case SkillLevel.beginner:
        return 0.25;
      case SkillLevel.intermediate:
        return 0.5;
      case SkillLevel.advanced:
        return 0.75;
      case SkillLevel.expert:
        return 1.0;
    }
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] as String,
      name: json['name'] as String,
      level: SkillLevel.values.firstWhere(
        (e) => e.toString().split('.').last == json['level'],
      ),
      category: json['category'] as String,
      yearsOfExperience: json['yearsOfExperience'] as int,
      description: json['description'] as String?,
      iconName: json['iconName'] as String?,
      isHighlighted: json['isHighlighted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'level': level.toString().split('.').last,
      'category': category,
      'yearsOfExperience': yearsOfExperience,
      'description': description,
      'iconName': iconName,
      'isHighlighted': isHighlighted,
    };
  }
}

class SkillCategory {
  final String name;
  final String description;
  final List<Skill> skills;
  final String? iconName;
  final int displayOrder;

  const SkillCategory({
    required this.name,
    required this.description,
    required this.skills,
    this.iconName,
    this.displayOrder = 0,
  });

  factory SkillCategory.fromJson(Map<String, dynamic> json) {
    return SkillCategory(
      name: json['name'] as String,
      description: json['description'] as String,
      skills: (json['skills'] as List)
          .map((skillJson) => Skill.fromJson(skillJson as Map<String, dynamic>))
          .toList(),
      iconName: json['iconName'] as String?,
      displayOrder: json['displayOrder'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'iconName': iconName,
      'displayOrder': displayOrder,
    };
  }
}
