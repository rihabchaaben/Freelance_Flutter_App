import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/cubit/home_layout/states.dart';
import 'package:freelance_dxb/screens/layout/home_layout.dart';
import 'package:freelance_dxb/shared/components/components.dart';
import 'package:freelance_dxb/style/style.dart';
import '../auth/MultiSelectCategories.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var bioController = TextEditingController();

  var passwordController = TextEditingController();

  var adressController = TextEditingController();

  var emailController = TextEditingController();

  late List data;

  bool isCreating = false;

  List<String> _selectedCategories = [];
  @override
  void initState() {
    context.read<HomeCubit>().getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeCubit>(context),
      child: BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
        if (state is uploadProfileImagePickerSuccessState ||
            state is updateUploadDataUser) {
          toast(Colors.green, "Updates succesfully", context);
        }
      }, builder: (context, state) {
        nameController.text = HomeCubit.get(context).userModel!.name;
        phoneController.text = HomeCubit.get(context).userModel!.phone;
        bioController.text = HomeCubit.get(context).userModel!.bio!;
        var profileImage = HomeCubit.get(context).profileImage;
        var cv = HomeCubit.get(context).cv;
        passwordController.text = HomeCubit.get(context).userModel!.password;
        adressController.text = HomeCubit.get(context).userModel!.adress;
        emailController.text = HomeCubit.get(context).userModel!.email;
        _selectedCategories = HomeCubit.get(context).userModel!.subcategory;
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
                              onTap: () {},
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
                                  : NetworkImage(
                                      HomeCubit.get(context).userModel!.image ??
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
                      HomeCubit.get(context).cv != null)
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
                                    rate: context
                                        .read<HomeCubit>()
                                        .userModel!
                                        .rate!,
                                    subcategory: _selectedCategories,
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                    adress: adressController.text,
                                    password: passwordController.text,
                                    sessionPrice: context
                                        .read<HomeCubit>()
                                        .userModel!
                                        .sessionPrice,
                                    hourPrice: context
                                        .read<HomeCubit>()
                                        .userModel!
                                        .hourPrice,
                                  );
                                },
                                child: Text(
                                  "Update Profile",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              if (state is uploadProfileImagePickerLoadingState)
                                LinearProgressIndicator(
                                  color: Colors.grey,
                                )
                            ],
                          )),
                        if (HomeCubit.get(context).profileImage != null &&
                            HomeCubit.get(context).cv != null)
                          SizedBox(
                            width: 15,
                          ),
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
                    height: 20,
                  ),
                  if (state is GetAllCategoriesSucessEdit)
                    Row(
                      children: [
                        MultiSelectCategories(
                          categories: state.categories,
                          selectedSubCategories: _selectedCategories,
                          onConfirm: (results) {
                            setState(() {
                              print(results);
                              _selectedCategories = results;
                              context.read<HomeCubit>().userModel!.subcategory =
                                  _selectedCategories;
                            });
                          },
                        )
                      ],
                    ),
                  Row(
                    children: [
                      SizedBox(
                        width: 05,
                      ),
                      Icon(Icons.account_box_rounded, color: Colors.grey),
                      Text("    Add your Resume .PDF",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        //   width: 150,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            final path =
                                await FlutterDocumentPicker.openDocument();
                            print(path);
                            File file = File(path!);
                            HomeCubit.get(context).uploadCV(
                              subcategory: _selectedCategories,
                              bio: bioController.text,
                              name: nameController.text,
                              password: passwordController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              adress: adressController.text,
                              cv: file,
                              rate: context.read<HomeCubit>().userModel!.rate!,
                              sessionPrice: HomeCubit.get(context)
                                  .userModel!
                                  .sessionPrice,
                              hourPrice: context
                                  .read<HomeCubit>()
                                  .userModel!
                                  .hourPrice,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ElevatedButton(
                        style: startBtnStyle,
                        onPressed: () {
                          if (_selectedCategories.isNotEmpty)
                            context.read<HomeCubit>().updateUser(
                                  sessionPrice: HomeCubit.get(context)
                                      .userModel!
                                      .sessionPrice,
                                  hourPrice: context
                                      .read<HomeCubit>()
                                      .userModel!
                                      .hourPrice,
                                  rate: context
                                      .read<HomeCubit>()
                                      .userModel!
                                      .rate!,
                                  bio: bioController.text,
                                  name: nameController.text,
                                  password: passwordController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  adress: adressController.text,
                                  cv: cv,
                                  subcategory: _selectedCategories,
                                );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeLayout()));
                        },
                        child: Text(
                          "UPDATE",
                          style: TextStyle(color: Colors.white,fontSize: 25),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<firebase_storage.UploadTask> uploadFile(File file) async {
    if (file == null) {
      print('not able to uploade');
    }

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('playground')
        .child('/some-file.pdf');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    print("done..!");
    return Future.value(uploadTask);
  }
}
