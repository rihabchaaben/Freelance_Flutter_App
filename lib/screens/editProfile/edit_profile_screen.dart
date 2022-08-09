import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/cubit/home_layout/states.dart';
import 'package:freelance_dxb/shared/components/components.dart';
import 'package:freelance_dxb/style/style.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var passwordController = TextEditingController();
  var adressController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeCubit>(context),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is uploadCoverImagePickerSuccessState ||
              state is uploadProfileImagePickerSuccessState ||
              state is updateUploadDataUser) {
            toast(Colors.green, "Updates succesfully", context);
          }
        },
        builder: (context, state) {
          nameController.text = HomeCubit.get(context).userModel!.name!;
          phoneController.text = HomeCubit.get(context).userModel!.phone!;
          bioController.text = HomeCubit.get(context).userModel!.bio!;
          var profileImage = HomeCubit.get(context).profileImage;
          passwordController.text = HomeCubit.get(context).userModel!.password!;
          adressController.text = HomeCubit.get(context).userModel!.adress!;
          emailController.text = HomeCubit.get(context).userModel!.email!;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              titleSpacing: 0,
              title: Text("Edit Profile"),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              actions: [
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is uploadUserLoadingState)
                      LinearProgressIndicator(
                        color: Colors.grey,
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                                onTap: () {
                                  HomeCubit.get(context).getCoverImage();
                                },
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              child: CircleAvatar(
                                radius: 61,
                                backgroundImage: (profileImage != null
                                    ? FileImage(profileImage)
                                    : NetworkImage(HomeCubit.get(context)
                                            .userModel!
                                            .image ??
                                        "")) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                                onTap: () {
                                  HomeCubit.get(context).getProfileImage();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (HomeCubit.get(context).profileImage != null ||
                        HomeCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (HomeCubit.get(context).profileImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                MaterialButton(
                                  color: Colors.red,
                                  minWidth: double.infinity,
                                  onPressed: () {
                                    HomeCubit.get(context).uploadprofile(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                        adress: adressController.text,
                                        password: passwordController.text);
                                  },
                                  child: Text(
                                    "Update Profile",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                if (state
                                    is uploadProfileImagePickerLoadingState)
                                  LinearProgressIndicator(
                                    color: Colors.grey,
                                  )
                              ],
                            )),
                          if (HomeCubit.get(context).profileImage != null &&
                              HomeCubit.get(context).coverImage != null)
                            SizedBox(
                              width: 15,
                            ),
                          if (HomeCubit.get(context).coverImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                MaterialButton(
                                  color: Colors.blue,
                                  minWidth: double.infinity,
                                  onPressed: () {
                                    HomeCubit.get(context).uploadCover(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                        password: passwordController.text,
                                        adress: adressController.text);
                                  },
                                  child: Text(
                                    "Update Cover",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                if (state is uploadCoverImagePickerLoadingState)
                                  LinearProgressIndicator(
                                    color: Colors.blue,
                                  )
                              ],
                            )),
                        ],
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    textFormField(
                        controller: nameController,
                        hintText: "Name",
                        prefixIcon: Icons.person),
                    SizedBox(
                      height: 10,
                    ),
                    textFormField(
                        controller: emailController,
                        hintText: "Email",
                        prefixIcon: Icons.email),
                    SizedBox(
                      height: 10,
                    ),
                    textFormField(
                        controller: passwordController,
                        hintText: "Password",
                        prefixIcon: Icons.password),
                    SizedBox(
                      height: 10,
                    ),
                    textFormField(
                        controller: phoneController,
                        hintText: "Phone",
                        prefixIcon: Icons.phone,
                        keyBoard: TextInputType.phone),
                    SizedBox(
                      height: 10,
                    ),
                    textFormField(
                        controller: adressController,
                        hintText: "Adress",
                        prefixIcon: Icons.home,
                        keyBoard: TextInputType.streetAddress),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: bioController,
                      minLines: 2,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        icon: Icon(Icons.textsms_outlined),
                        hintText: 'bio',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: startBtnStyle,
                          onPressed: () {
                            HomeCubit.get(context).updateUser(
                              bio: bioController.text,
                              name: nameController.text,
                              password: passwordController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              adress: adressController.text,
                            );
                          },
                          child: Text(
                            "UPDATE",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
