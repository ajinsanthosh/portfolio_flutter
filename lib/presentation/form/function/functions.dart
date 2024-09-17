// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/firebase/db.dart';
import 'package:flutter_portfolio/presentation/form/form.dart';
import 'package:flutter_portfolio/presentation/form/model/model.dart';
import 'package:flutter_portfolio/presentation/variable/variable.dart';
import 'package:image_picker/image_picker.dart';



Future<File?> selectImageFromGalleryOrCamera(ImageSource option) async {
  File? image;
  try {
    final pickedImage = await ImagePicker().pickImage(source: option);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    throw Exception('Error selecting image: $e');
  }
  return image;
}

addList(ValueNotifier<List<TextEditingController>> valueNotifierone,
    ValueNotifier<List<TextEditingController>> valueNotifiertwo) {
  valueNotifierone.value.add(TextEditingController());
  valueNotifiertwo.value.add(TextEditingController());
  valueNotifierone.notifyListeners();
  valueNotifiertwo.notifyListeners();
}

addListSkill(
    ValueNotifier<List<TextEditingController>> valueNotifierone,
    List<ValueNotifier<String?>> valueNotifiertwo,
    ValueNotifier<List<dynamic>> valueNotifierImage) {
  valueNotifierone.value.add(TextEditingController());
  valueNotifiertwo.add(ValueNotifier(null));
  valueNotifierImage.value.add('null');
  valueNotifierone.notifyListeners();
  valueNotifierImage.notifyListeners();
}

removeList(ValueNotifier<List<TextEditingController>> valueNotifierone,
    ValueNotifier<List<TextEditingController>> valueNotifiertwo, i) {
  valueNotifierone.value.removeAt(i);
  valueNotifiertwo.value.removeAt(i);
  valueNotifierone.notifyListeners();
  valueNotifiertwo.notifyListeners();
}

removeListSkill(
    ValueNotifier<List<TextEditingController>> valueNotifierone,
    List<ValueNotifier<String?>> valueNotifiertwo,
    ValueNotifier<List<dynamic>> valueNotifierImage,
    i) {
  valueNotifierone.value.removeAt(i);
  valueNotifiertwo.removeAt(i);
  valueNotifierImage.value.removeAt(i);
  valueNotifierone.notifyListeners();
  valueNotifierImage.notifyListeners();
}

addListProject(
    ValueNotifier<List<TextEditingController>> valueNotifierone,
    List<TextEditingController> projectDetails,
    List<TextEditingController> git,
    List<TextEditingController> linkedIn,
    List<TextEditingController> playStore,
    List<TextEditingController> drive) {
  valueNotifierone.value.add(TextEditingController());
  projectDetails.add(TextEditingController());
  git.add(TextEditingController());
  linkedIn.add(TextEditingController());
  playStore.add(TextEditingController());
  drive.add(TextEditingController());
  valueNotifierone.notifyListeners();
}

removeListProject(
    ValueNotifier<List<TextEditingController>> valueNotifierone,
    List<TextEditingController> projectDetails,
    List<TextEditingController> git,
    List<TextEditingController> linkedIn,
    List<TextEditingController> playStore,
    List<TextEditingController> drive,
    i) {
  valueNotifierone.value.removeAt(i);
  projectDetails.removeAt(i);
  git.removeAt(i);
  linkedIn.removeAt(i);
  playStore.removeAt(i);
  drive.removeAt(i);
  valueNotifierone.notifyListeners();
}

Future<List<File>> selectImagesFromGalleryMultipleImage() async {
  List<File> images = [];

  try {
    final pickedImage = await ImagePicker().pickMultiImage();

    if (pickedImage.isNotEmpty) {
      for (var i = 0; i < pickedImage.length; i++) {
        images.add(File(pickedImage[i].path));
      }
    }
  } catch (e) {
    throw Exception('Error selecting image: $e');
  }
  return images;
}

Future<List<String>> uploadImagesAndStoreURLs(List<dynamic> imageFiles) async {
  try {
    List<String> imageUrls = [];
    log(imageFiles.toString());
    for (var imageFile in imageFiles) {
      if (!File(imageFile).existsSync()) {
        imageUrls.add(imageFile);
      } else {
        Reference storageReference = FirebaseStorage.instance.ref().child(
            'images/skillImage/${DateTime.now().millisecondsSinceEpoch}');
        UploadTask uploadTask = storageReference.putFile(File(imageFile));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    }
    log(imageUrls.toString());
    return imageUrls;
  } catch (e) {
    log(e.toString());
    return [];
  }
}

Future<List<List<String>>> uploadImagesAndStoreProjectURLs(
    List<List<dynamic>> imageFiles) async {
  try {
    List<List<String>> imageUrls = [];

    for (var imageList in imageFiles) {
      List<String> urlsForOneList = [];
      for (var imageFile in imageList) {
        if (imageFile is String) {
          urlsForOneList.add(imageFile);
        } else {
          if (imageFile != null) {
            Reference storageReference = FirebaseStorage.instance.ref().child(
                'images/projectImages/${DateTime.now().millisecondsSinceEpoch}');
            UploadTask uploadTask =
                storageReference.putFile(File(imageFile.path));
            TaskSnapshot taskSnapshot =
                await uploadTask.whenComplete(() => null);
            String imageUrl = await taskSnapshot.ref.getDownloadURL();
            urlsForOneList.add(imageUrl);
          }
        }
      }
      imageUrls.add(urlsForOneList);
    }

    return imageUrls;
  } catch (e) {
    print(e);
    return [];
  }
}

void formFun(BuildContext context) async {
  if (formkeyForm.currentState!.validate()) {
    List<String> skillImageUrlList = [];
    skillImageUrlList =
        await uploadImagesAndStoreURLs(skillimageFileNoti.value);
    List<List<String>> projectImagesList = [];
    projectImagesList =
        await uploadImagesAndStoreProjectURLs(projectImageListNoti.value);
    List<Map<String, String>> educationList = [];
    for (var i = 0; i < educationNameListNoti.value.length; i++) {
      educationList.add({
        'educationName': educationNameListNoti.value[i].text.trim(),
        'passYear': educationpassYrListNoti.value[i].text.trim()
      });
    }
    List<Map<String, String>> professionalList = [];
    for (var i = 0; i < profNameListNoti.value.length; i++) {
      professionalList.add({
        'professionalName': profNameListNoti.value[i].text.trim(),
        'professionalYear': profpassYrListNoti.value[i].text.trim()
      });
    }
    List<Map<String, dynamic>> skillList = [];
    for (var i = 0; i < skillNameListNoti.value.length; i++) {
      skillList.add({
        'skillName': skillNameListNoti.value[i].text.trim(),
        'skillType': skillTypeListNoti[i].value ?? '',
        'skillImageUrl': skillImageUrlList[i]
      });
    }
    List<Map<String, dynamic>> projectList = [];
    for (var i = 0; i < projectNameNoti.value.length; i++) {
      projectList.add({
        'projectName': projectNameNoti.value[i].text.trim(),
        'projectDetails': projectDetails[i].text.trim(),
        'projectImageUrl': projectImagesList[i],
        'projectGit': projectGit[i].text.trim(),
        'projectLinkedIn': projectLinkedIn[i].text.trim(),
        'projectDrive': projectDrive[i].text.trim(),
        'projectplayStore': projectplayStore[i].text.trim(),
      });
    }
    Map<String, dynamic> resumeMap = {
      'pdfName': pdfName.value,
      'pdfUrl': uploadpdfUrl.value
    };
    final FormModel model = FormModel(
        about: aboutEditingController.text.trim(),
        education: educationList,
        professional: professionalList,
        skill: skillList,
        project: projectList,
        linkedIn: linkedInController.text.trim(),
        gitHub: githubController.text.trim(),
        whatsApp: whatsAppController.text.trim(),
        instagram: instagramController.text.trim(),
        facebook: facebookController.text.trim(),
        twitter: twitterController.text.trim(),
        resume: resumeMap);
    final data = await FirebaseDatabase().setUserDataFirebase(model, context);
    print(data);
  }
}
