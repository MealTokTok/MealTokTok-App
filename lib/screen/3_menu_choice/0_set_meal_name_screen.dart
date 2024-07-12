import 'package:flutter/material.dart';

class SetMealNameScreen extends StatefulWidget {
  @override
  _SetMealNameScreenState createState() => _SetMealNameScreenState();
}

class _SetMealNameScreenState extends State<SetMealNameScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('반찬 메뉴 구성'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '반찬 도시락 이름을 설정해 주세요.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: '이름을 입력해 주세요.',
                  border: OutlineInputBorder(),
                ),
                // 도시락 이름이 없으면 아래에 경고
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '도시락 이름을 입력해 주세요.';
                  }
                  return null;
                },
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle the next button press if the form is valid
                      debugPrint("이름 입력");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Text(
                    '다음',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}