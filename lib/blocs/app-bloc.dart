import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:buddy_care/models/post.dart';

class BuddyCareBLoC {
  final String apiURL = 'https://buddy-care.herokuapp.com/api/v1';
  var _posts = <Post>[];
  Map<String, dynamic> res;
  Stream<UnmodifiableListView<Post>> get posts => _postSubject.stream;

  final _postSubject = BehaviorSubject<UnmodifiableListView<Post>>();

  BuddyCareBLoC() {
    _getUserPosts(5).then((res) => {
      _postSubject.add(UnmodifiableListView(_posts))
    });
  }

  Future<List<Post>> _getPosts() async {
    final response = await http.get('$apiURL/cards');
    if (response.statusCode == 200) {
      _posts = List.from(json.decode(response.body)['cards']).map((p) => Post.fromMap(p)).toList();
      return _posts;
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
    return [];
  }

  Future<List<Post>> _getUserPosts(int userId) async {
    final response = await http.get('$apiURL/users/$userId/cards');
    if (response.statusCode == 200) {
      _posts = List.from(json.decode(response.body)['cards']).map((p) => Post.fromMap(p)).toList();
      return _posts;
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
    return [];
  }
}
