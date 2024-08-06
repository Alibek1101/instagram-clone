import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/member.dart';
import '../model/post_model.dart';
import '../service/auth_service.dart';
import '../service/db_service.dart';
import '../service/storage_service.dart';


class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool isLoading = false;
  List<Post> items = [];
  List<Member> member = [];
  String fullName = "",email="",img_url = "";
  File? _image;
  final _picker = ImagePicker();

  int crossCount =1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiLoadMember();
    _apiLoadPost();
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Container(
                child: Wrap(
                  children: [
                    ListTile(
                      leading: new Icon(Icons.photo),
                      title: new Text("Galeriya"),
                      onTap: () {
                        _imageFromGalarya();
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: new Icon(Icons.camera_alt),
                      title: new Text("Camera"),
                      onTap: () {
                        _imageFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ));
        });
  }

  _imageFromGalarya() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  _imageFromCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  void _showMemberInfo(Member member) {
    setState(() {
      isLoading = false;
      this.fullName = member.name;
      this.email = member.gmail;
      this.img_url = member.img_url;
    });
  }

  void _apiLoadMember(){
    setState(() {
      isLoading = true;
    });
    DBServise.loadMember().then((value) => {
      _showMemberInfo(value),
    });
  }

  void _apiChangePhoto(){
    if(_image == null)return;

    setState(() {
      isLoading =true;
    });
    StorageService.uploadUserImage(_image!).then((downloadUrl) => {
      _apiUpdateUser(downloadUrl),
    });
  }

  _apiUpdateUser(String downloadUrl)async{
    Member member = await DBServise.loadMember();
    member.img_url = downloadUrl;
    await DBServise.updateMember(member);
    _apiLoadMember();
  }
  _apiLoadPost(){
    DBServise.loadPosts().then((value) => {
      _resLoadPosts(value),
    });
  }
  _resLoadPosts(List<Post> posts){
    setState(() {
      items = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Container(),
            centerTitle: true,
            title: Text("Intagram",style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.w700,fontFamily: "Billabong"),),
            actions: [
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
        onPressed: (){},icon: IconButton(icon: Icon(Icons.logout),onPressed: (){
          showAlertDialog(context);
        },),
        ),
        )
            ],
        ),
        body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(height: 30,),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        border: Border.all(width: 1.5,color: Colors.pink),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: img_url.isEmpty || img_url == null
                              ? Image(
                            image: AssetImage("assets/member_logo.png"),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                              :Image.network(
                            img_url,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton(
                        icon: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.add_circle, color: Colors.blue, size: 30)),
                        onPressed: (){
                          _showPicker(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(fullName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
            Text(email,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w700,fontSize: 15),),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 80,
              child: Row(
                  children: [
              Expanded(
              child: Center(
              child: Column(
                  children: [
                  Text(
                  "3",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,)
              ),
              SizedBox(height: 3,),
              Text("POSTS",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.normal),)
              ],
            )
        )),
    Expanded(
    child: Center(
    child: Column(
    children: [
    Text(
    "45M",
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16,)
    ),
    SizedBox(height: 3,),
    Text("FOLLEWERS",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.normal),)
    ],
    )
    )),
    Expanded(
    child: Center(
    child: Column(children: [
      Text(
          "45",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,)
      ),
      SizedBox(height: 3,),
      Text("FOLLOWING",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.normal),)
    ],
    )
    )),
                  ],
              ),
            ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: (){
                            setState(() {});
                          },
                          icon: Icon(Icons.list_alt),),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: (){
                            setState(() {});
                          },
                          icon: Icon(Icons.grid_view),),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,),
                    itemCount:items.length,
                    itemBuilder: (ctx, index){
                      return _itemOfPost(items[index]);
                    },
                  ),
                )
              ],
            ),
        ),
    );
  }
  Widget _itemOfPost(Post post){
    return GestureDetector(
      child:Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: post.name!,
                placeholder: (context,url)=>Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context,url,error)=>Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              post.caption!,
              style: TextStyle(color: Colors.black87.withOpacity(0.7)),
            )
          ],
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {
        AuthService.signOutUser(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("if you log out, you will be out of your account"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}