import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:twitch_test/twitch.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/auth-data.dart';
import 'package:http/http.dart' as http;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitch OAuth Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'WebView Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _launched;
  int _counter = 0;
  Map _response ;

  void _done(Map<String, dynamic> data) async {
    print(data);
    _response = data;
    Navigator.pop(context);
  }

  WebView _getThirdPartyAuth(context) {

    return TwitchAuth().visa.authenticate(
      clientID: 'x4o5nvv7512fgh9hjlczegnxzyan48', // twitch developers register application's client id
      redirectUri: 'http://localhost',
      state: 'twitchAuth',
      scope: 'user:read:email%20channel:read:stream_key',
      onDone: _done,
      newSession: true // clean webview cache
    );
  }

  Widget _buildWebview(){
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          color: Colors.blue,
          width: 100,
          height: 100,
        )
      )
    );
  }

  Widget _buildBody(WebView authenticate) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () async{
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => Material(
                    color: Colors.transparent,
                    child :Container(
                    width: 800,
                    height: 400,
                    child: authenticate,
                    ),
                  ),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return child;
                  },
                )
              );
            },
            child: Text(
              "Open Twitch LoginIn page",
            ),
          ),
          buildTextRow(
            'clientID',
            _response != null && _response['clientID'] != null ? _response['clientID'] : ''
          ),
          buildTextRow(
            'access Token',
            _response != null && _response['access_token'] != null ? _response['access_token'] : ''
          ),
          buildTextRow(
            'redirectURI',
            _response != null && _response['redirectURI'] != null ? _response['redirectURI'] : ''
          ),
          buildTextRow(
            'token type',
            _response != null && _response['token_type'] != null ? _response['token_type'] : ''
          ),
          buildTextRow(
            'state',
            _response != null && _response['state'] != null ? _response['state'] : ''
          ),
          buildTextRow(
            'scope',
            _response != null && _response['scope'] != null ? _response['scope'] : ''
          ),
        ]
        ),
    );
  }

  Widget buildTextRow(String label, String value) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            child: Text(
              label + " : "
            ),
          ),
          Container(
            child: Text(value),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    WebView authenticate  = _getThirdPartyAuth(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(authenticate),
    );
  }
}
