import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../data/routes.dart';
import '../data/wi_widgets.dart';
import '../services/graphql.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

/// #Signing In
class _SignInPageState extends State<SignInPage> {

  /// * This [_formkey] is used to save and validate the values of the signin [Form]
  /// * A user can sign in with either email or username, and password
  ///
  /// [_isLoading] is set to true once the system starts fetching data from the database
  /// and [_isEmailOrUserNameFound] and [_isPasswordFound] are set to true when they are found
  /// and they both match any of the instances(documents) in the fetched data.
  /// [_fetchedUsers] stores the fetched data as a list
  final _formKey = GlobalKey<FormState>();
  String _enteredEmailOrUsername = '';
  String _enteredPassword = '';
  bool _isEmailOrUserNameFound = false;
  bool _isPasswordFound = false;
  bool _isLoading = false;
  List<dynamic> _fetchedUsers = [];

  /// ##Form
  /// There are two [TextFormFields] for email/username and password.
  /// Each field has [validate], [onSaved] and [onChanged] methods
  /// The [SignIn] button uses the form's [_formkey] for form validation
  /// A user can simply click on the two last buttons to create a new account
  /// [context.goNamed] is from the [go_router.dart] and is used for routing,
  /// deep linking and passing data between screens.
  /// The routes are defined in [main.dart]
  @override
  Widget build(BuildContext context) {

    // Signin screen is a [Scaffold] widget which allows the usage of snackbars
    return Scaffold(
        body: Center(
          // [Container] has padding from left, top, right and bottom,
          // thesame margin for all sides and a maximum width.
          // It surrounds all other widgets on screen
      child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          margin: const EdgeInsets.all(35.0),
          constraints: const BoxConstraints(
            maxWidth: 650.0,
          ),

          // The [ListView] allows scrolling in the case of a screen overflow
          // and Elements are wrapped in columns
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      // Embedding and Image from assets
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
                  const Text(
                    "Sign into account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),

                  // SizedBox gives it some spacing
                  const SizedBox(
                    height: 20.0,
                  ),

                  // Displays [CircularProgressIndicator()] when fetching data,
                  // Else an empty box is display
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox(),
                  const SizedBox(height: 20.0),

                  // Sign In form
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5.0),
                      child: Column(
                        children: [
                          // TextFormField for email/username
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.none,
                            decoration: buildTextFieldDecoration(
                              label: "Enter Email or Username",
                            ),
                            onChanged: (value) {
                              setState(() => _enteredEmailOrUsername = value);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter an Email or Username";
                              } else if (!_isEmailOrUserNameFound &&
                                  _enteredPassword.isNotEmpty) {
                                return "User not found";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _fetchedUsers
                                      .where((user) =>
                                          user['email'] == value ||
                                          user['username'] == value)
                                      .isNotEmpty
                                  ? setState(
                                      () => _isEmailOrUserNameFound = true)
                                  : setState(
                                      () => _isEmailOrUserNameFound = false);
                            },
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),

                          // TextFormField for password
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: buildTextFieldDecoration(
                              label: "Enter Password",
                            ),
                            obscureText: true,
                            onChanged: (value) {
                              setState(() => _enteredPassword = value);
                            },
                            validator: (value) {
                              // if (value!.isEmpty) {
                              //   return "Please enter your password";
                              // } else if (!_isPasswordFound &&
                              //     _isEmailOrUserNameFound) {
                              //   return "Incorrect Password";
                              // }
                              // return null;
                            },
                            onSaved: (value) {
                              // _fetchedUsers
                              //         .where((user) =>
                              //             (user['email'] ==
                              //                     _enteredEmailOrUsername ||
                              //                 user['username'] ==
                              //                     _enteredEmailOrUsername) &&
                              //             user['password'] == value)
                              //         .isNotEmpty
                              //     ? setState(() => _isPasswordFound = true)
                              //     : setState(() => _isPasswordFound = false);
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Expanded(

                                // Button which handles validation and submitting
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.goNamed(RouteNames.dashboard);
                                    // _formKey.currentState!.save();
                                    // fetchUsers();
                                    // if (_formKey.currentState!.validate()) {
                                    //   context.goNamed(RouteNames.dashboard);
                                    //   //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    // }
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 20)),
                                  ),
                                  child: const Text("Log In"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(children: <Widget>[
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15)),
                                ),
                                child: const Text(
                                  "Forgotten Password?",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),

                  // Go to sign up buttons
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.goNamed(RouteNames.signup);
                        },
                        child: const Text("Don't have an account"),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          context.goNamed(RouteNames.signup);
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15)),
                        ),
                        child: const Text("Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    ));
  }

  /// ##Fetching users
  /// Fetches all users from database using graphql api.
  /// using [graphql_flutter.dart] package
  /// The [fetchUsers] returns a [Future] and sets [_fetchedUsers] to hold the fetched data.
  /// [_isLoading] is set to true when the function is call
  /// and set back to false at the end of the function
  /// Some [Exception]s are display on a [SnackBar] (which can be used because of the [Scaffold] Widget)
  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    QueryResult queryResult =
        await gqlClient.query(QueryOptions(document: gql("""
            query {
              User {
                username
                email
                password
              }
            }
          """)));

    if (queryResult.hasException) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(queryResult.exception.toString())));
    }

    setState(() {
      _fetchedUsers = queryResult.data!['User'];
      _isLoading = false;
    });

    //print("$_fetchedUsers: ${_fetchedUsers.runtimeType}");
  }
}
