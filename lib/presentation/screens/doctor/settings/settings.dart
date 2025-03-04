import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/theme.dart';

class DoctorSettings extends StatefulWidget {
  const DoctorSettings({super.key});

  @override
  State<DoctorSettings> createState() => _DoctorSettingsState();
}

class _DoctorSettingsState extends State<DoctorSettings> {
  List screens = [
    {"icon": Icon(Icons.person), "name": "الحساب", "route": "accountHome"}
  ];
  Future<String?> getImageUrl() async {
    // final user = await Auth.getUser('${TataUser.id!}', TataUser.type!);
    // return user!['profile_image_path'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FutureBuilder(
            future: getImageUrl(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else if (snapshot.hasError) {
                return Container();
              } else {
                return Image.network(
                  'http://192.168.1.219:3000/${snapshot.data}',
                  width: 160,
                  height: 160,
                );
              }
            },
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: ListView.builder(
              itemCount: screens.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, screens[index]['route']);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: clr(4),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          screens[index]['icon'],
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            screens[index]['name'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
