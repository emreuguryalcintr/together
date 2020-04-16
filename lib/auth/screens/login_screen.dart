import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:together/auth/auth_service.dart';
import 'package:together/auth/screens/main_screen.dart';
import 'package:together/auth/screens/register_page.dart';
import 'package:together/auth/widgets/submit_button.dart';
import 'package:together/auth/widgets/text_form_field.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.profile.listen((state) => setState(() => _profile = state));
    authService.loading.listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Work Together",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Constants.colorAccent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Constants.colorMainBackground,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.dashboard,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
             SingleChildScrollView(
               controller: ScrollController(),
               child: Column(
                 children: <Widget>[
                   CustomTextField(
                     prefixIcon: Icon(
                       Icons.person,
                       color: Colors.white,
                     ),
                     controller: TextEditingController(),
                     labelText: "Kullanıcı Adı/Email",
                   ),
                   CustomTextField(
                     prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                     controller: TextEditingController(),
                     labelText: "Şifre",
                     suffixIcon: Icon(Icons.visibility, color: Colors.white),
                   ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
                     child: Align(
                       child: GestureDetector(
                           onTap: () {},
                           child: Text(
                             "Şifremi Unuttum?",
                           )),
                       alignment: Alignment.centerRight,
                     ),
                   ),
                   SubmitButton(
                     height: 40,
                     width: 220,
                     textColor: Colors.white,
                     backgroundColor: Constants.colorButtonSubmit,
                     text: "Giriş",
                     onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                     },
                   ),
                   Padding(
                     padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                     child: Row(
                       children: <Widget>[
                         Expanded(
                           flex: 1,
                           child: Container(
                             height: 2,
                             color: Colors.black,
                           ),
                         ),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: 15),
                           child: Text("VEYA"),
                         ),
                         Expanded(
                           flex: 1,
                           child: Container(
                             height: 2,
                             color: Colors.black,
                           ),
                         )
                       ],
                     ),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       Container(
                         width: MediaQuery.of(context).size.width>460?220:(MediaQuery.of(context).size.width-60)/2,
                         height: 40,
                         color: Colors.red,
                         child: SignInButtonBuilder(
                           innerPadding: EdgeInsets.all(0),
                           backgroundColor: Colors.blueAccent,
                           text: "Sign in with Facebook",
                           icon: FontAwesomeIcons.facebookF,
                           onPressed: () {},
                         ),
                       ),
                       Container(
                         width: MediaQuery.of(context).size.width>460?220:(MediaQuery.of(context).size.width-60)/2,
                         height: 40,
                         child: SignInButtonBuilder(
                           innerPadding: EdgeInsets.all(0),
                           text: "Sign in with Google",
                           backgroundColor: Colors.white,
                           textColor: Colors.black,
                           image: Image(
                             image: AssetImage(
                               'assets/logos/google_light.png',
                               package: 'flutter_signin_button',
                             ),
                             height: 36.0,
                           ),
                           onPressed: () {
                             authService.googleSignIn().then((user) {
                               if (user != null) {
                                 Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder: (BuildContext context) =>
                                             MainScreen()));
                               }
                             });
                           },
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 30),
                   GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                     },
                       child: Text("Hesabınız yok mu?"))
                 ],
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}
