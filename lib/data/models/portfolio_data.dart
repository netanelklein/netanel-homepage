import 'personal_info.dart';
import 'experience.dart';
import 'education.dart';
import 'project.dart';
import 'skill.dart';

class PortfolioData {
  final PersonalInfo personalInfo;
  final List<Experience> experiences;
  final List<Education> education;
  final List<Project> projects;
  final List<SkillCategory> skillCategories;
  final DateTime lastUpdated;
  final String version;

  const PortfolioData({
    required this.personalInfo,
    required this.experiences,
    required this.education,
    required this.projects,
    required this.skillCategories,
    required this.lastUpdated,
    required this.version,
  });

  // Helper getters for easy access
  List<Experience> get currentExperiences =>
      experiences.where((exp) => exp.isCurrent).toList();

  List<Experience> get pastExperiences =>
      experiences.where((exp) => !exp.isCurrent).toList();

  List<Education> get ongoingEducation =>
      education.where((edu) => edu.isOngoing).toList();

  List<Education> get completedEducation =>
      education.where((edu) => !edu.isOngoing).toList();

  List<Project> get featuredProjects =>
      projects.where((proj) => proj.priority > 0).toList()
        ..sort((a, b) => b.priority.compareTo(a.priority));

  List<Project> get personalProjects =>
      projects.where((proj) => proj.type == ProjectType.personal).toList();

  List<Project> get professionalProjects =>
      projects.where((proj) => proj.type == ProjectType.professional).toList();

  List<Skill> get highlightedSkills {
    final allSkills = <Skill>[];
    for (final category in skillCategories) {
      allSkills.addAll(category.skills.where((skill) => skill.isHighlighted));
    }
    return allSkills;
  }

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      personalInfo:
          PersonalInfo.fromJson(json['personalInfo'] as Map<String, dynamic>),
      experiences: (json['experiences'] as List)
          .map(
              (expJson) => Experience.fromJson(expJson as Map<String, dynamic>))
          .toList(),
      education: (json['education'] as List)
          .map((eduJson) => Education.fromJson(eduJson as Map<String, dynamic>))
          .toList(),
      projects: (json['projects'] as List)
          .map((projJson) => Project.fromJson(projJson as Map<String, dynamic>))
          .toList(),
      skillCategories: (json['skillCategories'] as List)
          .map((catJson) =>
              SkillCategory.fromJson(catJson as Map<String, dynamic>))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      version: json['version'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personalInfo': personalInfo.toJson(),
      'experiences': experiences.map((exp) => exp.toJson()).toList(),
      'education': education.map((edu) => edu.toJson()).toList(),
      'projects': projects.map((proj) => proj.toJson()).toList(),
      'skillCategories': skillCategories.map((cat) => cat.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'version': version,
    };
  }

  // Helper method for resume generation
  Map<String, dynamic> toResumeData() {
    return {
      'personalInfo': personalInfo.toJson(),
      'experiences': experiences.map((exp) => exp.toJson()).toList(),
      'education': education.map((edu) => edu.toJson()).toList(),
      'projects': featuredProjects.map((proj) => proj.toJson()).toList(),
      'skills': highlightedSkills.map((skill) => skill.toJson()).toList(),
      'generatedAt': DateTime.now().toIso8601String(),
    };
  }
}
