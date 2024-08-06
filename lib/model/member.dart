class Member {
  String uid="";
  String name="";
  String gmail="";
  String password="";
  String img_url="";

  String device_id="";
  String devise_type="";
  String device_token="";

  Member(this.name,this.gmail);

  Member.fromJson(Map<String, dynamic> json)
      :
        uid = json['uid'],
        name = json['name'],
        gmail = json['gmail'],
        password = json['password'],
        img_url = json ['img_url'],
        device_id = json['device_id']??"",
        devise_type = json['device_type']??"",
        device_token = json['device_token']??"";

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'gmail': gmail,
    'password':password,
    'img_url':img_url,
    'device_id':device_id,
    'device_type':devise_type,
    'device_token':device_token,
  };
}