class User {
  int id;
  String username, email, token;
  Profile profile;

  User.fromMap(Map<String, dynamic> u) :
    id = u['id'],
    email = u['email'],
    token = u['token'] != null ? u['token'] : null,
    profile = u['profile'] != null ? Profile.fromMap(u['profile']) : null;
}

class Profile {
  String avatarUrl, firstName, lastName;

  Profile.fromMap(Map<String, dynamic> pf) :
    firstName = pf['firstName'],
    lastName = pf['lastName'],
    avatarUrl = pf['avatar_url'];
}
