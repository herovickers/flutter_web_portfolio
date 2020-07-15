import 'package:flutter/material.dart';
import 'package:herovickers_github_io/data/app_strings.dart';
import 'package:herovickers_github_io/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.FULL_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(bodyText2: TextStyle(color: Colors.white)),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
