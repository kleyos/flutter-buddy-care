class Account {
  String id, name, firstName, lastName, email;
  FBPicture picture;
  static Account current;

  Account.fromApiResponse(Map<String, dynamic> a):
      id = a["id"],
      name = a["name"],
      lastName = a["last_name"],
      firstName = a["first_name"],
      email = a["email"],
      picture = FBPicture.fromApiResponse(a["picture"]["data"]);

  Account.fromJson(Map<String, dynamic> json):
      id = json["id"],
      name = json["name"],
      lastName = json["lastName"],
      firstName = json["firstName"],
      email = json["email"],
      picture = FBPicture.fromApiResponse(json["picture"]);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'picture': picture.toJson(),
  };
}

class FBPicture {
  int height, width;
  String url;

  FBPicture.fromApiResponse(Map<String, dynamic> p):
    height = p["height"],
    width = p["width"],
    url = p["url"];

  Map<String, dynamic> toJson() => {
    "height": height,
    "width": width,
    "url": url,
  };

}