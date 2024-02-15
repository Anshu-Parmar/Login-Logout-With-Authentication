import 'dart:ui';

import 'package:flutter/material.dart';
import '../../utils/animations.dart';
import '../../utils/bg_data.dart';
import '../../utils/text_utils.dart';
import '../screen_controller.dart';

class DesktopLoginScreen extends StatefulWidget {
  const DesktopLoginScreen({super.key});

  @override
  State<DesktopLoginScreen> createState() => _DesktopLoginScreenState();
}

class _DesktopLoginScreenState extends State<DesktopLoginScreen> {
  int selectedIndex=0;
  bool showOption=false;

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController.selection = TextSelection.fromPosition(TextPosition(offset: emailController.text.length));
    passwordController.selection = TextSelection.fromPosition(TextPosition(offset: passwordController.text.length));
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin:const  EdgeInsets.symmetric(vertical: 10),
        height: 49,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
                child:showOption? ShowUpAnimation(
                  delay: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Center(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dbgList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedIndex=index;
                                });
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor:selectedIndex==index? Colors.white:Colors.transparent,
                                child: Padding(
                                  padding:const  EdgeInsets.all(1),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(dbgList[index],),
                                  ),
                                ),
                              ),
                            );

                          }),
                    ),
                  ),
                ):const SizedBox()),
            const  SizedBox(width: 20,),
            showOption? GestureDetector(
                onTap: (){
                  setState(() {
                    showOption=false;
                  });
                },
                child:const Icon(Icons.close,color: Colors.white,size: 30,)) :
            GestureDetector(
              onTap: (){
                setState(() {
                  showOption=true;
                });
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding:const  EdgeInsets.all(1),

                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(dbgList[selectedIndex],),
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
        decoration:  BoxDecoration(
          image: DecorationImage(
              image: AssetImage(dbgList[selectedIndex]),fit: BoxFit.fill
          ),
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
              child: BackdropFilter(filter:ImageFilter.blur(sigmaY: 5,sigmaX: 5),
                  child:Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Center(child: TextUtil(text: "Login",weight: true,size: 30,)),
                        const Spacer(),
                        TextUtil(text: "Email",),
                        Container(
                          height: 35,
                          decoration:const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.white))
                          ),
                          child:TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration:const  InputDecoration(
                              suffixIcon: Icon(Icons.mail,color: Colors.white,),
                              fillColor: Colors.white,
                              border: InputBorder.none,),
                          ),
                        ),
                        const Spacer(),
                        TextUtil(text: "Password",),
                        Container(
                          height: 35,
                          decoration:const  BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.white))
                          ),
                          child:TextFormField(
                            controller: passwordController,
                            obscureText: !_passwordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                child: Icon(
                                  _passwordVisible?
                                  Icons.lock_open: Icons.lock,
                                  color: Colors.white
                                  ,),
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10,),
                            Expanded(child: TextUtil(text: "Remember Me",size: 12,weight: true,)),
                            const Spacer(),
                            TextUtil(text: "Forgot Password ",size: 12,weight: true,)
                          ],
                        ), const Spacer(),
                        Container(
                          height: 40,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          alignment: Alignment.center,
                          child: TextUtil(text: "Log In",color: Colors.black,),
                        ),
                        const   Spacer(),
                        Center(child: TextUtil(text: "Don't have a account REGISTER",size: 12,weight: true,)),
                        const   Spacer(),
                      ],
                    ),
                  ) ),
            ),
          ),
        ),
      ),
    );
  }
}
