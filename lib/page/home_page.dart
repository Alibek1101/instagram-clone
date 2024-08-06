import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../service/db_service.dart';



class MyHomePage extends StatefulWidget {
  static final String id = "MyHomePage";
  final PageController? pageController;
  MyHomePage({super.key,required this.pageController});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<Post> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiLoadFeeds();
  }
  _apiLoadFeeds(){
    setState(() {
      isLoading = true;
    });
    DBServise.loadFeeds().then((value) => {
      _resLoadFeeds(value),
    });
  }
  _resLoadFeeds(List<Post> posts){
    setState(() {
      items = posts;
      isLoading = false;
    });
  }
  void _apiPostLike(Post post)async{
    setState(() {
      isLoading = true;
    });

    await DBServise.likePost(post, true);
    setState(() {
      isLoading = false;
      post.isLike = true;
    });
  }

  void _apiPostUnLike(Post post)async{
    setState(() {
      isLoading = true;
    });

    await DBServise.likePost(post, false);
    setState(() {
      isLoading = false;
      post.isLike = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: Text(
          "Instagram",
          style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.w700,
              fontFamily: "Billabong"),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt, color: Colors.grey),
            onPressed: () {
              widget.pageController!.animateToPage(2,
                  duration: Duration(microseconds: 300), curve: Curves.easeIn);
            },
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _itemOfPost(items[index]);
              },
            ),
            isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SizedBox()
          ],
        ),
      ),
    );
  }Widget _itemOfPost(Post post) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 2, color: Color.fromRGBO(193, 53, 132, 1),),
                          image: DecorationImage(
                              image: AssetImage("assets/member_logo.png"),fit: BoxFit.cover
                          )
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Shohjahon",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
                        Text("2024.07.08",style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          CachedNetworkImage(
            imageUrl: post.name!,
            width: double.infinity,
            height: MediaQuery.of(context).size.width,
            placeholder: (context, url) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          Row(
              children:[
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if(!post.isLike){
                            _apiPostLike(post);
                          }else{
                            _apiPostUnLike(post);
                          }
                        },
                        icon:post.isLike
                            ?Icon(   Icons.favorite,
                          color: Colors.red,)
                            :Icon(   Icons.favorite_border,
                          color: Colors.red,)
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.mode_comment,
                          color: Colors.red,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Colors.red,
                        ))                ,
                  ],
                ),]
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              text: TextSpan(
                  text: "${post.caption}",
                  style: TextStyle(color: Colors.black)
              ),
            ),
          )
        ],
      ),
    );
  }
}