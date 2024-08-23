// import 'package:flutter/material.dart';
// import 'package:ntp/ntp.dart';
// import 'package:intl/intl.dart';
//
// class OrderScreen extends StatefulWidget {
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }
//
// class _OrderScreenState extends State<OrderScreen> {
//   String selectedSubscription = '';
//   bool isButtonActivated = false;
//
//   bool isTodayLunchSelected = false;
//   bool isTodayEveningSelected = false;
//   bool isTomorrowLunchSelected = false;
//   bool isTomorrowEveningSelected = false;
//   DateTime? currentTime;
//
//   late DateTime now;
//   late DateTime todayLunch;
//   late DateTime todayEvening;
//   late DateTime tomorrowLunch;
//   late DateTime tomorrowEvening;
//   void _setSubscription(String subscription) {
//     if (isButtonActivated) {
//       setState(() {
//         selectedSubscription = subscription;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentTime();
//     now = currentTime!;
//     todayLunch = DateTime(now.year, now.month, now.day, 12, 0);
//     todayEvening = DateTime(now.year, now.month, now.day, 18, 0);
//     tomorrowLunch = DateTime(now.year, now.month, now.day + 1, 12, 0);
//     tomorrowEvening = DateTime(now.year, now.month, now.day + 1, 18, 0);
//   }
//
//   void _getCurrentTime() async {
//     DateTime now = DateTime.now();
//     setState(() {
//       currentTime = now;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('반찬 도시락 구매'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child : Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '구독방식 선택',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   _buildSubscriptionButton('일 결제'),
//                   SizedBox(width: 10),
//                   _buildSubscriptionButton('주간 결제'),
//                 ],
//               ),
//               SizedBox(height: 20),
//               _buildSubscriptionDetails(),
//               Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Handle the next button press
//                     setState(() {
//                       isButtonActivated = true;
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     backgroundColor: Colors.grey[300],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(0),
//                     ),
//                   ),
//                   child: Text(
//                     '다음',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//     );
//   }
//
//   Widget _buildSubscriptionButton(String text) {
//     bool isSelected = false;
//     if (isButtonActivated) {
//       isSelected = selectedSubscription == text;
//     }
//
//     return Center(
//       child: ElevatedButton(
//         onPressed: () => _setSubscription(text),
//         style: ElevatedButton.styleFrom(
//           minimumSize: const Size(double.infinity, 50),
//           elevation: 0,
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(0),
//             side: BorderSide(
//               color: isSelected ? Colors.deepPurple : Colors.grey,
//             ),
//           ),
//         ),
//         child: Text(text,
//             style: TextStyle(
//                 fontSize: 16,
//                 color: isSelected ? Colors.black : Colors.grey,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
//       ),
//     );
//   }
//
//   Widget _buildSubscriptionDetails() {
//     return isButtonActivated
//         ? selectedSubscription == '일 결제'
//             ? _buildDayOrder()
//             : _buildWeekOrder()
//         : _buildOrderGuide();
//   }
//
//   Widget _buildOrderGuide() {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(0),
//         color: Colors.grey[200],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 '구독방식',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               Spacer(),
//               IconButton(
//                 icon: Icon(Icons.close),
//                 onPressed: () {
//                   setState(() {
//                     selectedSubscription = '';
//                   });
//                 },
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           const Text("일 결제",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           const Text(
//             '12시 배달을 원하실 경우에는 10시까지,\n'
//             '6시 배달을 원하실 경우에는 4시까지\n'
//             '결제를 완료해 주세요!\n\n'
//             '결제 시간이 지나면 상품이 ‘내일’ 배달돼요.',
//             style: TextStyle(fontSize: 16),
//           ),
//           SizedBox(height: 30),
//           const Text("주간 결제",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           const Text(
//             '지정하신 날짜와 메뉴대로 배달이 진행돼요.\n\n'
//             '지정하신 날짜에 메뉴를 변경하고 싶다면,\n'
//             '배달 받는 시간 2시간 전까지 수정해 주세요!\n'
//             '(12시 -> 10시, 6시 -> 4시)\n\n'
//             '2시간 이후 결제되면 수정이 불가능하다는 점 꼭 유\n'
//             '의해 주세요!',
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDayOrder() {
//
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '시간 선택',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         Container(
//           width: double.infinity,
//           height: 50,
//           color: Colors.grey[200],
//           child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Center(
//                 child: Text(
//                   '도시락을 받고 싶은 시간대를 선택해 주세요.',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//               )),
//         ),
//         SizedBox(height: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '오늘 (${DateFormat('MM/dd').format(now)})',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             now.isBefore(todayLunch.subtract(Duration(hours: 2)))
//                 ? CheckboxListTile(
//                     title: Text('점심 (12시 ~ 1시)'),
//                     value: isTodayLunchSelected,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isTodayLunchSelected = value!;
//                       });
//                     },
//                   )
//                 : SizedBox(),
//             now.isBefore(todayEvening.subtract(Duration(hours: 2)))
//                 ? CheckboxListTile(
//                     title: Text('저녁 (6시 ~ 7시)'),
//                     value: isTodayEveningSelected,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isTodayEveningSelected = value!;
//                       });
//                     },
//                   )
//                 : SizedBox(),
//           ],
//         ),
//         SizedBox(height: 20),
//         Text(
//           '내일 (${DateFormat('MM/dd').format(tomorrowLunch)})',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         CheckboxListTile(
//           title: Text('점심 (12시 ~ 1시)'),
//           value: isTomorrowLunchSelected,
//           onChanged: (bool? value) {
//             setState(() {
//               isTomorrowLunchSelected = value!;
//             });
//           },
//         ),
//         CheckboxListTile(
//           title: Text('저녁 (6시 ~ 7시)'),
//           value: isTomorrowEveningSelected,
//           onChanged: (bool? value) {
//             setState(() {
//               isTomorrowEveningSelected = value!;
//             });
//           },
//         ),
//         _buildSelectMenu(),
//       ],
//     );
//   }
//
//   Widget _buildSelectMenu() {
//
//     return (isTodayLunchSelected ||
//         isTodayEveningSelected ||
//         isTomorrowLunchSelected ||
//         isTomorrowEveningSelected)
//         ? Column(
//       children: [
//         Container(
//                 width: double.infinity,
//                 height: 50,
//                 color: Colors.grey[200],
//                 child: const Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Center(
//                       child: Text(
//                         '선택하신 날짜에 받고싶은 도시락을 정해주세요',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )),
//               ),
//         Text(
//           '오늘 (${DateFormat('MM/dd').format(now)})',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         isTodayLunchSelected
//             ? Column(
//           children: [
//             CheckboxListTile(
//               title: Text('점심 (12시 ~ 1시)'),
//               value: isTodayLunchSelected,
//               onChanged: (bool? value) {
//                 setState(() {
//                   isTodayLunchSelected = value!;
//                 });
//               },
//             ),
//             //_buildMenuList(),
//           ],
//         )
//             : SizedBox(),
//         Text(
//           '내일 (${DateFormat('MM/dd').format(tomorrowLunch)})',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ],
//     ) : SizedBox();
//   }
//
//   Widget _buildWeekOrder() {
//     return SizedBox();
//   }
// }
