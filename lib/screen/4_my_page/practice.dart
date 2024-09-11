// import 'package:flutter/material.dart';
// import 'package:hankkitoktok/functions/httpRequest.dart';
// import 'package:hankkitoktok/models/user/user.dart';
// import 'package:http/http.dart' as http;
//
// class Practice extends StatefulWidget {
//   const Practice({super.key});
//
//   @override
//   State<Practice> createState() => _PracticeState();
// }
//
// class _PracticeState extends State<Practice> {
//
//   User? user;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUser();
//   }
//
//   // Future<void> fetchUser() async {
//   //   //user = await getUser();
//   //   user = await networkGetRequest111(User(),'api/v1/user/my');
//   //
//   //   setState(() {});
//   // }
//
//   Future<void> fetchUser() async {
//     user = await networkGetRequest111(User(userId: 0, username: '', nickname: '', email: '', phoneNumber: '', profileImageUrl: '', birth: ''), 'api/v1/user/my',null );
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('User Info'),
//         ),
//         body: Center(
//           child: user == null
//               ? CircularProgressIndicator()
//               : Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('userId: ${user!.userId}'),
//               Text('Username: ${user!.username}'),
//               Text('Nickname: ${user!.nickname}'),
//               Text('Email: ${user!.email}'),
//               Text('Phone: ${user!.phoneNumber}'),
//               Text('Birth: ${user!.birth}'),
//             ],
//           ), // Example userId
//         ),
//       ),
//     );
//   }
// }
