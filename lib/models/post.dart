import 'package:buddy_care/models/User.dart';

class Post {
  int id;
  String type, text;
  User owner, applicant;

  Post.fromMap(Map<String, dynamic> c):
    id = c['id'],
    type = c['type'],
    text = c['text'],
    owner = User.fromMap(c['owner']),
    applicant = c['applicant'] != null ? User.fromMap(c['applicant']) : null;
}