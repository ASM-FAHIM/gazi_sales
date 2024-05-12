//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../sales/constant/app_constants.dart';
// import 'login_page.dart';
//
// class Confirm_password_user extends StatefulWidget {
//   final String xposition;
//   final String xoldpass;
//
//   Confirm_password_user({required this.xposition, required this.xoldpass});
//
//   @override
//   State<Confirm_password_user> createState() => _Confirm_password_userState();
// }
//
// class _Confirm_password_userState extends State<Confirm_password_user> {
//   GlobalKey<FormState> _formkeypass = GlobalKey();
//
//   TextEditingController old_password_controller = TextEditingController();
//   TextEditingController password_controller = TextEditingController();
//   TextEditingController password_controller_confirm = TextEditingController();
//
//   bool _isOldPasswordVisible = false;
//   bool _isNewPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//
//   Future<void> resetPassword() async {
//     if (password_controller.text != password_controller_confirm.text) {
//       // Show dialog if passwords do not match
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('New Password and Confirm Password do not match.'),
//             actions: [
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       return; // Stop the function if passwords do not match
//     }
//
//     // Continue with password reset if passwords match
//     final response = await http.post(
//       Uri.parse("http://${AppConstants.baseurl}/gazi/change_pass.php"),
//       body: jsonEncode(<String, String>{
//         "xposition": widget.xposition,
//         "xpassword": password_controller.text,
//         "xoldpass": widget.xoldpass,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       Navigator.pushAndRemoveUntil(
//           context, MaterialPageRoute(builder: (context) => Login_page()), (route) => false);
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Success'),
//             content: Text('Password successfully changed.'),
//             actions: [
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Handle other responses or errors
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
//             image: AssetImage("assets/images/logo/background_image.jpeg"), // Add your image path here
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formkeypass,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Image(
//                   //   height: MediaQuery.of(context).size.height/2,
//                   //   width: double.infinity,
//                   //   image: AssetImage('assets/images/logo/gazi_logo.png'),
//                   // ),
//                   Text(
//                     "Change Your Password Here",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blueAccent,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   buildPasswordField("Old Password", old_password_controller, _isOldPasswordVisible, () {
//                     setState(() {
//                       _isOldPasswordVisible = !_isOldPasswordVisible;
//                     });
//                   }),
//                   SizedBox(height: 10),
//                   buildPasswordField("New Password", password_controller, _isNewPasswordVisible, () {
//                     setState(() {
//                       _isNewPasswordVisible = !_isNewPasswordVisible;
//                     });
//                   }),
//                   SizedBox(height: 10),
//                   buildPasswordField("Confirm Password", password_controller_confirm, _isConfirmPasswordVisible, () {
//                     setState(() {
//                       _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                     });
//                   }),
//                   SizedBox(height: 20),
//                   Container(
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.blueGrey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 8,
//                           offset: Offset(4, 4),
//                         ),
//                       ],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: resetPassword,
//                       child: Text(
//                         'Submit',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontSize: 17,
//                         ),
//                       ),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
//                         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                         padding: MaterialStateProperty.all<EdgeInsets>(
//                           EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                         ),
//                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         elevation: MaterialStateProperty.all(0), // Remove default elevation shadow
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildPasswordField(String label, TextEditingController controller, bool isVisible, VoidCallback toggleVisibility) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         obscureText: !isVisible,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(color: Colors.blueGrey),
//           suffixIcon: IconButton(
//             icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: Colors.blue),
//             onPressed: toggleVisibility,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.blueGrey, width: 2),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.blueGrey, width: 2),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           filled: true,
//           fillColor: Colors.white12.withOpacity(0.8),
//         ),
//         style: TextStyle(color: Colors.blueAccent),
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data_model/loginModel.dart';
import '../sales/constant/app_constants.dart';
import 'login_page.dart';

class Confirm_password_user extends StatefulWidget {
  final String xposition;
  final String xoldpass;

  LoginModel loginModel;

  Confirm_password_user({required this.xposition, required this.xoldpass, required this.loginModel});

  @override
  State<Confirm_password_user> createState() => _Confirm_password_userState();
}

class _Confirm_password_userState extends State<Confirm_password_user> {
  GlobalKey<FormState> _formkeypass = GlobalKey();

  TextEditingController old_password_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController password_controller_confirm = TextEditingController();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  resetPassword() async {
    if (_formkeypass.currentState?.validate() ?? false) {
      // Form is valid, continue with password reset
      if (password_controller.text != password_controller_confirm.text) {
        // Show dialog if passwords do not match
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('New Password and Confirm Password do not match.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
        return; // Stop the function if passwords do not match
      }else if (widget.loginModel.xpassword != old_password_controller.text) {
        // Show dialog if passwords do not match
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('New Password and Old Password do not match.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
        return; // Stop the function if passwords do not match
      }

      // Continue with password reset if passwords match
      final response = await http.post(
        Uri.parse("http://${AppConstants.baseurl}/gazi/change_pass.php"),
        body: jsonEncode(<String, String>{
          "zemail": widget.loginModel.zemail,
          "xpassword": password_controller.text,
          "xoldpass": widget.xoldpass,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => Login_page()), (route) => false);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Password successfully changed.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Handle other responses or errors
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage("assets/images/logo/background_image.jpeg"), // Add your image path here
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkeypass,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Change Your Password Here",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  buildPasswordField("Old Password", old_password_controller, _isOldPasswordVisible, () {
                    setState(() {
                      _isOldPasswordVisible = !_isOldPasswordVisible;
                    });
                  }),
                  SizedBox(height: 10),
                  buildPasswordField("New Password", password_controller, _isNewPasswordVisible, () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  }),
                  SizedBox(height: 10),
                  buildPasswordField("Confirm Password", password_controller_confirm, _isConfirmPasswordVisible, () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  }),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: resetPassword,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Remove default elevation shadow
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField(String label, TextEditingController controller, bool isVisible, VoidCallback toggleVisibility) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blueGrey),
          suffixIcon: IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: Colors.blue),
            onPressed: toggleVisibility,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white12.withOpacity(0.8),
        ),
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
