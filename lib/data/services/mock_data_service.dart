import '../models/models.dart';

/// Mock data service for development and testing
/// This will be replaced with real API calls when backend is ready
class MockDataService {
  static Future<PortfolioData> getPortfolioData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    return PortfolioData(
      personalInfo: PersonalInfo(
        fullName: 'Netanel Klein',
        title: 'Electrical Engineering Student & Fullstack Developer',
        tagline: 'Crafting solutions from circuits to cocktails',
        summary:
            'Highly motivated and results-oriented fullstack developer and student for electrical engineering with experience in web development, mobile app development, hardware integration, and database management.',
        contact: ContactInfo(
          email: 'netanel@netanelk.com',
          phone: '050-7883339',
          location: 'Jerusalem, Israel',
          socialLinks: {
            'github': 'https://github.com/netanelklein',
            'linkedin': 'https://linkedin.com/in/netanelklein',
          },
        ),
        languages: [
          'Hebrew (Native)',
          'English (Fluent)',
          'Swedish (Intermediate)'
        ],
      ),
      experiences: [
        Experience(
          id: 'mottes',
          company: 'Mottes Tensiograph',
          position: 'Fullstack Developer',
          description:
              'Developed and maintained cross-platform mobile app (Android & iPhone) using React Native. Provides technical support and maintenance for the company website (PHP, MySQL).',
          startDate: DateTime(2022, 8),
          endDate: null, // Current position
          technologies: ['React Native', 'PHP', 'MySQL', 'Mobile Development'],
          achievements: [
            'Developed cross-platform mobile applications',
            'Maintained company website and database',
            'Provided technical support and troubleshooting'
          ],
          companyUrl: 'https://mottes.com',
        ),
        Experience(
          id: 'openapp',
          company: 'Openapp',
          position: 'Android Developer',
          description:
              'Enhanced functionality of Sheba Hospital patient TV app.',
          startDate: DateTime(2023, 5),
          endDate: DateTime(2024, 2),
          technologies: ['Android', 'Java', 'Kotlin', 'Mobile Development'],
          achievements: [
            'Enhanced patient TV app functionality',
            'Improved user experience for hospital patients'
          ],
        ),
      ],
      education: [
        Education(
          id: 'azrieli',
          institution: 'Azrieli College of Engineering',
          degree: 'Bachelor of Science',
          field: 'Electrical Engineering',
          startDate: DateTime(2022, 10),
          endDate: null, // Ongoing
          gpa: 92.79,
          description: 'Expected Graduation: 2026',
          courses: [
            'Circuit Analysis',
            'Signal Processing',
            'Digital Systems',
            'VHDL'
          ],
          achievements: ['High GPA: 92.79'],
          institutionUrl: 'https://azrieli.ac.il',
        ),
        Education(
          id: 'open-university',
          institution: 'The Open University of Israel',
          degree: 'Various Courses',
          field: 'Computer Science',
          startDate: DateTime(2021, 10),
          endDate: DateTime(2022, 8),
          courses: ['Java Programming', 'Data Structures'],
          achievements: ['Completed Java programming course'],
        ),
      ],
      projects: [
        Project(
          id: 'insightify',
          title: 'Insightify',
          description:
              'Personal Spotify data analytics platform built with Flutter and Dart',
          longDescription:
              'An Android app developed using Flutter (Dart) that analyzes personal Spotify data to provide insights into listening habits, favorite artists, and music trends.',
          type: ProjectType.personal,
          status: ProjectStatus.completed,
          startDate: DateTime(2023, 1),
          endDate: DateTime(2023, 6),
          technologies: ['Flutter', 'Dart', 'Spotify API', 'Data Analytics'],
          features: [
            'Spotify data integration',
            'Listening habits analysis',
            'Artist and genre insights',
            'Beautiful data visualizations'
          ],
          links: [
            ProjectLink(
                type: 'github',
                url: 'https://github.com/netanelklein/insightify',
                label: 'View Source'),
          ],
          images: [],
          iconName: 'chartLine',
          priority: 3,
        ),
        Project(
          id: 'env-monitor',
          title: 'Mini Environmental Monitor',
          description:
              'Multi-sensor IoT device measuring temperature, humidity, and light intensity with custom PCB design',
          longDescription:
              'A multi-sensor device measuring temperature, humidity, and light intensity within a room environment. Built using ESP8266 processor and custom printed PCB.',
          type: ProjectType.personal,
          status: ProjectStatus.completed,
          startDate: DateTime(2023, 3),
          endDate: DateTime(2023, 8),
          technologies: [
            'ESP8266',
            'PCB Design',
            'IoT Sensors',
            'C++',
            'Arduino IDE'
          ],
          features: [
            'Temperature and humidity monitoring',
            'Light intensity measurement',
            'Custom PCB design',
            'Wireless data transmission',
            'Real-time monitoring'
          ],
          links: [
            ProjectLink(
                type: 'github',
                url: 'https://github.com/netanelklein/env-monitor',
                label: 'View Source'),
          ],
          images: [],
          iconName: 'microchip',
          priority: 2,
        ),
        Project(
          id: 'mottes-app',
          title: 'Mottes Tensiograph Mobile App',
          description:
              'Cross-platform agricultural monitoring app for Android and iPhone with real-time soil data',
          longDescription:
              'Professional agricultural monitoring application developed for Mottes Tensiograph, enabling farmers to monitor soil conditions and irrigation systems in real-time.',
          type: ProjectType.professional,
          status: ProjectStatus.maintained,
          startDate: DateTime(2022, 8),
          technologies: [
            'React Native',
            'JavaScript',
            'Push Notifications',
            'Agricultural IoT'
          ],
          features: [
            'Real-time soil monitoring',
            'Push notifications for alerts',
            'Cross-platform compatibility',
            'Agricultural data visualization',
            'Remote irrigation control'
          ],
          links: [
            ProjectLink(
                type: 'website',
                url: 'https://mottes.com',
                label: 'Company Website'),
          ],
          images: [],
          iconName: 'seedling',
          priority: 1,
        ),
      ],
      skillCategories: [
        SkillCategory(
          name: 'Frontend Development',
          description: 'Client-side technologies and frameworks',
          skills: [
            Skill(
              id: 'react',
              name: 'React',
              level: SkillLevel.advanced,
              category: 'Frontend Development',
              yearsOfExperience: 3,
              isHighlighted: true,
            ),
            Skill(
              id: 'react-native',
              name: 'React Native',
              level: SkillLevel.advanced,
              category: 'Frontend Development',
              yearsOfExperience: 2,
              isHighlighted: true,
            ),
            Skill(
              id: 'flutter',
              name: 'Flutter',
              level: SkillLevel.intermediate,
              category: 'Frontend Development',
              yearsOfExperience: 1,
              isHighlighted: true,
            ),
            Skill(
              id: 'javascript',
              name: 'JavaScript',
              level: SkillLevel.advanced,
              category: 'Frontend Development',
              yearsOfExperience: 4,
              isHighlighted: true,
            ),
          ],
          displayOrder: 1,
        ),
        SkillCategory(
          name: 'Backend Development',
          description: 'Server-side technologies and databases',
          skills: [
            Skill(
              id: 'php',
              name: 'PHP',
              level: SkillLevel.advanced,
              category: 'Backend Development',
              yearsOfExperience: 3,
              isHighlighted: true,
            ),
            Skill(
              id: 'mysql',
              name: 'MySQL',
              level: SkillLevel.advanced,
              category: 'Backend Development',
              yearsOfExperience: 3,
              isHighlighted: true,
            ),
            Skill(
              id: 'python',
              name: 'Python',
              level: SkillLevel.intermediate,
              category: 'Backend Development',
              yearsOfExperience: 2,
            ),
          ],
          displayOrder: 2,
        ),
        SkillCategory(
          name: 'Hardware & IoT',
          description: 'Embedded systems and IoT development',
          skills: [
            Skill(
              id: 'esp8266',
              name: 'ESP8266/ESP32',
              level: SkillLevel.advanced,
              category: 'Hardware & IoT',
              yearsOfExperience: 2,
              isHighlighted: true,
            ),
            Skill(
              id: 'arduino',
              name: 'Arduino',
              level: SkillLevel.advanced,
              category: 'Hardware & IoT',
              yearsOfExperience: 3,
            ),
            Skill(
              id: 'pcb-design',
              name: 'PCB Design',
              level: SkillLevel.intermediate,
              category: 'Hardware & IoT',
              yearsOfExperience: 1,
            ),
          ],
          displayOrder: 3,
        ),
        SkillCategory(
          name: 'Leadership & Military',
          description: 'Leadership experience and military service',
          skills: [
            Skill(
              id: 'military-leadership',
              name: 'Military Leadership',
              level: SkillLevel.advanced,
              category: 'Leadership & Military',
              yearsOfExperience: 5,
              description:
                  'Served as combat soldier and Sergeant in Givaty Brigade',
              isHighlighted: true,
            ),
            Skill(
              id: 'team-training',
              name: 'Team Training',
              level: SkillLevel.advanced,
              category: 'Leadership & Military',
              yearsOfExperience: 3,
              description: 'Oversaw new recruit training',
            ),
          ],
          displayOrder: 4,
        ),
      ],
      lastUpdated: DateTime.now(),
      version: '1.0.0',
    );
  }
}
