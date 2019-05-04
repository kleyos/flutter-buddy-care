
import 'package:buddy_care/ui/common/fb-button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  Widget buttonSection(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FBButton(),
      ),
      OutlineButton(
        key: Key('guest_btn'),
        child: Text(
          'Enter as a GUEST',
          style: TextStyle(
            fontSize: 16
          ),
        ),
        textColor: Colors.white,
        padding: const EdgeInsets.all(17.0),
        onPressed: (){
          Navigator.of(context).pushNamed('/home');
        },
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(26)),
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login_bg.png"),
                fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset("assets/logo_white.png",
                  fit: BoxFit.contain,
                  height: 200,
                ),
                Text(
                  'Marketplace for good acts',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white
                  ),
                ),
                buttonSection(context),
                Text(
                  'Terms and Conditions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          )
        ],
      )
    ));
  }

