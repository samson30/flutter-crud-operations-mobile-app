// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Employee Manager';

  @override
  String get enrollEmployee => 'Enroll Employee';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get dob => 'Date of Birth';

  @override
  String get role => 'Role';

  @override
  String get roleDescription => 'Role Description';

  @override
  String get create => 'Create';

  @override
  String get clearAll => 'Clear All Fields';

  @override
  String get requiredField => 'Required';

  @override
  String get employeeCreated => 'Employee created successfully!';

  @override
  String get employeeDetailsUpdated => 'Employee details updated successfully!';

  @override
  String get toastError => 'Something went wrong!';

  @override
  String get employeeDetails => 'Employee Details';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get employeeDeleted => 'The employee has been deleted';

  @override
  String get cancel => 'Cancel';

  @override
  String get employeeDeletionConfirmationText => 'Are you sure you want to delete this employee?';

  @override
  String get deletionConfirmationHeader => 'Confirm Deletion';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get validEmailError => 'Enter valid email';

  @override
  String get validIrishPhoneNumberError => 'Enter a valid Irish number (e.g., 0861234567 or +353861234567).';

  @override
  String get updateEmployee => 'Update Employee';
}
