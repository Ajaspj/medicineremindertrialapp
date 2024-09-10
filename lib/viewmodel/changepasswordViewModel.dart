import 'package:firebase_auth/firebase_auth.dart';

import 'package:stacked/stacked.dart';

class ChangePasswordViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fields
  String? _currentPassword;
  String? _newPassword;
  String? _confirmPassword;

  // Getters
  String? get currentPassword => _currentPassword;
  String? get newPassword => _newPassword;
  String? get confirmPassword => _confirmPassword;

  // Update methods
  void updateCurrentPassword(String value) {
    _currentPassword = value;
    notifyListeners();
  }

  void updateNewPassword(String value) {
    _newPassword = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  // Function to update the password
  Future<void> changePassword() async {
    try {
      if (_newPassword != _confirmPassword) {
        throw Exception('Passwords do not match');
      }

      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }

      // Re-authenticate the user with the current password
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: _currentPassword!,
      );
      await user.reauthenticateWithCredential(cred);

      // If re-authentication is successful, update the password
      await user.updatePassword(_newPassword!);
      print('Password updated successfully');
    } catch (e) {
      print('Error changing password: $e');
      throw e;
    }
  }
}
