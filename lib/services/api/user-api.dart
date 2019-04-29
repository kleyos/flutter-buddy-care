
import 'package:buddy_care/models/account-model.dart';
import './base-api.dart';


class UserApi extends API {
  Future<Account> requestProfile(String token) async {
    final url = 'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=$token';
    final res = await get(
      url: url,
      customHost: true,
      debugLogBody: true,
    );
    return Account.fromApiResponse(res);
  }

  Future<Account> createUser(String token) async {
    final res = await post(
      url: '/sessions',
      debugLogBody: true,
      body: { 'access_token': token }
    );
    return Account.fromApiResponse(res);
  }

  Future<Null> assignDevice(token, deviceToken) async {
    await post(
      url: '/assign_device',
      headers: authHeader(token),
      body: { 'firebase_token': deviceToken }
    );
  }
}
