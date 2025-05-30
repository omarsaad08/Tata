import 'package:flutter/material.dart';
import 'package:tata/data/doctorServices.dart';
import 'package:tata/data/userServices.dart';
import 'package:tata/presentation/components/mainElevatedButton.dart';
import 'package:tata/presentation/components/mainTextField.dart';
import 'package:tata/presentation/components/theme.dart';

class OfflineDoctorBooking extends StatefulWidget {
  const OfflineDoctorBooking({super.key});

  @override
  State<OfflineDoctorBooking> createState() => _OfflineDoctorBookingState();
}

class _OfflineDoctorBookingState extends State<OfflineDoctorBooking> {
  TextEditingController searchController = TextEditingController();
  List doctors = [];
  List filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
    searchController.addListener(_filterDoctors);
  }

  Future<void> _fetchDoctors() async {
    try {
      final data = await DoctorServices.getAllDoctors();
      setState(() {
        doctors = data;
        filteredDoctors = doctors; // Initially, show all doctors
      });
    } catch (e) {
      print("Error fetching doctors: $e");
    }
  }

  void _filterDoctors() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredDoctors = doctors
          .where(
              (doctor) => doctor['users']['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حجز دكتور", style: TextStyle(color: clr(0))),
        centerTitle: true,
        backgroundColor: clr(1),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: mainTextField(
              searchController,
              "بحث عن دكتور",
              Icon(Icons.search),
            ),
          ),
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(child: Text("لا يوجد دكتور متوفر حاليا"))
                : ListView.builder(
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      return DoctorCard(
                        doctor: filteredDoctors[index],
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            "doctorBookingDetails",
                            arguments: filteredDoctors[index],
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Map doctor;
  final VoidCallback onPressed;

  const DoctorCard({super.key, required this.doctor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color: clr(4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['users']['name'],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: clr(0)),
                    ),
                    Text("الخبرة: ${doctor["experience"]} سنوات",
                        style: TextStyle(color: clr(0))),
                  ],
                ),
                Column(
                  children: [
                    FutureBuilder(
                        future: UserServices.getUserImage(80),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.hasError ||
                              !snapshot.hasData) {
                            return Icon(Icons.person);
                          } else {
                            return snapshot.data!;
                          }
                        })
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: mainElevatedButton("تفاصيل", onPressed),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
