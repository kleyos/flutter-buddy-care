
import 'package:buddy_care/models/account-model.dart';
import './base-api.dart';


class FBApi extends API {
  Future<Account> requestProfile(String token) async {
    final url = 'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=$token';
    final res = await API.get(
      url: url,
      customHost: true,
      debugLogBody: true,
    );
    return Account.fromApiResponse(res);
  }
}
