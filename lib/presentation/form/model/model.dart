class FormModel {
  final String about;
  final List<Map<String, String>> education;
  final List<Map<String, String>> professional;
  final List<Map<String, dynamic>> skill;
  final List<Map<String, dynamic>> project;
  final Map<String, dynamic> resume;
  final String linkedIn;
  final String gitHub;
  final String whatsApp;
  final String instagram;
  final String facebook;
  final String twitter;

  FormModel({
    required this.about,
    required this.education,
    required this.professional,
    required this.skill,
    required this.project,
    required this.linkedIn,
    required this.gitHub,
    required this.whatsApp,
    required this.instagram,
    required this.facebook,
    required this.twitter,
    required this.resume,
  });
}
