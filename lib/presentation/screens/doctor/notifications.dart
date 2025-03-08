import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';
import 'package:tata/presentation/components/theme.dart';

class DoctorNotifications extends StatefulWidget {
  const DoctorNotifications({super.key});

  @override
  State<DoctorNotifications> createState() => _DoctorNotificationsState();
}

class _DoctorNotificationsState extends State<DoctorNotifications> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> appointments = [];

  Future<int> fetchPendingAppointments() async {
    final doctorId = (await Auth.getCurrentUser(type: "doctor"))!['id'];
    final response = await supabase
        .from('appointments')
        .select('*')
        .eq('doctor_id', doctorId)
        .eq('status', 'requested')
        .order('date', ascending: true);
    print(response);
    if (response.isNotEmpty) {
      setState(() {
        appointments = response;
      });
    }
    return doctorId;
  }

  Future<void> updateAppointmentStatus(int appointmentId, String status) async {
    final response = await supabase
        .from('appointments')
        .update({'status': status}).eq('id', appointmentId);

    if (response.isEmpty) {
      setState(() {
        appointments
            .removeWhere((appointment) => appointment['id'] == appointmentId);
      });
    }
  }

  void initState() {
    super.initState();
    final id = fetchPendingAppointments();

    supabase
        .from('appointments')
        .stream(primaryKey: ['id'])
        .order('date', ascending: true)
        .map((appointments) => appointments
            .where((appointment) =>
                appointment['doctor_id'] == id &&
                appointment['status'] == 'requested')
            .toList())
        .listen((filteredAppointments) {
          setState(() {
            appointments = filteredAppointments;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الاشعارات", style: TextStyle(color: clr(0))),
        centerTitle: true,
        backgroundColor: clr(1),
      ),
      body: appointments.isEmpty
          ? Center(child: Text("لا توجد طلبات جديدة"))
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return Card(
                  child: ListTile(
                    title: Text("طلب موعد"),
                    subtitle: Text(
                        "التاريخ: ${appointment['date']} - الوقت: ${appointment['time']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () => updateAppointmentStatus(
                              appointment['id'], 'approved'),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () => updateAppointmentStatus(
                              appointment['id'], 'declined'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
