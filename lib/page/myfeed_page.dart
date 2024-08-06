import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/post_model.dart';
import '../service/db_service.dart';
import '../service/storage_service.dart';





class MyFeedPage extends StatefulWidget {
  PageController? page;
  MyFeedPage({super.key,required this.page});

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  bool isLoading = false;
  List<Post> items = [];
  File? _image;
  final _picker = ImagePicker();
  var captionController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

  _upoadNewPost(){
    String caption = captionController.text.toString().trim();
    if(caption.isEmpty)return;
    if(_image ==null)return;
    _apiPostImage();
  }

  void _apiPostImage(){
    setState(() {
      isLoading = true;
    });
    StorageService.uploadUserPost(_image!).then((downloadUrl) =>{
      _resPostImage(downloadUrl),
    });
  }

  void _resPostImage(String downloadUrl){
    String caption = captionController.text.toString().trim();

    Post post = Post(downloadUrl,caption);
    _apiStorePost(post);
  }

  void _apiStorePost(Post post)async{
    Post posted = await DBServise.storePast(post);

    DBServise.storeFeed(posted).then((value) => {
      _moveToFeed(),
    });
  }
  _moveToFeed(){
    captionController.text= "";
    _image = null;
    widget.page!.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            _upoadNewPost();
          }, icon: Icon(Icons.save))
        ],
        leading: Container(),
        centerTitle: true,
        title: Text("Instagram",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700,fontFamily: "Billabong"),),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              GestureDetector(
                  onTap: (){
                    _imageFromGalarya();
                  },
                  child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width,
                      color: Colors.grey.withOpacity(0.4),
                      child: _image == null
                          ?Center(
                        child: Icon(Icons.add_a_photo,size: 50,color: Colors.grey,),)
                          :Stack(
                        children: [
                          Image.file(_image!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: double.infinity,
                            color: Colors.black12,
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(onPressed: (){
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                    icon: Icon(Icons.highlight_remove,size: 40,color: Colors.red,)
                                )
                              ],
                            ),
                          )
                        ],
                      )
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 10,right: 10,left: 10),
                child: TextField(
                  controller: captionController,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Caption",
                      hintStyle: TextStyle(
                        fontSize: 17,color: Colors.black,)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}