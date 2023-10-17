import 'package:clay_containers/widgets/clay_container.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:kalibre_task/app/data/components/app_constant.dart';
import 'package:kalibre_task/app/data/components/custom_elevated_button.dart';
import 'package:kalibre_task/app/data/components/image_paths.dart';
import 'package:kalibre_task/app/data/components/user_header_text.dart';
import 'package:kalibre_task/app/data/components/user_input_field.dart';
import 'package:kalibre_task/app/routes/app_pages.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppConstant.subtitleColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        toolbarHeight: 0.h,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: GestureDetector(
          onTap: () {
            AppConstant.disposeKeyboard();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Lottie.asset(
                        signUpAnimation,
                        width: 1.sw,
                        height: 170.h,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'SIGN UP /',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                            fontSize: 22.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              const Shadow(
                                color: Color.fromARGB(255, 206, 206, 206),
                                offset: Offset(
                                  2,
                                  2,
                                ),
                                blurRadius: 3.0,
                              )
                            ],
                          ),
                          children: [
                            TextSpan(
                              text: ' Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const UserHeaderText(
                      text: "Name",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    UserInputField(
                      controller: nameController,
                      icon: Icons.person_outline,
                      hintText: "Enter your name",
                      isNameField: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const UserHeaderText(
                      text: "Email address",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    UserInputField(
                      controller: emailController,
                      icon: Icons.email_outlined,
                      hintText: "Enter your email",
                      isNameField: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email can't be empty";
                        } else if (!EmailValidator.validate(value)) {
                          return "Incorrect email address";
                        }
                        //  else if (!RegExp(
                        //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        //     .hasMatch(value)) {
                        //   return "Please enter a valid email address";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const UserHeaderText(
                      text: "Password",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.password_outlined,
                          color: Colors.black.withOpacity(0.4),
                          size: 30.sp,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Obx(
                          () => Expanded(
                            flex: 7,
                            child: ClayContainer(
                              color: AppConstant.backgroundColor,
                              borderRadius: 10.r,
                              depth: -150,
                              spread: 1.0,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: controller.isPasswordHidden,
                                autofocus: false,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                    ),
                                decoration: InputDecoration(
                                  suffixIconConstraints: BoxConstraints(
                                    minHeight: 20.w,
                                    minWidth: 10.w,
                                    maxHeight: 30.h,
                                    maxWidth: 30.w,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.togglePasswordView();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 10.w,
                                      ),
                                      child: controller.isPasswordHidden
                                          ? SvgPicture.asset(
                                              passwordShow,
                                              height: 20.h,
                                              width: 30.w,
                                            )
                                          : SvgPicture.asset(
                                              passwordHide,
                                              height: 20.h,
                                              width: 30.w,
                                            ),
                                    ),
                                  ),
                                  fillColor:
                                      const Color.fromARGB(255, 244, 244, 244),
                                  filled: true,
                                  hintText: 'Enter password',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w200,
                                      ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ),
                                    borderSide: BorderSide(
                                      width: 0.w,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password can't  be empty";
                                  } else if (value.length < 6) {
                                    return "Must be of six characters";
                                  } else if (!RegExp(
                                          r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)")
                                      .hasMatch(value)) {
                                    return "Password must contain letter,number & characters";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const UserHeaderText(
                      text: "Confirm Password",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.password_outlined,
                          color: Colors.black.withOpacity(0.4),
                          size: 30.sp,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Obx(
                          () => Expanded(
                            flex: 7,
                            child: ClayContainer(
                              color: AppConstant.backgroundColor,
                              borderRadius: 10.r,
                              depth: -150,
                              spread: 1.0,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                obscureText: controller.isConPasswordHidden,
                                autofocus: false,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                    ),
                                decoration: InputDecoration(
                                  suffixIconConstraints: BoxConstraints(
                                    minHeight: 20.w,
                                    minWidth: 10.w,
                                    maxHeight: 30.h,
                                    maxWidth: 30.w,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.toggleConPasswordView();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 10.w,
                                      ),
                                      child: controller.isConPasswordHidden
                                          ? SvgPicture.asset(
                                              passwordShow,
                                              height: 20.h,
                                              width: 30.w,
                                            )
                                          : SvgPicture.asset(
                                              passwordHide,
                                              height: 20.h,
                                              width: 30.w,
                                            ),
                                    ),
                                  ),
                                  fillColor:
                                      const Color.fromARGB(255, 244, 244, 244),
                                  filled: true,
                                  hintText: 'Enter password again',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w200,
                                      ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ),
                                    borderSide: BorderSide(
                                      width: 0.w,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                  ),
                                ),
                                validator: (value) {
                                  if (value != passwordController.text) {
                                    return "Password is not same";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.toggleTermsAndConditions();
                            },
                            child: controller.isChecked
                                ? SvgPicture.asset(
                                    checkedIcon,
                                  )
                                : SvgPicture.asset(
                                    unCheckedIcon,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'I agree to ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontSize: 13.sp,
                                    color: AppConstant.appBlack,
                                  ),
                              children: [
                                TextSpan(
                                  text: 'Terms & Conditions ',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                  25.r,
                                                ),
                                                topRight: Radius.circular(
                                                  25.r,
                                                ),
                                              ),
                                            ),
                                            child: ListView(
                                              children: [
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(
                                                      "Terms & Conditions",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                            fontSize: 20.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 15.w,
                                                    vertical: 15.h,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .copyWith(
                                                              fontSize: 15.sp,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontSize: 13.sp,
                                        color: AppConstant.appBlack,
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                                TextSpan(
                                  text: '& ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontSize: 13.sp,
                                        color: AppConstant.appBlack,
                                      ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                  25.r,
                                                ),
                                                topRight: Radius.circular(
                                                  25.r,
                                                ),
                                              ),
                                            ),
                                            child: ListView(
                                              children: [
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(
                                                      "Privacy Policy",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                            fontSize: 20.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 15.w,
                                                    vertical: 15.h,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .copyWith(
                                                              fontSize: 15.sp,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontSize: 13.sp,
                                        color: AppConstant.appBlack,
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (controller.isChecked == true) {
                            AppConstant.showLoader(context: context);
                            controller.signUp(
                              emailAddress: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              userName: nameController.text,
                            );
                          } else {
                            AppConstant.showSnackbar(
                              headText: "Failed",
                              content:
                                  "Please select terms and conditions before sign-up",
                              position: SnackPosition.BOTTOM,
                            );
                          }
                        }
                      },
                      width: 1.sw,
                      child: Text(
                        "Sign Up",
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 16.sp,
                                  color: AppConstant.appWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 2,
                            color: Color.fromARGB(255, 216, 216, 216),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "OR",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 15.sp,
                                    color: Colors.black.withOpacity(1),
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 2,
                            color: Color.fromARGB(255, 216, 216, 216),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: GestureDetector(
                        child: Text.rich(
                          TextSpan(
                            text: "Have a account?  ",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                ),
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: AppConstant.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    Get.toNamed(
                                      Routes.SIGN_IN,
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
