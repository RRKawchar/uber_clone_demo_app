import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uber_clone_demo/src/core/asset/app_assets.dart';
import 'package:uber_clone_demo/src/core/globle/global.dart';
import 'package:uber_clone_demo/src/features/auth/view/screens/login_screen.dart';
import 'package:uber_clone_demo/src/features/main/view/screen/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();


  _submit()async{

    if(_formKey.currentState!.validate()){
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passController.text
      ).then((auth)async{
        currentUser=auth.user;

        if(currentUser!=null){
          Map userMap={
            "id":currentUser!.uid,
            "name":nameController.text.trim(),
            "email":emailController.text.trim(),
            "phone":phoneController.text.trim(),
            "address":addressController.text.trim()

          };
          DatabaseReference userRef=FirebaseDatabase.instance.ref().child("user");
          userRef.child(currentUser!.uid).set(userMap);
        }
         Fluttertoast.showToast(msg: "Successfully Registered!");
        Navigator.push(context, MaterialPageRoute(builder: (c)=>const MainScreen()));

      }).catchError((onError){
        Fluttertoast.showToast(msg: "Error Occurred! :\n $onError");
      });
    }else{
      Fluttertoast.showToast(msg: "Not all Failed are valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Image.asset(
              AppAssets.registerTopLogo,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Register",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 0,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              )),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Name Can't be Empty!!";
                            }
                            if (text.length < 2) {
                              return "Please Enter a valid Name";
                            }
                          },
                          onChanged: (val) => setState(() {
                            nameController.text = val;
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Email Can't be Empty!!";
                            }
                            if (EmailValidator.validate(text) == true) {
                              return null;
                            }
                            if (text.length < 2) {
                              return "Please Enter a valid email";
                            }
                          },
                          onChanged: (val) => setState(() {
                            emailController.text = val;
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IntlPhoneField(
                          showCountryFlag: false,
                          decoration: InputDecoration(
                            hintText: "Phone",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                              ),
                            ),
                          ),
                          initialCountryCode: "BD",
                          onChanged: (val) => setState(() {
                            phoneController.text = val.completeNumber;
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.add_location_alt,
                              color: Colors.grey,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Address Can't be Empty!!";
                            }
                            if (EmailValidator.validate(text) == true) {
                              return null;
                            }
                            if (text.length < 2) {
                              return "Please Enter a valid Address";
                            }
                          },
                          onChanged: (val) => setState(() {
                            addressController.text = val;
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: !_passwordVisible,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 0,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(_passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Password Can't be Empty!!";
                            }
                            if (EmailValidator.validate(text) == true) {
                              return null;
                            }
                            if (text.length < 6) {
                              return "Password Must Be At Least 6 Characters";
                            }
                          },
                          onChanged: (val) => setState(() {
                            passController.text = val;
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: !_passwordVisible,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 0,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(_passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Confirm Password Can't be Empty!!";
                            }
                            if (text != passController.text) {
                              return "Password Do Not Match!!";
                            }
                            if (EmailValidator.validate(text) == true) {
                              return null;
                            }
                            if (text.length < 6) {
                              return "Confirm Password Must Be At Least 6 Characters";
                            }
                          },
                          onChanged: (val) => setState(() {
                            confirmPassController.text = val;
                          }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan.shade900,
                              minimumSize: const Size(double.infinity, 50)),
                          onPressed: () {
                            _submit();
                          },
                          child: const Text("Register"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Forget Password!!",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Have an Account?"),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (c)=>const LoginScreen()));
                              },
                              child: const Text(
                                "Sign In.",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
