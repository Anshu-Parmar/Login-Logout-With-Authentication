import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_initial/screens/mobile/home_screeen.dart';
import 'package:project_initial/screens/mobile/login_screen/login_screen.dart';
import 'package:project_initial/screens/screen_controller.dart';
import 'package:project_initial/utils/validators.dart';
import '../../../utils/animations.dart';
import '../../../utils/bg_data.dart';
import '../../../utils/text_utils.dart';

final _formKey = GlobalKey<FormState>();

class MobileSignUpScreen extends StatefulWidget {
  const MobileSignUpScreen({super.key});

  @override
  State<MobileSignUpScreen> createState() => _MobileSignUpScreenState();
}

class _MobileSignUpScreenState extends State<MobileSignUpScreen> {
  int selectedIndex = 0;
  bool showOption = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController.selection = TextSelection.fromPosition(
        TextPosition(offset: emailController.text.length));
    passwordController.selection = TextSelection.fromPosition(
        TextPosition(offset: passwordController.text.length));
    passwordCheckController.selection = TextSelection.fromPosition(
        TextPosition(offset: passwordController.text.length));
  }

  @override
  void dispose() {
    super.dispose();
    emailController.text = "";
    passwordController.text = "";
    passwordCheckController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 49,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
                child: showOption
                    ? ShowUpAnimation(
                        delay: 100,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: Center(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: bgList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: selectedIndex == index
                                          ? Colors.white
                                          : Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage(
                                            bgList[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      )
                    : const SizedBox()),
            const SizedBox(
              width: 20,
            ),
            showOption
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = false;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ))
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = true;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            bgList[selectedIndex],
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(bgList[selectedIndex]), fit: BoxFit.fill),
        ),
        alignment: Alignment.center,
        child: SizedBox(
          height: 500,
          width: 550,
          child: Container(
            height: 400,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Center(
                              child: TextUtil(
                            text: "Sign Up",
                            weight: true,
                            size: 30,
                          )),
                          const Spacer(),
                          TextUtil(
                            text: "Email",
                          ),
                          Container(
                            height: 35,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))),
                            child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                  ),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Email...";
                                  } else if (!value.isValidEmail ||
                                      !value.isNotNull) {
                                    return "Invalid Email...";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          const Spacer(),
                          TextUtil(
                            text: "Password",
                          ),
                          Container(
                            height: 35,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: !_passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  child: Icon(
                                    _passwordVisible
                                        ? Icons.lock_open
                                        : Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                                fillColor: Colors.white,
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Password...";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const Spacer(),
                          TextUtil(
                            text: "Confirm Password",
                          ),
                          Container(
                            height: 35,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))),
                            child: TextFormField(
                              controller: passwordCheckController,
                              obscureText: !_passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  child: Icon(
                                    _passwordVisible
                                        ? Icons.lock_open
                                        : Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                                fillColor: Colors.white,
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Password...";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _signUserUp(context);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Not Working"),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              child: TextUtil(
                                text: "Sign Up",
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Center(
                              child: TextUtil(
                            text: "Already have a account LOGIN",
                            size: 12,
                            weight: true,
                          )),
                          const Spacer(),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void _signUserUp(BuildContext context) async {
    // String email = emailController.text;
    // String password = passwordController.text;

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == passwordCheckController.text) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MobileLoginScreen(),
                ),(value) => false));
        Navigator.pop(context);
      } else {
        print("password not same");
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        const SnackBar(
          content: Text(
            "User-Not-Found!!",
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 2),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Wrong-Password!!",
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 2),
        ));
      }
      Navigator.pop(context);
    }
  }
}
