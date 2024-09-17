import 'package:flutter/material.dart';

ValueNotifier<List<TextEditingController>> educationNameListNoti =
    ValueNotifier([]);
ValueNotifier<List<TextEditingController>> educationpassYrListNoti =
    ValueNotifier([]);

ValueNotifier<List<TextEditingController>> profNameListNoti = ValueNotifier([]);

ValueNotifier<List<TextEditingController>> profpassYrListNoti =
    ValueNotifier([]);
ValueNotifier<List<dynamic>> skillimageFileNoti =
    ValueNotifier<List<dynamic>>([]);
List<ValueNotifier<String?>> skillTypeListNoti = [ValueNotifier(null)];
ValueNotifier<List<TextEditingController>> skillNameListNoti =
    ValueNotifier([]);
ValueNotifier<List<TextEditingController>> projectNameNoti = ValueNotifier([]);
List<TextEditingController> projectDetails = [];
List<TextEditingController> projectLinkedIn = [];
List<TextEditingController> projectGit = [];
List<TextEditingController> projectplayStore = [];
List<TextEditingController> projectDrive = [];
ValueNotifier<List<List<dynamic>>> projectImageListNoti = ValueNotifier([
  [null]
]);
TextEditingController aboutEditingController = TextEditingController();
TextEditingController linkedInController = TextEditingController();
TextEditingController githubController = TextEditingController();
TextEditingController whatsAppController = TextEditingController();
TextEditingController instagramController = TextEditingController();
TextEditingController facebookController = TextEditingController();
TextEditingController twitterController = TextEditingController();
final formkeyForm = GlobalKey<FormState>();
