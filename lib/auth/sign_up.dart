import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/auth/sign_in.dart';

import '../model/member.dart';
import '../page/main_page.dart';
import '../service/auth_service.dart';
import '../service/db_service.dart';


class Sing_Up extends StatefulWidget {
  static final String id = "Sing_Up";
  const Sing_Up({super.key});

  @override
  State<Sing_Up> createState() => _Sing_UpState();
}

class _Sing_UpState extends State<Sing_Up> {
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;

  void singUp() async{
    String email = _emailController.text.trim().toString();
    String name = _nameController.text.trim().toString();
    String password = _passwordController.text.trim().toString();

    if (email.isEmpty   ||password.isEmpty || name.isEmpty) return;

    Member ma = Member(name, email);
    DBServise.storeMember(ma).then((value) => {
      _responseSingUp(ma),
    });

    var res= await  AuthService.signUpUser(name, email, password);
  }
  _responseSingUp(Member member){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return Home_page();
    }));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: <Color>[Colors.pink, Colors.purple]),
    ),
    padding: EdgeInsets.all(10),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(
    "Instagram",style: TextStyle(color: Colors.black,fontSize: 50,fontWeight: FontWeight.w600,fontFamily: "Billabong"),),
    SizedBox(height: 20,),
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
    decoration: InputDecoration(
    border: InputBorder.none,
    labelText: "Email",labelStyle: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),
    prefixIcon: Icon(Icons.person)
    ),
    ),
    ),
    ),
    SizedBox(height: 20,),
    Container(
    height: 60,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.shade200,
    border: Border.all(width: 1,color: Colors.black),
    ),
    child: Center(
    child: TextField(
    controller: _nameController,
    decoration: InputDecoration(
    border: InputBorder.none,
    labelText: "Name",labelStyle: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),
    prefixIcon: Icon(Icons.language)
    ),
    ),
    ),
    ),
    SizedBox(height: 20,),
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
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Password",labelStyle: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),
              prefixIcon: Icon(Icons.lock)
          ),
        ),
      ),
    ),
      SizedBox(height: 30,),
      InkWell(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return Home_page();
          }));
        },
        child: InkWell(
          onTap: (){
            setState(() {
              singUp();
            });
          },
          child: Container(
            child: Center(
              child: Text("Sing Up",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
            ),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
          ),
        ),
      ),
      SizedBox(height: 20,),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 7),
        height: 20,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/or.png"),fit: BoxFit.cover,
            )
        ),
      ),
      SizedBox(height: 10,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an acount?",style: TextStyle(fontSize: 15,color: Colors.grey),),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Log_In();
            }));
          }, child: Text("Log In",style: TextStyle(color: Colors.blue,fontSize: 15),))
        ],
      ),
    ],
    ),
        ),
    );
  }
}