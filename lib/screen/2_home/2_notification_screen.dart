import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Notification> notifications = [];
  int count = 1;

  @override
  void initState() {
    addNotify();
    super.initState();
  }

  void addNotify() {
    debugPrint('addNotify');
    notifications.addAll(getTestData(count));
    count++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: const Text('알림'),
        ),
        body: SafeArea(
            child: Column(
          children: [
            _buildNotificationList(),
            _buildButton(),
          ],
        )));
  }

  Widget _buildNotificationList() {
    return Expanded(
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notifications[index].title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text(notifications[index].body, maxLines: 3),
                      const SizedBox(height: 5),
                      Text(notifications[index].formatEntireDateTime(),
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  )),
              Divider(color: Colors.grey[300]),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      height: 50,
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            maximumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.grey[300],
            elevation: 0,
          ),
          focusNode: FocusNode(),
          onPressed: addNotify,
          child: const Text('이전 알림 더보기', style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}

class Notification {
  final String title;
  final String body;
  final DateTime time;

  Notification({
    required this.title,
    required this.body,
    required this.time,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json['title'],
      body: json['body'],
      time: DateTime.parse(json['time']),
    );
  }

  String formatEntireDateTime() {
    return DateFormat('MM월 dd일 hh:mm', 'ko_KR').format(time);
  }
}

List<Notification> getTestData(int suffix) {
  List<Map<String, dynamic>> testData = [
    {
      "title": "회의 알림 $suffix",
      "body": "오전 10시에 회의가 있습니다. $suffix",
      "time": "2024-07-18T11:00:00Z"
    },
    {
      "title": "회의 알림 $suffix",
      "body": "오전 10시에 회의가 있습니다. $suffix",
      "time": "2024-07-18T11:00:00Z"
    },
    {
      "title": "회의 알림 $suffix",
      "body": "오전 10시에 회의가 있습니다. $suffix",
      "time": "2024-07-18T11:00:00Z"
    },
    {
      "title": "점심 시간 $suffix",
      "body": "점심 시간이 시작되었습니다. $suffix",
      "time": "2024-07-18T12:33:00Z"
    },
    {
      "title": "운동 시간 $suffix",
      "body": "오후 4시에 운동 시간이 있습니다. $suffix",
      "time": "2024-07-18T16:00:00Z"
    },
    {
      "title": "운동 시간 $suffix",
      "body": "오후 4시에 운동 시간이 있습니다. $suffix",
      "time": "2024-07-18T16:00:00Z"
    }
  ];

  return testData.map((data) => Notification.fromJson(data)).toList();
}
