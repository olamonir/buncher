
import 'package:buncher/data/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _email,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter Email" : null,
                  style: style,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _password,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter Password" : null,
                  style: style,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                      border: OutlineInputBorder()),
                ),
              ),
              user.status == Status.Authenticating
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.red,
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (!await user.signIn(
                                  _email.text, _password.text))
                                _key.currentState.showSnackBar(SnackBar(
                                  content: Text("Something is wrong"),
                                ));
                            }
                          },
                          child: Text(
                            "Sign In",
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}






























// // import 'package:buncher/data/models/auth.dart';
// import 'package:buncher/ui/screens/SignupPage.dart';
// import 'package:buncher/utils/constants.dart';
// import 'package:buncher/utils/popUp.dart';
// import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:native_widgets/native_widgets.dart';





// class LoginPage extends StatefulWidget {
//   LoginPage({this.userName});
//     final String userName;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }



// class _MyHomePageState extends State<LoginPage> {
//       TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

//       String _status = 'no-action';
//       String _email, _password;
//       var  _controllerEmail;
//       var _controllerPassword;
//       final formKey = GlobalKey<FormState>();
//       final _scaffoldKey = GlobalKey<ScaffoldState>();


//     @override
//     void initState() {
//       super.initState();
//       _controllerEmail = TextEditingController(text:  "");
//       _controllerPassword = TextEditingController(text: "");
//       _loadUsername();
//       print(_status);
//     }

//     void _loadUsername() async {
//     try {
//       SharedPreferences _prefs = await SharedPreferences.getInstance();
//       var _username = _prefs.getString("saved_username") ?? "";
//       var _remeberMe = _prefs.getBool("remember_me") ?? false;

//       if (_remeberMe) {
//         _controllerEmail.text = _username ?? "";
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//       @override
//       Widget build(BuildContext context) {
//           // final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
//         return new Scaffold(
//         resizeToAvoidBottomPadding: false,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//                 padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
//                 child: Column(
//                   children: <Widget>[
//                     welcomeField(),
//                     SizedBox(height: 20.0),
//                     emailField(_controllerEmail , _email),
//                     SizedBox(height: 20.0),
//                     passwordField(_controllerPassword , _password),
//                     SizedBox(height: 5.0),
//                     forgetPasswordField(),
//                     SizedBox(height: 40.0),
//                     // loginField(),


//  ListTile(
//               title: NativeButton(
//                 child: Text(
//                   'Login',
//                   textScaleFactor: textScaleFactor,
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 color: Colors.blue,



//                 onPressed: () {
//                   // final form = formKey.currentState;
//                   // if (form.validate()) {
//                     // form.save();
//                     final snackbar = SnackBar(
//                       duration: Duration(seconds: 30),
//                       content: Row(
//                         children: <Widget>[
//                           NativeLoadingIndicator(),
//                           Text("  Logging In...")
//                         ],
//                       ),
//                     );
//                     _scaffoldKey.currentState.showSnackBar(snackbar);

//                     setState(() => this._status = 'loading');
//                   //   _auth.login(
//                   //     username: _email.toString().toLowerCase().trim(),
//                   //     password: _password.toString().trim(),
//                   //   ).then((result) {
//                   //     if (result) {
//                   //     } else {
//                   //       setState(() => this._status = 'rejected');
//                   //       showAlertPopup(context, 'Info', _auth.errorMessage);
//                   //     }
//                   //     // if (!globals.isBioSetup) {
//                   //     //   setState(() {
//                   //     //     print('Bio No Longer Setup');
//                   //     //   });
//                   //     // }
//                   //     _scaffoldKey.currentState.hideCurrentSnackBar();
//                   //   });
//                   }
//                 // },


//               ),
//             ),




//                     SizedBox(height: 20.0),
//                   ],
//                 )),
//             SizedBox(height: 15.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   'New user to Buncher ?',
//                   style: TextStyle(fontFamily: 'Montserrat'),
//                 ),
//                 SizedBox(width: 5.0),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => SignupPage()));
//                     // Navigator.of(context).pushNamed('ui/screens/SignupPage');
//                   },
//                   child: Text(
//                     'Register',
//                     style: TextStyle(
//                         color: Colors.blue,
//                         fontFamily: 'Montserrat',
//                         fontWeight: FontWeight.bold,
//                         decoration: TextDecoration.underline),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ));
//       }
//     }


// Widget welcomeField(){

//         return Container(
//                       child: Stack(
//                         children: <Widget>[
//                           Container(
//                             padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
//                             child: Text('Buncher',
//                                 style: TextStyle(
//                                     fontSize: 80.0, fontWeight: FontWeight.bold)),
//                           ),
//                           Container(
//                             padding: EdgeInsets.fromLTRB(320.0, 175.0, 0.0, 0.0),
//                             child: Text('.',
//                                 style: TextStyle(
//                                     fontSize: 80.0,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blue)),
//                           )
//                         ],
//                       ),
//                     );

//         }


//         Widget emailField(TextEditingController _controllerEmail , String _email){
//                                 return 
//                                 ListTile(
//                                 title: TextFormField(
//                                 decoration: InputDecoration(labelText: 'Email'),
//                                 validator: (val) =>
//                                     val.length < 1 ? 'Email Required' : null,
//                                 onSaved: (val) => _email = val,
//                                 obscureText: false,
//                                 keyboardType: TextInputType.text,
//                                 controller: _controllerEmail,
//                       autocorrect: false,
//                     ),
//                   );
//         }


//         Widget passwordField(TextEditingController _controllerPassword , String _password){
//                 return   ListTile(
//                     title: TextFormField(
//                       decoration: InputDecoration(labelText: 'Password'),
//                       validator: (val) =>
//                           val.length < 1 ? 'Password Required' : null,
//                       onSaved: (val) => _password = val,
//                       obscureText: true,
//                       controller: _controllerPassword,
//                       keyboardType: TextInputType.text,
//                       autocorrect: false,
//                     ),
//                   );
//         }



//         Widget forgetPasswordField(){
//         return  Container(
//                               alignment: Alignment(1.0, 0.0),
//                               padding: EdgeInsets.only(top: 15.0, left: 20.0),
//                               child: InkWell(
//                                 child: Text(
//                                   'Forgot Password',
//                                   style: TextStyle(
//                                       color: Colors.blue,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Montserrat',
//                                       decoration: TextDecoration.underline),
//                                 ),
//                               ),
//                             );
//         }

//         // Widget loginField(String _email , String _password , GlobalKey<FormState> formKey , GlobalKey<ScaffoldState> _scaffoldKey  , ScopedModel.of<AuthModel>  _auth){
//         //         return
//         //       ListTile(
//         //       title: NativeButton(
//         //         child: Text(
//         //           'Login',
//         //           textScaleFactor: textScaleFactor,
//         //           style: TextStyle(color: Colors.white),
//         //         ),
//         //         color: Colors.blue,
//         //         onPressed: () {
//         //           final form = formKey.currentState;
//         //           if (form.validate()) {
//         //             form.save();
//         //             final snackbar = SnackBar(
//         //               duration: Duration(seconds: 30),
//         //               content: Row(
//         //                 children: <Widget>[
//         //                   NativeLoadingIndicator(),
//         //                   Text("  Logging In...")
//         //                 ],
//         //               ),
//         //             );
//         //             _scaffoldKey.currentState.showSnackBar(snackbar);

//         //             setState(() => this._status = 'loading');
//         //             _auth
//         //                 .login(
//         //               username: _email.toString().toLowerCase().trim(),
//         //               password: _password.toString().trim(),
//         //             )
//         //                 .then((result) {
//         //               if (result) {
//         //               } else {
//         //                 setState(() => this._status = 'rejected');
//         //                 showAlertPopup(context, 'Info', _auth.errorMessage);
//         //               }
//         //               // if (!globals.isBioSetup) {
//         //               //   setState(() {
//         //               //     print('Bio No Longer Setup');
//         //               //   });
//         //               // }
//         //               _scaffoldKey.currentState.hideCurrentSnackBar();
//         //             });
//         //           }
//         //         },
//         //       ),
//         //     );
//         // }

