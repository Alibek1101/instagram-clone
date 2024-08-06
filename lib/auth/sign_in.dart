import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/auth/sign_up.dart';

import '../page/main_page.dart';
import '../service/auth_service.dart';


class Log_In extends StatefulWidget {
  static final String id= "Log_In";
  const Log_In({super.key});

  @override
  State<Log_In> createState() => _Log_InState();
}

class _Log_InState extends State<Log_In> {
  bool passwordVisible=false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  void singIn() {
    String email = _emailController.text.trim().toString();
    String password = _passwordController.text.trim().toString();

    if (email.isEmpty || password.isEmpty) return;

    AuthService.signInUser(email, password).then((value) => {
      _responseSingIn(value!),
    });
  }
  _responseSingIn(User firebaseUser){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const Home_page();
    }));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible=true;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: <Color>[Colors.pink, Colors.purple]),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const Text(
    "Instagram",style: TextStyle(color: Colors.black,fontSize: 50,fontWeight: FontWeight.w600,fontFamily: "Billabong"),),
    const SizedBox(height: 20,),
    Container(
    height: 60,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.shade200,
    border: Border.all(width: 1,color: Colors.black),
    ),
    child: Center(
    child: TextField(
    controller: _emailController,
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
    border: InputBorder.none,
    labelText: "Email",
    labelStyle: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),
    prefixIcon: Icon(Icons.person)
    ),
    ),
    ),
    ),
    const SizedBox(height: 20,),
    Container(
    height: 60,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.shade200,
    border: Border.all(width: 1,color: Colors.black),
    ),
    child: Center(
    child: TextField(
    controller: _passwordController,
    obscureText: passwordVisible,
    decoration: InputDecoration(
    border: InputBorder.none,
    prefixIcon: const Icon(Icons.key_rounded),
    hintText: "Password",
    helperStyle:const TextStyle(color:Colors.green),
      suffixIcon: IconButton(
        icon: Icon(passwordVisible
            ? Icons.visibility
            : Icons.visibility_off),
        onPressed: () {
          setState(
                () {
              passwordVisible = !passwordVisible;
            },
          );
        },
      ),
      alignLabelWithHint: false,
      filled: true,
    ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    ),
    ),
    ),
      const SizedBox(height: 30,),
      InkWell(
        onTap: (){
          singIn();
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: const Center(
            child: Text("Log In",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
          ),
        ),
      ),
      const SizedBox(height: 20,),
      InkWell(
        onTap:(){
          AuthService.signInWithGoogle();
        },
        child:Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 100),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage("assets/google_icon.png")
              )
          ),
        ),
      ),
      const SizedBox(height: 20,),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        height: 20,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/or.png"),fit: BoxFit.cover,
            )
        ),
      ),
      const SizedBox(height: 30,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an acount?",style: TextStyle(fontSize: 15,color: Colors.grey),),
          TextButton(onPressed: (){
            Navigator.pushNamed(context, Sing_Up.id);
          }, child: const Text("Sing Up",style: TextStyle(color: Colors.blue,fontSize: 15),))
        ],
      ),
    ],
    ),
        ),
    );
  }
}