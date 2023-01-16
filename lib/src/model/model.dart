class KmUser{
  String? uid;
  String? name;
  String? userimage;
  String? description;
  KmUser({
    this.uid,
    this.name,
    this.userimage,
    this.description,
  });

  factory KmUser.fromJson(Map<String,dynamic> json){
    return KmUser(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      name: json['name'] == null ? '' : json['name'] as String,
      userimage: json['userimage'] == null ? '' : json['userimage'] as String,
      description: json['description'] == null ? '' : json['description'] as String,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'name': name,
      'userimage': userimage,
      'description': description,
    };
  }
}