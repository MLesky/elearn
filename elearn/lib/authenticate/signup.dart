import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../data/routes.dart';
import '../data/wi_widgets.dart';

/// #Signing Up
/// There are 3 screens for signing Up
/// ### 1. [SignUpMode]
/// * Gets the type of user
///
/// ### 2. [SignUpInfo]
/// * Gets user's Info
///
/// ### 3. [SignUpCredentials]
/// * Gets user's Credentials


/// #[SignUpMode]
/// This screen lets continue signing up either as an instructor or a student
/// There are 2 buttons;
/// * The first for proceeding as a student
/// * and the second for proceeding as an instructor
/// This is a [StatelessWidget] as no [Widget] is required to change state
/// There is another button giving the user and option to signin instead

class SignUpMode extends StatelessWidget {
  const SignUpMode({super.key});

  /// When either button is pressed, the [mode] is passed through the
  /// @param argument of the [context.goNamed] function
  /// which passes the argument onto the next route
  /// The named routes are defined in [main.dart]
  @override
  Widget build(BuildContext context) {

    // Structure has widgets nested in Columns.
    // Some widgets are separated with spaces by SizedBox
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo-transparent.png',
                    scale: 1.7,
                  ),
                  const Text(
                    "E-learn",
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 40.0,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                "Sign into account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 270,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Button to continue as a student
                        Expanded(
                          child: OutlinedButton(

                            /// .pushNamed takes in the name of the next route
                            /// and the @params paramaters as a map
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                  '/${RouteNames.signup}/info',
                                  params: {'mode': 'student'});
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 20.0))),
                            child:
                                const Text("I want to sign up as a Student"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                  '/${RouteNames.signup}/info',
                                  params: {'mode': 'instructor'});
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 20.0))),
                            child: const Text(
                                "I want to register as an Instructor"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.goNamed(RouteNames.signin);
                    },
                    child: const Text("Already have an account"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.goNamed(RouteNames.signin);
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15)),
                    ),
                    child: const Text("Sign In",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// #[SignUpInfo]
/// This screen gets user's information such as names, username and institute through form fields
/// It also gets the user's profile picture from the local device or avatar;
/// This is a [StatefulWidget] as some widgets change states of their values such as the [TextFormField]s

class SignUpInfo extends StatefulWidget {

  /// This screen has one argument which is the [mode].
  /// this is the user's [mode] (student or instructor) gotton from the [SignUpMode] screen
  const SignUpInfo({super.key, required this.mode});
  final String mode;

  @override
  State<SignUpInfo> createState() => _SignUpInfoState();
}

class _SignUpInfoState extends State<SignUpInfo> {

  /// [_formKey] is used during validation and submitting the form
  /// The form has different fields for getting values
  /// * [userFirstName], [userSecondName], [usersUserName] and [usersInstitute]
  /// * [userImageFile] holds an image [File] selected from the users gallery or camera
  /// * [userImageFilePath] stores the path of the [userImageFile]
  final _formKey = GlobalKey<FormState>();
  String userFirstName = '';
  String userSecondName = '';
  String usersUserName = '';
  String usersInstitute = '';
  String userImageFilePath = '';
  late XFile userImageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                margin: const EdgeInsets.all(15.0),
                constraints: const BoxConstraints(
                  maxWidth: 650.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/logo-transparent.png',
                          scale: 1.7,
                        ),
                        const Text(
                          "E-learn",
                          style: TextStyle(
                            fontFamily: "Pacifico",
                            fontSize: 40.0,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),

                    /// #### form
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Column(
                          children: [
                            const Text(
                              "Sign into account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 20.0),

                            /// [Button] for picking image
                            /// The button's content is [Container] with an almost black and a camera [Icon]
                            MaterialButton(

                              onPressed: () {
                                /// Function for picking image.
                                /// Its parameter is the current context (screen)
                                pickImage(
                                  context: context,
                                );
                              },

                              // Circular container
                              child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.4),
                                  ),

                                  /// Camera icon is displaye if no image is selected
                                  /// Else image is displayed in the container as an avatar
                                  child: userImageFilePath == ''
                                      ? const Center(
                                          child: Icon(
                                            Icons.camera_alt_rounded,
                                            size: 80,
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: FileImage(
                                            File(userImageFilePath),
                                          ),
                                        )),
                            ),
                            const SizedBox(height: 20.0),
                            const Text("Select Avatar",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 20.0),
                            Row(
                              children: [
                                // Get First name
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: buildTextFieldDecoration(
                                      label: "First Name",
                                    ),

                                    /// First name is required
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "required";
                                      }
                                      return null;
                                    },

                                    onSaved: (value) {
                                      setState(() {
                                        userFirstName = value!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),

                                // Get Second name
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: buildTextFieldDecoration(
                                      label: "Second Name",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "required";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        userSecondName = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),

                            // Get usersname
                            TextFormField(
                              decoration:
                                  buildTextFieldDecoration(label: "Username"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  usersUserName = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),

                            //Gets institute
                            TextFormField(
                              decoration: buildTextFieldDecoration(
                                  label:
                                      "Which Institute are you part of? (Optional)"),
                              onSaved: (value) {
                                setState(() {
                                  usersInstitute = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 20)),
                                  ),
                                  child: const Text(
                                    "Back",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                flex: 1,

                                /// ####Submit Button
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      context.pushNamed(
                                        '/signup/credentials',
                                        params: {
                                          'username': usersUserName,
                                          'firstname': userFirstName,
                                          'secondname': userSecondName
                                        },
                                        queryParams: {
                                          'institute': usersInstitute
                                        },
                                      );
                                    }
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 20)),
                                  ),
                                  child: const Text("Continue"),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.goNamed(RouteNames.signin);
                          },
                          child: const Text("Already have an account"),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            context.goNamed(RouteNames.signin);
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15)),
                          ),
                          child: const Text("Sign In",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  /// Pick an Image from camera of gallery
  ///
  /// Displays a dialog box with 2 button;
  /// A camera button and a gallery button
  /// CLicking on the camera button opens the devices camera
  /// and clicking of gallaery opens up the users gallery
  /// And image can be taken and stored by the [ImagePicker] from the [image_picker.dart] package
  /// The [ImagePicker] has a source argument which could either be [ImageSource.camera] or [ImageSource.gallery]
  /// The Future image [File] return is stored in [userImageFile] and the path in the [userImageFilePath]
  /// If no image is selected, a [Snackbar] displays 'no image selected'
  void pickImage({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 160,
                child: Column(
                  children: [
                    const Text(
                      "Select From",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Select from camera
                            TextButton(
                              onPressed: () async {
                                print("klfd");
                                userImageFile = (await ImagePicker()
                                    .pickImage(source: ImageSource.camera))!;
                                if (userImageFile != null) {
                                  setState(() {
                                    userImageFilePath = userImageFile.path!;
                                  });

                                  // closes the dialog box after picking
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    userImageFilePath = '';
                                  });

                                  // displays a snackbar if no image is selected
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar((const SnackBar(
                                    content: Text("No image selected"),
                                  )));
                                }
                              },
                              child: Column(
                                children: const [
                                  Icon(Icons.camera_alt_rounded, size: 80),
                                  Text("Camera"),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            // Select from gallery
                            TextButton(
                              onPressed: () async {
                                print("klfd");
                                userImageFile = (await ImagePicker()
                                    .pickImage(source: ImageSource.gallery))!;
                                if (userImageFile != null) {
                                  setState(() {
                                    userImageFilePath = userImageFile.path!;
                                  });
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    userImageFilePath = '';
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar((const SnackBar(
                                    content: Text("No image selected"),
                                  )));
                                }
                              },
                              child: Column(
                                children: const [
                                  Icon(Icons.photo_outlined, size: 80),
                                  Text("Gallery"),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}


/// #[SignUpCredentials]
/// Gets users credentials; email and password
class SignUpCredentials extends StatefulWidget {
  /// Screen recieves data from the [SignUpInfo] via the routes
  /// Its recieves the [username], [firstname], [secondname] and [institute]
  /// thou [institute] is not required

  const SignUpCredentials({
    super.key,
    required this.username,
    required this.firstname,
    required this.secondname,
    this.institute,
  });

  final String username;
  final String firstname;
  final String secondname;
  final String? institute;

  @override
  State<SignUpCredentials> createState() => _SignUpCredentials();
}

class _SignUpCredentials extends State<SignUpCredentials> {

  /// The [Form] with key [_formKey] gets [userEmail], [userPassword]
  /// and a second password [confirmPassword] for confirmation from user

  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            margin: const EdgeInsets.all(15.0),
            constraints: const BoxConstraints(
              maxWidth: 650.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo-transparent.png',
                      scale: 1.7,
                    ),
                    const Text(
                      "E-learn",
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 40.0,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Column(
                      children: [
                        const Text(
                          "Enter Your Credentials",
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: buildTextFieldDecoration(
                            label: "Enter Email",
                          ),
                          validator: (value) {
                            final regExp =
                                RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
                            if (value!.isEmpty) {
                              return "Please enter an Email or Username";
                            } else if (!regExp.hasMatch(value)) {
                              return "Email is not valid";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userEmail = value!;
                          },
                          onChanged: (value) {
                            setState(() {
                              userEmail = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: buildTextFieldDecoration(
                            label: "Enter Password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "required";
                            } else if (value.length < 8) {
                              return "Password should be atleast 8 characters in length";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userPassword = value!;
                          },
                          onChanged: (value) {
                            setState(() {
                              userPassword = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: buildTextFieldDecoration(
                            label: "Confirm Password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "required";
                            } else if (value != userPassword) {
                              return "Password does not match";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            confirmPassword = value!;
                          },
                          onChanged: (value) {
                            setState(() {
                              confirmPassword = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Row(children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                context.pop();
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 20)),
                              ),
                              child: const Text(
                                "Back",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  context.goNamed(RouteNames.dashboard);
                                }
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 20)),
                              ),
                              child: const Text("Sign Up"),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.goNamed(RouteNames.signin);
                      },
                      child: const Text("Already have an account"),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {
                        context.goNamed(RouteNames.signin);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15)),
                      ),
                      child: const Text("Sign In",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
