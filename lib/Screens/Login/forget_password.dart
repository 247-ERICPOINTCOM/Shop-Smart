// -----------------Import--------------------
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopsmartly/constants/constants.dart';
// ------------------------------------------

class ForgetpassPage extends StatelessWidget {
  const ForgetpassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: kBackgroundColor,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20,
          color: kTextColor,

        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Column(
                      children: <Widget>[
                        Text("Recover Password",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color:kTextColor,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("A link will be send to your email",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),

                      child: Column(
                        children: <Widget>[
                          inputFile( hintText: "Email"),

                        ],
                      ),
                    ),
                    Padding(padding:
                    const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: const EdgeInsets.only(top: 3,left: 3),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {  },
                          color: kPrimaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            "Send",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ] ,
        ),
      ),
    );
  }
}

Widget inputFile({obscureText = false, hintText}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration:  InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 0,
              horizontal: 10),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey
            ),
          ),
        ),
      ),
      const SizedBox(height: 10)
    ],
  );
}


