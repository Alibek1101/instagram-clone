import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/service/utils_service.dart';

import '../model/member.dart';
import '../model/post_model.dart';
import 'auth_service.dart';

class DBServise {
  static final _firestore = FirebaseFirestore.instance;
  static final floder_users = 'users';
  static final floder_posts = 'posts';
  static final floder_feeds = 'feeds';

  static Future storeMember(Member member) async {
    member.uid = AuthService.currentUserId();
    Map<String, String> params = await Utils.deviceParams();
    print(params.toString());

    member.device_id = params['device_id']!;
    member.devise_type = params['device_type']!;
    member.device_token = params['device_token']!;

    return _firestore
        .collection(floder_users)
        .doc(member.uid)
        .set(member.toJson());
  }

  static Future<Member> loadMember() async {
    String uid = AuthService.currentUserId();
    var value = await _firestore.collection(floder_users).doc(uid).get();
    Member member = Member.fromJson(value.data()!);

    return member;
  }

  static Future updateMember(Member member) async {
    String uid = AuthService.currentUserId();
    return _firestore.collection(floder_users).doc(uid).update(member.toJson());
  }

  static Future<List<Member>> searchMember(String keyword) async {
    List<Member> members = [];
    String uid = AuthService.currentUserId();

    var querySnapshot = await _firestore
        .collection(floder_users)
        .orderBy("name")
        .startAt([keyword]).get();
    print(querySnapshot.docs.length);

    querySnapshot.docs.forEach((result) {
      Member newMember = Member.fromJson(result.data());
      if (newMember.uid != uid) {
        members.add(newMember);
      }
    });
    return members;
  }

  static Future storePast(Post post) async {
    Member me = await loadMember();
    post.uid = me.uid;
    post.name = me.name;
    post.img_user = me.img_url;
    post.data = Utils.currentData();

    String postId = _firestore
        .collection(floder_users)
        .doc(me.uid)
        .collection(floder_posts)
        .doc()
        .id;
    post.id = postId;
    await _firestore
        .collection(floder_users)
        .doc(me.uid)
        .collection(floder_posts)
        .doc(postId)
        .set(post.toJson());
    return post;
  }

  static Future<Post> storeFeed(Post post) async {
    String uid = AuthService.currentUserId();
    await _firestore
        .collection(floder_users)
        .doc(uid)
        .collection(floder_feeds)
        .doc(post.id)
        .set(post.toJson());
    return post;
  }

  static Future<List<Post>> loadPosts() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();

    var querySnapshot = await _firestore
        .collection(floder_users)
        .doc(uid)
        .collection(floder_posts)
        .get();

    querySnapshot.docs.forEach((result) {
      posts.add(Post.fromJson(result.data()));
    });
    return posts;
  }

  static Future<List<Post>> loadFeeds() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();
    var querySnapshot = await _firestore
        .collection(floder_users)
        .doc(uid)
        .collection(floder_feeds)
        .get();

    querySnapshot.docs.forEach((result) {
      posts.add(Post.fromJson(result.data()));
    });
    return posts;
  }

  static Future likePost(Post post,bool liked) async{
    String uid=AuthService.currentUserId();
    post.isLike = liked;

    await _firestore
        .collection(floder_users)
        .doc(uid)
        .collection(floder_feeds)
        .doc(post.id)
        .set(post.toJson());

    if(uid == post.uid){
      await _firestore
          .collection(floder_users)
          .doc(uid)
          .collection(floder_posts)
          .doc(post.id)
          .set(post.toJson());
    }
  }

  static Future<List<Post>> loadLiked()async{
    String uid = AuthService.currentUserId();
    List<Post> posts=[];


    var quarySnapshot = await _firestore
        .collection(floder_users)
        .doc(uid)
        .collection(floder_feeds)
        .where('liked',isEqualTo: true)
        .get();

    quarySnapshot.docs.forEach((result) {
      Post post=Post.fromJson(result.data());
      posts.add(post);
    });
    return posts;
  }
}