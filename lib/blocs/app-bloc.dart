import 'dart:async';
import 'dart:collection';
import 'package:buddy_care/blocs/bloc-provider.dart';
import 'package:buddy_care/services/api/post-api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:buddy_care/models/post.dart';

class ApplicationBloc implements BlocBase {
  static ApplicationBloc _singleton;


  factory ApplicationBloc() {
    if (_singleton != null) {
      return _singleton;
    }
    _singleton = ApplicationBloc._internal();
    return _singleton;
  }

  ApplicationBloc._internal();



  @override
  void dispose() {
    print('dispose Application block');
  }
}


class BuddyCareBLoC {
  Map<String, dynamic> res;
  Stream<UnmodifiableListView<Post>> get posts => _postSubject.stream;

  final _postSubject = BehaviorSubject<UnmodifiableListView<Post>>();

  BuddyCareBLoC() {
    PostApi().getPosts().then((_res) => {
      _postSubject.add(UnmodifiableListView(_res))
    });
  }


}
