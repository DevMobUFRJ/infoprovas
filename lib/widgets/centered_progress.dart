import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';

class CenteredProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Style.mainTheme.primaryColor,
          ),
        ),
      );
}
