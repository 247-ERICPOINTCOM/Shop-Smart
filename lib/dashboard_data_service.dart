import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveDashboardData(Map<String, dynamic> data) async {
    await _firestore.collection('dashboardData').doc('userData').set(data);
  }

  Future<Map<String, dynamic>> getDashboardData() async {
    final snapshot = await _firestore.collection('dashboardData').doc('userData').get();
    return snapshot.data() as Map<String, dynamic>;
  }
}
