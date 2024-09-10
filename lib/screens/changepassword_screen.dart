import 'package:flutter/material.dart';
import 'package:medicineremindertrialapp/viewmodel/changepasswordViewModel.dart';
import 'package:stacked/stacked.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      viewModelBuilder: () => ChangePasswordViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Change Password'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Current Password'),
                  onChanged: viewModel.updateCurrentPassword,
                ),
                SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'New Password'),
                  onChanged: viewModel.updateNewPassword,
                ),
                SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: 'Confirm New Password'),
                  onChanged: viewModel.updateConfirmPassword,
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await viewModel.changePassword();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Password changed successfully')),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  },
                  child: Text('Change Password'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
