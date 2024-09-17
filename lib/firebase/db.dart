// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';
import 'package:flutter_portfolio/presentation/form/model/model.dart';
import 'package:flutter_portfolio/presentation/screens/users/users_model.dart';



class FirebaseDatabase {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Portfolio');
  Future setUserDataFirebase(FormModel formModel, BuildContext context) async {
    await userCollection.doc('Adithyan').set({
      'about': formModel.about,
      'education': formModel.education,
      'professional': formModel.professional,
      'skill': formModel.skill,
      'project': formModel.project,
      'linkedIn': formModel.linkedIn,
      'gitHub': formModel.gitHub,
      'whatsApp': formModel.whatsApp,
      'instagram': formModel.instagram,
      'facebook': formModel.facebook,
      'twitter': formModel.twitter,
      'resume': formModel.resume
    });
    showCustomSnackBar(context,
        title: 'Successfully Added!',
        content: 'Details are added successfully');
  }

  Future setUserMessage(Usersmodels usersmodel, BuildContext context) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('UserFeedBack');
    await userCollection.doc(usersmodel.userEmail).set({
      'userName': usersmodel.userName,
      'userEmail': usersmodel.userEmail,
      'subject': usersmodel.subject,
      'message': usersmodel.message,
    });
    showCustomSnackBar(context,
        title: 'Successfully Added!',
        content: 'Details are added successfully');
  }

  Future<FormModel> getUserData() async {
    try {
      DocumentSnapshot snapshot = await userCollection.doc('Adithyan').get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return FormModel(
            about: data['about'] ?? '',
            education: _convertToListOfMapsStringString(data['education']),
            professional:
                _convertToListOfMapsStringString(data['professional']),
            skill: _convertToListOfMaps(data['skill']),
            project: _convertToListOfMaps(data['project']),
            linkedIn: data['linkedIn'] ?? '',
            gitHub: data['gitHub'] ?? '',
            whatsApp: data['whatsApp'] ?? '',
            instagram: data['instagram'] ?? '',
            facebook: data['facebook'] ?? '',
            twitter: data['twitter'] ?? '',
            resume: data['resume']);
      } else {
        throw Exception('User data not found');
      }
    } catch (e) {
      print('Error getting user data: $e');
      return FormModel(
          about: '',
          education: [],
          professional: [],
          skill: [],
          project: [],
          linkedIn: '',
          gitHub: '',
          whatsApp: '',
          instagram: '',
          facebook: '',
          twitter: '',
          resume: {});
    }
  }

  List<Map<String, String>> _convertToListOfMapsStringString(
      List<dynamic>? list) {
    if (list == null) return [];
    return list.map((item) {
      if (item is Map<String, dynamic>) {
        return item.map((key, value) => MapEntry(key, value.toString()));
      }
      return <String, String>{};
    }).toList();
  }

  List<Map<String, dynamic>> _convertToListOfMaps(List<dynamic>? list) {
    if (list == null) return [];
    return list.map((item) {
      if (item is Map<String, dynamic>) {
        return item;
      }
      return <String, dynamic>{};
    }).toList();
  }
}
