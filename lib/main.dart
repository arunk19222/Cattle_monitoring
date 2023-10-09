import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_veltech_project/LoginPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: Splash_screen(),
    theme: ThemeData(
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.white.withOpacity(0))),
    debugShowCheckedModeBanner: false,
  ));
}

class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: Duration(seconds: 4))
        ..repeat(reverse: true);
  late final Animation<double> animation =
      CurvedAnimation(parent: controller, curve: Curves.easeIn);
  late int size,arun,sd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: animation,
            child: Image.asset('assets/images/cow_symbol.png'),
          ),
          FadeTransition(
            opacity: animation,
            child: Text(
              "Cattle Monitoring",
              style: TextStyle(
                  fontFamily: 'Rajdhani-Regular',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Login_page()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
        controller.dispose();
    super.dispose();
  }
}
