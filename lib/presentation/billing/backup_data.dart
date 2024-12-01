import 'package:e_mandi/data/hive/hive_billing_repository.dart';
import 'package:flutter/material.dart';
import 'package:e_mandi/domain/repositories/billing_repository.dart';

class BackupPage extends StatefulWidget {
  @override
  _BackupPageState createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  bool _isBackingUp = false; // Flag to track if backup is in progress

  // Your backup function
  void backupData() async {
    setState(() {
      _isBackingUp = true; // Show loading indicator
    });

    HiveBillingRepository repo = HiveBillingRepository();
    await repo.backupBillings(); // Perform backup

    setState(() {
      _isBackingUp = false; // Hide loading indicator after backup is done
    });

    // Optionally show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Backup completed successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Backup Data')),
      body: Center(
        child: _isBackingUp
            ? CircularProgressIndicator() // Show loading indicator
            : ElevatedButton(
                onPressed: backupData, // Trigger backup when button is pressed
                child: Text('Backup Data'),
              ),
      ),
    );
  }
}
