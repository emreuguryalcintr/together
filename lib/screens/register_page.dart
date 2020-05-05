import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:together/constants/colors_constants.dart';
import 'package:together/widgets/submit_button.dart';
import 'package:together/widgets/text_form_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.colorAccent,
        leading: Icon(Icons.arrow_back),
        centerTitle: true,
        title: Text("Kaydol"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: ColorConstants.colorMainBackground,
        padding: EdgeInsets.all(30),
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
            CustomTextField(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              controller: TextEditingController(),
              labelText: "İsim/Soyisim",
            ),
            CustomTextField(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              controller: TextEditingController(),
              labelText: "Email",
            ),
            CustomTextField(
              prefixIcon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              controller: TextEditingController(),
              labelText: "Kullanıcı Adı",
            ),
            CustomTextField(
              prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
              controller: TextEditingController(),
              labelText: "Şifre",
              suffixIcon: Icon(Icons.visibility, color: Colors.white),
            ),
            SizedBox(height: 30,),
            SubmitButton(
              height: 40,
              width: 220,
              textColor: Colors.white,
              backgroundColor: ColorConstants.colorButtonSubmit,
              text: "Kayıt Ol",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
