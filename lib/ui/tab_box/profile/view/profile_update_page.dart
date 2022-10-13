import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ish_top/cubits/user/user_cubit.dart';
import 'package:ish_top/data/models/users/user_model.dart';
import 'package:ish_top/ui/tab_box/profile/home.dart';
import 'package:ish_top/ui/tab_box/profile/widgets/my_custom_input.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({Key? key}) : super(key: key);

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String imagePath = "";
    final ImagePicker _picker = ImagePicker();
    XFile? imageFile;

    Future uploadFile() async {
      if (imageFile == null) return;
      final fileName = imageFile!.path;
      final destination = 'files/$fileName';

      try {
        final ref =
            FirebaseStorage.instance.ref(destination).child('files/images/');
        await ref.putFile(imageFile as File);
      } catch (e) {
        print('error occured');
      }
    }

    getFromGallery() async {
      imageFile = await _picker.pickImage(
        maxHeight: 500,
        maxWidth: 500,
        source: ImageSource.gallery,
      );
      if (imageFile != null) {
        uploadFile();
        setState(() {
          imagePath = imageFile!.path;
        });
      }
    }

    getFromCamera() async {
      imageFile = await _picker.pickImage(
        maxHeight: 500,
        maxWidth: 500,
        source: ImageSource.camera,
      );
      if (imageFile != null) {
        uploadFile();
        setState(() {
          imagePath = imageFile!.path;
        });
      }
    }

    void selectImageDialog(context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.all(16),
                height: 150, //MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text("Gallery"),
                        onTap: () {
                          getFromGallery();
                          Navigator.of(context).pop();
                        }),
                    ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: Text("Camera"),
                      onTap: () {
                        getFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title:const Text("Profile Update page"),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .1),
                child: Column(
                  children: [
                    SizedBox(height: height * .02),
                    GestureDetector(
                      child: ProfileImageView(
                          photo: state.userModel.imageUrl.toString()),
                      onTap: () async {
                        selectImageDialog(context);
                      },
                    ),
                    SizedBox(height: height * .03),
                    MyCustomInput(
                      textEditingController: nameController,
                      hintText: "Full Name",
                      keyType: TextInputType.name,
                    ),
                    SizedBox(height: height * .05),
                    MyCustomInput(
                      textEditingController: phoneController,
                      hintText: 'Phone Number',
                      keyType: TextInputType.number,
                    ),
                    SizedBox(height: height * .05),
                    ActiveButton(
                      width: width * .5,
                      buttonText: "Update",
                      onPressed: () {
                        var currentUser = BlocProvider.of<UserCubit>(context).state.userModel;
                        UserModel userModel = UserModel(
                          imageUrl: imagePath,
                          createdAt: currentUser.createdAt,
                          fullName: nameController.text,
                          phoneNumber: phoneController.text,
                          userId: currentUser.userId,
                        );
                        BlocProvider.of<UserCubit>(context)
                            .updateUser(userModel);
                        nameController.clear();
                        phoneController.clear();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text("Loading..."),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
