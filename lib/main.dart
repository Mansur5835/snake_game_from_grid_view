import 'package:dome/pages/home.dart';
import 'package:flutter/material.dart';

main(){

  runApp(App());
}



class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
