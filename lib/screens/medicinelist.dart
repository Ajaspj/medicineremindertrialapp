import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicineremindertrialapp/providers/medication_provider.dart';
import 'package:medicineremindertrialapp/screens/EditMedicationScreen.dart';
import 'package:provider/provider.dart';

class MedicationListScreen extends StatelessWidget {
  MedicationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<MedicationProvider>(
              builder: (context, medicationProvider, child) {
                if (medicationProvider.medications.isEmpty) {
                  return Center(
                    child: Text(
                      'No medications added.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  itemCount: medicationProvider.medications.length,
                  itemBuilder: (context, index) {
                    final medication = medicationProvider.medications[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(16),
                        shadowColor: Colors.indigo.shade100,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigo.shade200,
                                Colors.indigo.shade50,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                medication.name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo[900],
                                ),
                              ),
                              SizedBox(height: 12),
                              _buildInfoCard('Dosage', medication.dosage,
                                  Icons.medical_services, Colors.orange),
                              SizedBox(height: 8),
                              _buildInfoCard(
                                  'Time',
                                  DateFormat.Hm().format(medication.time),
                                  Icons.access_time,
                                  Colors.blue),
                              SizedBox(height: 8),
                              _buildInfoCard(
                                  'Instructions',
                                  medication.instructions,
                                  Icons.notes,
                                  Colors.green),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildActionCard(
                                    context,
                                    icon: Icons.edit,
                                    color: Colors.indigo[600]!,
                                    label: 'Edit',
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditMedicationScreen(
                                                  medication: medication),
                                        ),
                                      );
                                    },
                                  ),
                                  _buildActionCard(
                                    context,
                                    icon: Icons.delete,
                                    color: Colors.red[600]!,
                                    label: 'Delete',
                                    onTap: () {
                                      medicationProvider
                                          .removeMedication(medication.id!);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/addMedication');
        },
        backgroundColor: Colors.white,
        label: Text(
          'Add Medicine',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        icon: Icon(
          Icons.local_pharmacy,
          color: Colors.indigo,
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: _buildAnimatedIcon(icon, color),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo[800],
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon(IconData icon, Color color) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        );
      },
    );
  }

  Widget _buildActionCard(BuildContext context,
      {required IconData icon,
      required Color color,
      required String label,
      required VoidCallback onTap}) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildAnimatedIcon(icon, color),
                SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
