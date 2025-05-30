class ContactMessage {
  final String name;
  final String email;
  final String message;
  final DateTime timestamp;
  final String? subject;
  final String? phone;

  const ContactMessage({
    required this.name,
    required this.email,
    required this.message,
    required this.timestamp,
    this.subject,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'subject': subject,
      'phone': phone,
    };
  }

  factory ContactMessage.fromJson(Map<String, dynamic> json) {
    return ContactMessage(
      name: json['name'] as String,
      email: json['email'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      subject: json['subject'] as String?,
      phone: json['phone'] as String?,
    );
  }

  @override
  String toString() {
    return 'ContactMessage(name: $name, email: $email, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContactMessage &&
        other.name == name &&
        other.email == email &&
        other.message == message &&
        other.timestamp == timestamp &&
        other.subject == subject &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return Object.hash(name, email, message, timestamp, subject, phone);
  }
}
