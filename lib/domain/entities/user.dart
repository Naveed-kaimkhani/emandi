// User ---> NGO
class UserModel {
  String? uid;
  String? profileImage;
  String? name;
  String? phone;
  String? email;
  String? imageUrl;
  

  UserModel(
      {required this.uid,
      this.profileImage,
      required this.name,
      required this.phone,
      required this.email,
      required this.imageUrl,
      });

  Map<String, dynamic> toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['profileImage'] = user.profileImage;
    data['name'] = user.name;
    data['imageUrl'] = user.imageUrl;
    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    uid = mapData['uid'];
    profileImage = mapData['profileImage'];
    name = mapData['name'];
    phone = mapData['phone'];    
    email = mapData['email'];
    imageUrl = mapData['imageUrl'];
  
  }
}
