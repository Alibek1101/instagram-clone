class Post {
  String uid ="";
  String name ="";
  String img_user ="";

  String img_post="";
  String caption="";
  String data = "";
  String id = "";
  bool isLike = false;

  Post(this.img_post,this.caption,);

  Post.fromJson(Map<String, dynamic> json)
      : img_post = json['img_post'],
        caption = json['caption'],
        uid = json['uid'],
        name = json['name'],
        id = json['id'],
        isLike = json['isLike'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
    'img_post': img_post,
    'caption': caption,
    'img_user': img_user,
    'uid': uid,
    'name': name,
    'id':id,
    'isLike': isLike,
    'data': data,
  };
}