import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;
  final Widget fallback;

  const AuthGuard({Key key, @required this.child, @required this.fallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print("USER");
    print(user);
    return user == null ? fallback : child;
  }
}
