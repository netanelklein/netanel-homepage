class PersonalInfo {
  final String fullName;
  final String title;
  final String tagline;
  final String summary;
  final ContactInfo contact;
  final List<String> languages;
  final String? profileImageUrl;

  const PersonalInfo({
    required this.fullName,
    required this.title,
    required this.tagline,
    required this.summary,
    required this.contact,
    required this.languages,
    this.profileImageUrl,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      fullName: json['fullName'] as String,
      title: json['title'] as String,
      tagline: json['tagline'] as String,
      summary: json['summary'] as String,
      contact: ContactInfo.fromJson(json['contact'] as Map<String, dynamic>),
      languages: List<String>.from(json['languages'] as List),
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'title': title,
      'tagline': tagline,
      'summary': summary,
      'contact': contact.toJson(),
      'languages': languages,
      'profileImageUrl': profileImageUrl,
    };
  }
}

class ContactInfo {
  final String email;
  final String? phone;
  final String? location;
  final Map<String, String>
      socialLinks; // e.g., {'github': 'https://github.com/...'}

  const ContactInfo({
    required this.email,
    this.phone,
    this.location,
    required this.socialLinks,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      email: json['email'] as String,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      socialLinks: Map<String, String>.from(json['socialLinks'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'location': location,
      'socialLinks': socialLinks,
    };
  }
}
