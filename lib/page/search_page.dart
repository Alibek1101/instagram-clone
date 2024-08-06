import 'package:flutter/material.dart';

import '../model/member.dart';
import '../service/db_service.dart';



class MySearchPage extends StatefulWidget {
  final PageController? pageController;
  const MySearchPage({super.key,required this.pageController});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  var searchController = TextEditingController();
  bool isLoading = false;
  List<Member> member1=[];

  void _firebaseSearchMember(String keyword){
    setState(() {
      isLoading = true;
    });
    DBServise.searchMember(keyword).then((users) => {
      _responseSearchMember(users),
    });
  }
  void _responseSearchMember (List<Member> members){
    setState(() {
      member1=members;
      isLoading=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseSearchMember("");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: Text("Instagram",style: TextStyle(fontFamily: "Billabong",fontWeight: FontWeight.w700,fontSize: 40),),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            child: Column(
              children: [
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                    border: Border.all(width: 0.7,color: Colors.black),
                  ),
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        _firebaseSearchMember(value);
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search,size: 30,),
                        labelText: "  Search"
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: member1.length,
                      itemBuilder:(ctx, index){
                        return _itemOfMembers(member1[index]);
                      }
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _itemOfMembers(Member member){
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 65,
      width: double.infinity,
      child: Row(
          children: [
      Expanded(
      child: Row(
      children: [
          Container(
          padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        border: Border.all(width: 1.5,color: Colors.pink),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(22.5),
          child: member.img_url.isEmpty
              ? Image(
            image: AssetImage("assets/fake_logo.png"),
            width: 45,
            height: 45,
            fit: BoxFit.cover,
          )
              :Image.network(
            member.img_url,
            width: 45,
            height: 45,
            fit: BoxFit.cover,
          )
      ),
    ),
    SizedBox(
    width: 15,
    ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(member.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Text(member.gmail,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w800,color: Colors.grey),),
      ],
    ),
      ],
      ),
      ),
            Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.blue,
              ),
              child: Center(child: Text("Follow",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20),)),
            ),
            SizedBox(width: 10,),
          ],
      ),
    );
  }
}