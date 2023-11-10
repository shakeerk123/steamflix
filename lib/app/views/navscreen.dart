
// import 'package:flutter/material.dart';

// class NavScreen extends StatefulWidget with RouteAware {
//   const NavScreen({super.key});

//   @override
//   State<NavScreen> createState() => _NavScreenState();
// }

// class _NavScreenState extends State<NavScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           return snapshot.hasData ?  MainScreen() : const LoginScreen();
//         },
//       ),
//     );
//   }
// }
