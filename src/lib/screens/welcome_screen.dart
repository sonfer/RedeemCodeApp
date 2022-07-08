import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModels/auth/auth_view_model.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AuthViewModel>(context);
    return Container();
  }
}
