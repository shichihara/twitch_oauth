import 'dart:convert';
import 'package:http/http.dart' as http;

import 'common/simple-auth.dart';
import 'common/auth-data.dart';
import 'common/oauth.dart';


class TwitchAuth {
  final baseUrl = 'https://id.twitch.tv/oauth2/authorize';
  SimpleAuth visa;

  TwitchAuth() {
    visa = SimpleAuth(
        baseUrl: baseUrl,

        /// Sends a request to the user profile api
        /// endpoint. Returns an AuthData object.
        getAuthData: (Map<String, String> data) async {
          // var token = data[OAuth.TOKEN_KEY];
          // User profile API endpoint.
          // var baseProfileUrl = 'https://api.twitch.tv/helix/users';
          // var profileResponse = await http.get(baseProfileUrl, headers: {
          //   'Authorization': 'Bearer $token',
          //   'Client-Id': data['clientID'],
          // });
          // var profileJson = json.decode(profileResponse.body);

          return data;
        });
  }

  /// This function combines information
  /// from the user [json] and auth response [data]
  /// to build an [AuthData] object.
  // AuthData authData(Map<String, dynamic> json, Map<String, String> data) {
  //   final String accessToken = data[OAuth.TOKEN_KEY];
  //   print('response data:');
  //   print(data.toString());
  //   print('json: ${json.toString()}');
  //   Map<String, dynamic> user = json['data'][0];

  //   return AuthData(
  //       clientID: data['clientID'],
  //       accessToken: accessToken,
  //       userID: user['id'],
  //       email: user['email'] as String,
  //       profileImgUrl: user['profile_image_url'] as String,
  //       response: data,
  //       userJson: json);
  // }
}