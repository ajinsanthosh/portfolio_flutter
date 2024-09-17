// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';
import 'package:flutter_portfolio/core/widgets/widget.dart';
import 'package:flutter_portfolio/firebase/db.dart';
import 'package:flutter_portfolio/presentation/form/function/functions.dart';
import 'package:flutter_portfolio/presentation/form/model/model.dart';
import 'package:flutter_portfolio/presentation/variable/variable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

ValueNotifier<File?> getPdfValueNotifier = ValueNotifier(null);
ValueNotifier<String?> pdfName = ValueNotifier(null);
ValueNotifier<String?> uploadpdfUrl = ValueNotifier(null);

class PortFolioForm extends StatefulWidget {
  const PortFolioForm({super.key});

  @override
  State<PortFolioForm> createState() => _PortFolioFormState();
}

class _PortFolioFormState extends State<PortFolioForm> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    FormModel? model = await FirebaseDatabase().getUserData();
    aboutEditingController.text = model.about;
    List<Map<String, dynamic>> educationList = model.education;
    educationNameListNoti.value = educationList.map((entry) {
      return TextEditingController(text: entry['educationName'] ?? '');
    }).toList();
    educationpassYrListNoti.value = educationList.map((entry) {
      String educationpass = entry['passYear'] ?? '';
      return TextEditingController(text: educationpass);
    }).toList();
    List<Map<String, dynamic>> professionalList = model.professional;
    profNameListNoti.value = professionalList.map((entry) {
      String proName = entry['professionalName'] ?? '';
      return TextEditingController(text: proName);
    }).toList();
    profpassYrListNoti.value = professionalList.map((entry) {
      String proYear = entry['professionalYear'] ?? '';
      return TextEditingController(text: proYear);
    }).toList();
    List<Map<String, dynamic>> skillList = model.skill;
    skillTypeListNoti = skillList.map((entry) {
      return ValueNotifier<String?>(entry['skillType'] ?? '');
    }).toList();
    skillNameListNoti.value = skillList.map((entry) {
      return TextEditingController(text: entry['skillName']);
    }).toList();
    skillimageFileNoti.value = skillList.map((entry) {
      String image = entry['skillImageUrl'];
      return image;
    }).toList();
    List<Map<String, dynamic>> projectList = model.project;
    projectNameNoti.value = projectList.map((entry) {
      return TextEditingController(text: entry['projectName']);
    }).toList();
    projectDetails = projectList.map((entry) {
      return TextEditingController(text: entry['projectDetails']);
    }).toList();
    projectGit = projectList.map((entry) {
      return TextEditingController(text: entry['projectGit']);
    }).toList();
    projectDrive = projectList.map((entry) {
      return TextEditingController(text: entry['projectDrive']);
    }).toList();
    projectplayStore = projectList.map((entry) {
      return TextEditingController(text: entry['projectplayStore']);
    }).toList();
    projectLinkedIn = projectList.map((entry) {
      return TextEditingController(text: entry['projectLinkedIn']);
    }).toList();
    projectImageListNoti.value = projectList.map((entry) {
      List<dynamic> image = entry['projectImageUrl'];
      return image;
    }).toList();
    linkedInController.text = model.linkedIn;
    githubController.text = model.gitHub;
    whatsAppController.text = model.whatsApp;
    instagramController.text = model.instagram;
    facebookController.text = model.facebook;
    twitterController.text = model.twitter;
    pdfName.value = model.resume['pdfName'];
    uploadpdfUrl.value = model.resume['pdfUrl'];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorBlack.withOpacity(0.6),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkeyForm,
          child: ListView(
            children: [
              const Text(
                'About',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              sizedBox5H,
              TextFormWidget(
                label: 'About',
                icon: Icons.subject,
                controller: aboutEditingController,
                maxLines: 25,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter the About";
                  } else {
                    return null;
                  }
                },
              ),
              sizedBox10H,
              Row(
                children: [
                  const Text(
                    'Education',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      addList(educationNameListNoti, educationpassYrListNoti);
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: colorGreen,
                    ),
                  ),
                ],
              ),
              sizedBox5H,
              EduProContainerWidget(
                size: size,
                nameNoti: educationNameListNoti,
                yrNoti: educationpassYrListNoti,
              ),
              sizedBox15H,
              Row(
                children: [
                  const Text(
                    'Professional Expereince',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      addList(profNameListNoti, profpassYrListNoti);
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: colorGreen,
                    ),
                  ),
                ],
              ),
              sizedBox5H,
              EduProContainerWidget(
                size: size,
                nameNoti: profNameListNoti,
                yrNoti: profpassYrListNoti,
              ),
              sizedBox15H,
              Row(
                children: [
                  const Text(
                    'Skill',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      addListSkill(skillNameListNoti, skillTypeListNoti,
                          skillimageFileNoti);
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: colorGreen,
                    ),
                  ),
                ],
              ),
              sizedBox5H,
              ValueListenableBuilder(
                valueListenable: skillNameListNoti,
                builder: (context, skillName, child) => Column(
                  children: List.generate(
                      skillName.length,
                      (index) => Column(
                            children: [
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: colorApp.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            removeListSkill(
                                                skillNameListNoti,
                                                skillTypeListNoti,
                                                skillimageFileNoti,
                                                index);
                                          },
                                          icon: const Icon(
                                            Icons.cancel_rounded,
                                            color: colorRed,
                                          ),
                                        ),
                                      ],
                                    ),
                                    DropDownWidgetWithText(
                                        dropdownValueNoti:
                                            skillTypeListNoti[index],
                                        items: const [
                                          'Proficient With',
                                          'Familiar With'
                                        ],
                                        hintTxt: 'Select the Skill type',
                                        label: 'Skill Type'),
                                    sizedBox5H,
                                    const Text('skill',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    sizedBox5H,
                                    TextFormWidget(
                                      controller:
                                          skillNameListNoti.value[index],
                                      label: 'Skill',
                                      icon: Icons.abc,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Enter the Skill";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    sizedBox10H,
                                    ValueListenableBuilder(
                                      valueListenable: skillimageFileNoti,
                                      builder: (context, imageFile, child) =>
                                          Row(
                                        children: [
                                          !File(imageFile[index]).existsSync()
                                              ? CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage:
                                                      imageFile[index] == 'null'
                                                          ? null
                                                          : NetworkImage(
                                                              imageFile[index]))
                                              : CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage:
                                                      imageFile[index] != null
                                                          ? FileImage(File(
                                                              imageFile[index]))
                                                          : null,
                                                  child: imageFile[index] ==
                                                          null
                                                      ? const Icon(
                                                          CupertinoIcons.photo)
                                                      : null,
                                                ),
                                          sizedBox20W,
                                          Expanded(
                                            child: ElevatedBtnWidget(
                                              onPressed: () async {
                                                skillimageFileNoti.value
                                                    .removeAt(index);
                                                File? file =
                                                    await selectImageFromGalleryOrCamera(
                                                        ImageSource.gallery);
                                                if (file != null) {
                                                  File vaFile = file;
                                                  skillimageFileNoti.value
                                                      .add(vaFile.path);
                                                } else {
                                                  skillimageFileNoti.value
                                                      .add('null');
                                                }
                                                skillimageFileNoti
                                                    .notifyListeners();
                                              },
                                              title: 'Select Image',
                                              btnColor: colorApp,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              sizedBox10H
                            ],
                          )),
                ),
              ),
              sizedBox20H,
              Row(
                children: [
                  const Text(
                    'Project',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      addListProject(
                          projectNameNoti,
                          projectDetails,
                          projectGit,
                          projectLinkedIn,
                          projectplayStore,
                          projectDrive);
                      File? file;
                      projectImageListNoti.value.add([file]);
                    },
                    icon: const Icon(Icons.add_circle, color: colorGreen),
                  ),
                ],
              ),
              sizedBox5H,
              ValueListenableBuilder(
                valueListenable: projectNameNoti,
                builder: (context, projectName, child) => Column(
                  children: List.generate(
                    projectName.length,
                    (index) => Column(
                      children: [
                        Container(
                          width: size.width,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: colorApp.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20)),
                          child: ValueListenableBuilder(
                            valueListenable: projectImageListNoti,
                            builder: (context, projectImageList, child) =>
                                Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        removeListProject(
                                            projectNameNoti,
                                            projectDetails,
                                            projectGit,
                                            projectLinkedIn,
                                            projectplayStore,
                                            projectDrive,
                                            index);
                                      },
                                      icon: const Icon(
                                        Icons.cancel_rounded,
                                        color: colorRed,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text('Project Name',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                sizedBox5H,
                                TextFormWidget(
                                  controller: projectNameNoti.value[index],
                                  label: 'Project Name',
                                  icon: Icons.task,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "Enter the Project Name";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                sizedBox5H,
                                const Text(
                                  'Project details',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                sizedBox5H,
                                TextFormWidget(
                                  controller: projectDetails[index],
                                  label: 'Project details',
                                  icon: Icons.subject,
                                  maxLines: 25,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "Enter the Project Details";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                sizedBox10H,
                                const Text('GitHub',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                sizedBox5H,
                                TextFormWidget(
                                  controller: projectGit[index],
                                  label: 'GitHub',
                                  isflIcon: true,
                                  icon: const FaIcon(FontAwesomeIcons.github),
                                ),
                                const Text('LinkedIn',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                sizedBox5H,
                                TextFormWidget(
                                  controller: projectLinkedIn[index],
                                  label: 'LinkedIn',
                                  isflIcon: true,
                                  icon: const FaIcon(FontAwesomeIcons.linkedin),
                                ),
                                sizedBox10H,
                                const Text('Play Store / Amazon App Store',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                sizedBox5H,
                                TextFormWidget(
                                  controller: projectplayStore[index],
                                  label: 'Play Store / Amazon App Store',
                                  isflIcon: true,
                                  icon: const FaIcon(FontAwesomeIcons.amazon),
                                ),
                                sizedBox10H,
                                const Text('Google Drive',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                sizedBox5H,
                                TextFormWidget(
                                  controller: projectDrive[index],
                                  label: 'Drive',
                                  isflIcon: true,
                                  icon: const FaIcon(
                                      FontAwesomeIcons.googleDrive),
                                ),
                                sizedBox10H,
                                ElevatedBtnWidget(
                                  onPressed: () async {
                                    projectImageListNoti.value[index] =
                                        await selectImagesFromGalleryMultipleImage();
                                    projectImageListNoti.notifyListeners();
                                  },
                                  title: 'Select Image',
                                  btnColor: colorApp,
                                ),
                                sizedBox10H,
                                projectImageListNoti.value[index].isEmpty
                                    ? Container()
                                    : projectImageListNoti.value[index][0] ==
                                            null
                                        ? Container()
                                        : SizedBox(
                                            height: 100,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: List.generate(
                                                projectImageListNoti
                                                    .value[index].length,
                                                (i) => Row(
                                                  children: [
                                                    projectImageListNoti
                                                                .value[index][i]
                                                            is String
                                                        ? CircleAvatar(
                                                            radius: 40,
                                                            backgroundImage: NetworkImage(
                                                                projectImageListNoti
                                                                        .value[
                                                                    index][i]))
                                                        : projectImageListNoti
                                                                        .value[
                                                                    index][i] !=
                                                                null
                                                            ? CircleAvatar(
                                                                radius: 40,
                                                                backgroundImage:
                                                                    FileImage(projectImageListNoti
                                                                            .value[
                                                                        index][i]!),
                                                              )
                                                            : Container(),
                                                    sizedBox5W
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                              ],
                            ),
                          ),
                        ),
                        sizedBox10H,
                      ],
                    ),
                  ),
                ),
              ),
              sizedBox10H,
              const Text('LinkedIn',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              sizedBox5H,
              TextFormWidget(
                controller: linkedInController,
                label: 'LinkedIn',
                isflIcon: true,
                icon: const FaIcon(FontAwesomeIcons.linkedin),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter the LinkedIn link";
                  } else {
                    return null;
                  }
                },
              ),
              sizedBox10H,
              const Text('GitHub',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              sizedBox5H,
              TextFormWidget(
                controller: githubController,
                label: 'GitHub',
                isflIcon: true,
                icon: const FaIcon(FontAwesomeIcons.github),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter the GitHub link";
                  } else {
                    return null;
                  }
                },
              ),
              sizedBox10H,
              const Text('WhatsApp',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              sizedBox5H,
              TextFormWidget(
                controller: whatsAppController,
                label: 'WhatsApp',
                isflIcon: true,
                icon: const FaIcon(FontAwesomeIcons.whatsapp),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter the WhatsApp link";
                  } else {
                    return null;
                  }
                },
              ),
              sizedBox10H,
              const Text('Instagram',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              sizedBox5H,
              TextFormWidget(
                controller: instagramController,
                label: 'Instagram',
                isflIcon: true,
                icon: const FaIcon(FontAwesomeIcons.instagram),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter the Instagram link";
                  } else {
                    return null;
                  }
                },
              ),
              sizedBox10H,
              const Text('Facebook',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              sizedBox5H,
              TextFormWidget(
                controller: facebookController,
                label: 'Facebook',
                isflIcon: true,
                icon: const FaIcon(FontAwesomeIcons.facebook),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter the Facebook link";
                  } else {
                    return null;
                  }
                },
              ),
              sizedBox10H,
              const Text('Twitter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              sizedBox5H,
              TextFormWidget(
                controller: twitterController,
                label: 'Twitter',
                isflIcon: true,
                icon: const FaIcon(FontAwesomeIcons.xTwitter),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter the Twitter link";
                  } else {
                    return null;
                  }
                },
              ),
              sizedBox15H,
              Container(
                width: size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: colorApp.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select The Resume'),
                    sizedBox5H,
                    ValueListenableBuilder(
                      valueListenable: pdfName,
                      builder: (context, pdfname, child) => Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                getPdf();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: colorApp,
                                    borderRadius: BorderRadius.circular(10)),
                                child: pdfname != null
                                    ? Text(pdfname)
                                    : const Text('Click to Select...'),
                              ),
                            ),
                          ),
                          sizedBox10W,
                          InkWell(
                            onTap: () {
                              uploadPdf();
                            },
                            child: const CircleAvatar(
                              child: Icon(
                                FontAwesomeIcons.upload,
                                color: colorWhite,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              sizedBox15H,
              ElevatedBtnWidget(
                onPressed: () {
                  formFun(context);
                },
                btnColor: colorApp,
                title: 'Submit'.toUpperCase(),
                leading: const FaIcon(
                  FontAwesomeIcons.fileLines,
                  color: colorWhite,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> getPdf() async {
  final result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  if (result != null && result.files.isNotEmpty) {
    final pdf = result.files.single;
    getPdfValueNotifier.value = File(pdf.path!);
    pdfName.value = pdf.name;
  }
}

Future<void> uploadPdf() async {
  final ref = FirebaseStorage.instance.ref().child('Adithyan/${pdfName.value}');
  final uploadTask = ref.putFile(getPdfValueNotifier.value!);
  final snapshot = await uploadTask;
  uploadpdfUrl.value = await snapshot.ref.getDownloadURL();
}

class EduProContainerWidget extends StatelessWidget {
  const EduProContainerWidget({
    super.key,
    required this.size,
    required this.nameNoti,
    required this.yrNoti,
  });
  final ValueNotifier<List<TextEditingController>> nameNoti;
  final ValueNotifier<List<TextEditingController>> yrNoti;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: nameNoti,
      builder: (context, eduname, child) => Column(
        children: List.generate(
          eduname.length,
          (index) => Column(
            children: [
              Container(
                width: size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: colorApp.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            removeList(nameNoti, yrNoti, index);
                          },
                          icon: const Icon(
                            Icons.cancel_rounded,
                            color: colorRed,
                          ),
                        ),
                      ],
                    ),
                    const Text('School/College Name',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    sizedBox5H,
                    TextFormWidget(
                      controller: nameNoti.value[index],
                      label: 'School/College Name',
                      icon: Icons.school,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter The Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    sizedBox10H,
                    const Text('Pass Year',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    sizedBox5H,
                    TextFormWidget(
                      controller: yrNoti.value[index],
                      label: 'Pass Year',
                      icon: Icons.calendar_month,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Year";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              sizedBox5H
            ],
          ),
        ),
      ),
    );
  }
}
