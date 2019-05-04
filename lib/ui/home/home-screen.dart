import 'package:buddy_care/blocs/app-bloc.dart';
import 'package:buddy_care/models/post.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key key,
    @required this.bloc,
}): super(key: key);
  final ApplicationBloc bloc;

  Widget _buildItem(Post post) =>
    Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(post.text)
    );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('title'),
    ),
    body: StreamBuilder<UnmodifiableListView<Post>>(
      stream: bloc.buddyCareBLoC.posts,
      initialData: UnmodifiableListView<Post>([]),
      builder: (context, snapshot) =>
        ListView(
          children: snapshot.data.map(_buildItem).toList(),
        )
    )
  );
}