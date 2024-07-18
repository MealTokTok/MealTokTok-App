import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

enum Type {
  onDelivery, // 7월 3일(수) 점심식사가 12시에 배달되어요!
  successDelivery, // 7월 3일(수) 점심식사가 배달 완료 되었어요!
  washingService, //7월 3일(수) 저녁 6시 전까지수거함에 용기를 넣어주세요! (풀대접 서비스)
  successedPay, // 결제가 확인되었습니다.
  canceledPay, // 결제가 취소되었습니다.
}

class Notification {
  final Type type;
  final String title;
  final String body;
  final DateTime time;

  Notification({
    required this.type,
    required this.title,
    required this.body,
    required this.time,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      type: json['type'],
      title: json['title'],
      body: json['body'],
      time: DateTime.parse(json['time']),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('M월 d일(E)', 'ko_KR').format(dateTime);
  }
  String formatEntireDateTime(DateTime dateTime) {
    return DateFormat('MM월 dd일 hh:mm', 'ko_KR').format(dateTime);
  }

  Widget getList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.2),
          ),
          top: BorderSide(
            color: Colors.black.withOpacity(0.2),
          ),
          left: BorderSide(
            color: Colors.black.withOpacity(0.2),
          ),
          right: BorderSide(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getText(),
          const SizedBox(height: 8),
          Text(
            formatEntireDateTime(time),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getText() {
    String date = formatDateTime(time);
    String meal = time.hour == 12 ? "점심식사" : "저녁식사";
    String hour = time.hour == 12 ? "12시" : "19시";

    switch (type) {
      case Type.onDelivery:
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: '$date $meal가 '),
              TextSpan(
                  text: hour, style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '에 배달되어요!'),
            ],
          ),
        );
      case Type.successDelivery:
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: '$date $meal가 '),
              TextSpan(
                  text: '배달 완료', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' 되었어요!'),
            ],
          ),
        );
      case Type.washingService:
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: '$date 저녁 '),
              TextSpan(
                  text: '$time 전 ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '까지 수거함에 용기를 넣어주세요! (풀대접 서비스)'),
            ],
          ),
        );
      case Type.successedPay:
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: ''),
              TextSpan(
                  text: '결제가 확인',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '되었습니다.'),
            ],
          ),
        );
      case Type.canceledPay:
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: ''),
              TextSpan(
                  text: '결제가 취소',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '되었습니다.'),
            ],
          ),
        );
    }
  }
}
