import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

enum ProjectType { personal, professional, academic, openSource }

enum ProjectStatus { completed, inProgress, maintained, archived }

class Project {
  final String id;
  final String title;
  final String description;
  final String? longDescription;
  final ProjectType type;
  final ProjectStatus status;
  final DateTime startDate;
  final DateTime? endDate;
  final List<String> technologies;
  final List<String> features;
  final List<ProjectLink> links;
  final List<String> images;
  final String? iconName; // FontAwesome icon name
  final int priority; // for display ordering

  const Project({
    required this.id,
    required this.title,
    required this.description,
    this.longDescription,
    required this.type,
    required this.status,
    required this.startDate,
    this.endDate,
    required this.technologies,
    required this.features,
    required this.links,
    required this.images,
    this.iconName,
    this.priority = 0,
  });

  IconData get icon {
    switch (iconName) {
      case 'chartLine':
        return FontAwesomeIcons.chartLine;
      case 'microchip':
        return FontAwesomeIcons.microchip;
      case 'seedling':
        return FontAwesomeIcons.seedling;
      case 'mobile':
        return FontAwesomeIcons.mobile;
      case 'globe':
        return FontAwesomeIcons.globe;
      case 'code':
        return FontAwesomeIcons.code;
      default:
        return FontAwesomeIcons.folder;
    }
  }

  String get typeLabel {
    switch (type) {
      case ProjectType.personal:
        return 'Personal';
      case ProjectType.professional:
        return 'Professional';
      case ProjectType.academic:
        return 'Academic';
      case ProjectType.openSource:
        return 'Open Source';
    }
  }

  String get statusLabel {
    switch (status) {
      case ProjectStatus.completed:
        return 'Completed';
      case ProjectStatus.inProgress:
        return 'In Progress';
      case ProjectStatus.maintained:
        return 'Maintained';
      case ProjectStatus.archived:
        return 'Archived';
    }
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      longDescription: json['longDescription'] as String?,
      type: ProjectType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      status: ProjectStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      technologies: List<String>.from(json['technologies'] as List),
      features: List<String>.from(json['features'] as List),
      links: (json['links'] as List)
          .map((linkJson) =>
              ProjectLink.fromJson(linkJson as Map<String, dynamic>))
          .toList(),
      images: List<String>.from(json['images'] as List),
      iconName: json['iconName'] as String?,
      priority: json['priority'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'longDescription': longDescription,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'technologies': technologies,
      'features': features,
      'links': links.map((link) => link.toJson()).toList(),
      'images': images,
      'iconName': iconName,
      'priority': priority,
    };
  }
}

class ProjectLink {
  final String type; // 'github', 'demo', 'download', 'website', etc.
  final String url;
  final String label;

  const ProjectLink({
    required this.type,
    required this.url,
    required this.label,
  });

  IconData get icon {
    switch (type.toLowerCase()) {
      case 'github':
        return FontAwesomeIcons.github;
      case 'demo':
        return FontAwesomeIcons.upRightFromSquare;
      case 'download':
        return FontAwesomeIcons.download;
      case 'website':
        return FontAwesomeIcons.globe;
      case 'playstore':
        return FontAwesomeIcons.googlePlay;
      case 'appstore':
        return FontAwesomeIcons.appStore;
      default:
        return FontAwesomeIcons.link;
    }
  }

  factory ProjectLink.fromJson(Map<String, dynamic> json) {
    return ProjectLink(
      type: json['type'] as String,
      url: json['url'] as String,
      label: json['label'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
      'label': label,
    };
  }
}
