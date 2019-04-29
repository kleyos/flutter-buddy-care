import 'package:buddy_care/services/api/base-api.dart';
import 'package:buddy_care/models/post.dart';


class PostApi extends API {
  Future<List<Post>> getPosts() async {
    final response = (await get(
      url: '/cards',
      headers: API().header
    ))['cards'];

    return response != null
      ? List.from(response).map<Post>((p) => Post.fromMap(p)).toList()
      : <Post>[];
  }

  Future<List<Post>> getUserPosts(int userId) async {
    final response = (await get(
      url: '/users/$userId/cards',
      headers: API().header
    ))['cards'];

    return response != null
      ? List.from(response).map<Post>((p) => Post.fromMap(p)).toList()
      : <Post>[];
  }

  Future<Post> create(text, type, token) async {
    final response = await post(
      url: '/$type',
      headers: authHeader(token),
      body: { 'text': text }
    );
    return response != null
      ? Post.fromMap(response)
      : null;
  }

  Future<Post> apply(type, id, token) async {
    final response = await post(
      url: '/$type/$id/apply',
      headers: authHeader(token),
    );
    return response != null
      ? Post.fromMap(response)
      : null;
  }

  Future<Post> edit(text, type, id, token) async {
    final response = await put(
      url: '/$type/$id',
      headers: authHeader(token),
      body: { 'text': text}
    );
    return response != null
      ? Post.fromMap(response)
      : null;
  }

  Future<Null> remove(text, type, id, token) async {
    await delete(
      url: '/$type/$id',
      headers: authHeader(token),
    );
  }

}
