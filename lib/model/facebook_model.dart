class FacebookModel {
  final String? name;
  final String? email;
  final FaceBookPictureModel? picture;
  final String? id;
  FacebookModel({this.name, this.email, this.id, this.picture});
  factory FacebookModel.fromJson(Map<String, dynamic> json) => FacebookModel(
    email: json["email"],
    name: json["name"],
    id: json["id"],
    picture: FaceBookPictureModel.fromJson(json["picture"]["data"]),
  );
}

class FaceBookPictureModel {
  final String? url;
  final int? height;
  final int? width;

  FaceBookPictureModel({this.url, this.height, this.width});

  factory FaceBookPictureModel.fromJson(Map<String, dynamic> json) =>
      FaceBookPictureModel(
        url: json["url"],
        height: json["height"],
        width: json["width"],
      );
}


// {
//  "name": "Open Graph Test User",
//  "email": "open_jygexjs_user@tfbnw.net",
//  "picture": {
//    "data": {
//      "height": 126,
//      "url": "https://scontent.fuio21-1.fna.fbcdn.net/v/t1.30497-1/s200x200/8462.jpg",
//      "width": 200
//    }
//  },
//  "id": "136742241592917"
// }
//