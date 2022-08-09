import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/cubit/customer/cubit/customer_profile_cubit.dart';
import 'package:freelance_dxb/shared/components/components.dart';
import 'package:freelance_dxb/style/style.dart';

class EditProfileCustomerScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var adressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CustomerProfileCubit>(context),
      child: BlocConsumer<CustomerProfileCubit, CustomerProfileState>(
        listener: (context, state) {
          if (state is uploadCoverImagePickerSuccessState ||
              state is uploadProfileImagePickerSuccessState ||
              state is updateUploadDataUser) {
            toast(Colors.green, "Updates succesfully", context);
          }
        },
        builder: (context, state) {
          nameController.text =
              CustomerProfileCubit.get(context).userModel!.name!;
          phoneController.text =
              CustomerProfileCubit.get(context).userModel!.phone!;
          passwordController.text =
              CustomerProfileCubit.get(context).userModel!.password!;
          emailController.text =
              CustomerProfileCubit.get(context).userModel!.email!;
          adressController.text =
              CustomerProfileCubit.get(context).userModel!.adress!;
          var profileImage = CustomerProfileCubit.get(context).profileImage;
          var coverImage = CustomerProfileCubit.get(context).coverImage;

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
              actions: [],
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
                                  backgroundColor: Colors.blue,
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
                                        CustomerProfileCubit.get(context)
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
                                  CustomerProfileCubit.get(context)
                                      .getProfileImage();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (CustomerProfileCubit.get(context).profileImage !=
                            null ||
                        CustomerProfileCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (CustomerProfileCubit.get(context).profileImage !=
                              null)
                            Expanded(
                                child: Column(
                              children: [
                                MaterialButton(
                                  color: Colors.red,
                                  minWidth: double.infinity,
                                  onPressed: () {
                                    CustomerProfileCubit.get(context)
                                        .uploadprofile(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text,
                                            email: emailController.text,
                                            adress: adressController.text);
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
                          if (CustomerProfileCubit.get(context).profileImage !=
                                  null &&
                              CustomerProfileCubit.get(context).coverImage !=
                                  null)
                            SizedBox(
                              width: 15,
                            ),
                          if (CustomerProfileCubit.get(context).coverImage !=
                              null)
                            Expanded(
                                child: Column(
                              children: [
                                MaterialButton(
                                  color: Colors.blue,
                                  minWidth: double.infinity,
                                  onPressed: () {
                                    CustomerProfileCubit.get(context)
                                        .uploadCover(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text,
                                            email: emailController.text,
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
                      height: 70,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: startBtnStyle,
                          onPressed: () {
                            CustomerProfileCubit.get(context).updateCustomer(
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
