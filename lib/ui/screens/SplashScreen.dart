
import 'package:buncher/data/UserRepository.dart';
import 'package:buncher/ui/screens/LoginPage.dart';
import 'package:buncher/ui/screens/MapScreen.dart';
import 'package:buncher/ui/screens/UserInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(context,MaterialPageRoute(
            builder: (context) => MapScreen()
          ));
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Column(

        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
            child: Text('Welcome To Buncher',
            style: TextStyle(fontSize: 80.0 , fontWeight: FontWeight.bold, color: Colors.blue)),
          )
        ],
      ),
    );
  }
}


class DecideScreens extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
      // builder: (_) => UserRepository.instance(),
       child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Unauthenticated:
              return LoginPage();
            case Status.Authenticating:
              return MapScreen();
            case Status.Authenticated:
              return UserInfoPage(user: user.user);
            case Status.Uninitialized:
              return MapScreen();
              break;
          }
        },
      ), create: (BuildContext context) { },
    );
  }

}