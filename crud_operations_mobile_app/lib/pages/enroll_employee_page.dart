import 'package:crud_operations_mobile_app/blocs/enroll_employee/enroll_employee_bloc.dart';
import 'package:crud_operations_mobile_app/blocs/enroll_employee/enroll_employee_event.dart';
import 'package:crud_operations_mobile_app/blocs/enroll_employee/enroll_employee_state.dart';
import 'package:crud_operations_mobile_app/custom_widgets/custom_input_container.dart';
import 'package:crud_operations_mobile_app/custom_widgets/enroll_employee_shimmer.dart';
import 'package:crud_operations_mobile_app/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/app_colors.dart';
import '../common/app_text_styles.dart';
import '../enums/employee_role.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crud_operations_mobile_app/l10n/app_localizations.dart';

// When edit page opened. the tick mark will appear only after making changes.
class EnrollEmployeePage extends StatefulWidget {
  final int?
  employeeId; // if employee id is sent then this page acts as an edit page
  const EnrollEmployeePage({super.key, this.employeeId});

  @override
  State<EnrollEmployeePage> createState() => _EnrollEmployeePageState();
}

class _EnrollEmployeePageState extends State<EnrollEmployeePage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController roleDescriptionController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  EmployeeRole? selectedRole;
  late EnrollEmployeeBloc employeeBloc;
  Employee? currentEmployee;
  bool isUpdated = false;
  // I will be using this variable to submit date in different format when posting to maintain standards
  String? selectedDate;

  @override
  void initState() {
    super.initState();
    employeeBloc = BlocProvider.of<EnrollEmployeeBloc>(context);
    employeeBloc.add(EnrollEmployeeLoadEvent(employeeId: widget.employeeId));
  }

  Future<void> pickDateOfBirth() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      //I changed date to this format to maintain standards
      final formatted = picked.toUtc().toIso8601String();
      selectedDate = formatted;

      // this is for display purpose
      dobController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  checkIfUpdated() {
    isUpdated =
        ((widget.employeeId != null &&
        currentEmployee != null &&
        (currentEmployee!.role != selectedRole as EmployeeRole ||
            currentEmployee!.roleDescription !=
                roleDescriptionController.text ||
            currentEmployee!.phone != phoneNumberController.text ||
            currentEmployee!.email != emailController.text)));
    employeeBloc.add(EnrollEmployeeLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EnrollEmployeeBloc, EnrollEmployeeState>(
      listener: (context, state) {
        if (state is EnrollEmployeeLoadState && state.currentEmployee != null) {
          currentEmployee = state.currentEmployee;

          firstNameController.text = currentEmployee!.firstName;
          lastNameController.text = currentEmployee!.lastName;
          try {
            final parsed = DateTime.parse(currentEmployee!.dob);
            selectedDate = dobController.text;
            dobController.text = DateFormat(
              'dd-MM-yyyy',
            ).format(parsed.toLocal());
          } catch (e) {
            dobController.text = currentEmployee!.dob;
          }
          selectedRole = currentEmployee!.role;
          roleDescriptionController.text = currentEmployee!.roleDescription;
          phoneNumberController.text = currentEmployee!.phone ?? "";
          emailController.text = currentEmployee!.email ?? "";
        } else if (state is EnrollSuccessState) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.employeeCreated,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.toastSuccess,
            textColor: AppColors.toastText,
            fontSize: AppTextStyles.toast.fontSize ?? 16.0,
          );
          Navigator.pop(context);
        } else if (state is UpdateSuccessState) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.employeeDetailsUpdated,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.toastSuccess,
            textColor: AppColors.toastText,
            fontSize: AppTextStyles.toast.fontSize ?? 16.0,
          );
          Navigator.pop(context);
        } else if (state is EnrollFailureState) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.errorColor,
            textColor: AppColors.toastText,
            fontSize: AppTextStyles.toast.fontSize ?? 16.0,
          );
        }
      },
      builder: (context, state) {
        if (state is EnrollEmployeeLoadingState) {
          return EnrollEmployeeShimmer(); // the shimmer effect is added to show when api takes time to load the page
        }
        return Container(
          decoration: BoxDecoration(color: AppColors.primary),
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 40,
                    color: AppColors.lightText,
                  ),
                ),
                title: Text(
                  widget.employeeId != null
                      ? AppLocalizations.of(context)!.updateEmployee
                      : AppLocalizations.of(context)!.enrollEmployee,
                  style: AppTextStyles.heading,
                ),
                backgroundColor: AppColors.primary,
                actions: [
                  Visibility(
                    visible: (widget.employeeId == null) || isUpdated,
                    child: IconButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          employeeBloc.add(
                            SubmitEmployeeEvent(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              dob: selectedDate ?? "",
                              role: selectedRole!,
                              roleDescription: roleDescriptionController.text,
                              email: emailController.text,
                              phone: phoneNumberController.text,
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                        size: 35,
                        color: AppColors.lightText,
                      ),
                    ),
                  ),
                ],
              ),
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.accent, AppColors.background],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        CustomInputContainer(
                          isEnabled: widget.employeeId == null,
                          child: TextFormField(
                            enabled: widget.employeeId == null,
                            controller: firstNameController,
                            style: AppTextStyles.body,
                            decoration: InputDecoration(
                              hintStyle: AppTextStyles.body,
                              border: InputBorder.none,
                              label: RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(context)!.firstName,
                                  style: AppTextStyles.body,
                                  children: widget.employeeId == null
                                      ? [
                                          TextSpan(
                                            text: ' *',
                                            style: TextStyle(
                                              color: AppColors.errorColor,
                                            ),
                                          ),
                                        ]
                                      : null,
                                ),
                              ),
                              labelStyle: AppTextStyles.body,
                            ),
                            validator: (value) => value!.trim().isEmpty
                                ? AppLocalizations.of(context)!.requiredField
                                : null,
                          ),
                        ),
                        Column(
                          children: [
                            CustomInputContainer(
                              isEnabled: widget.employeeId == null,
                              child: TextFormField(
                                enabled: widget.employeeId == null,
                                controller: lastNameController,
                                style: AppTextStyles.body,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: AppTextStyles.body,
                                  label: RichText(
                                    text: TextSpan(
                                      text: AppLocalizations.of(
                                        context,
                                      )!.lastName,
                                      style: AppTextStyles.body,
                                      children: widget.employeeId == null
                                          ? [
                                              TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                  color: AppColors.errorColor,
                                                ),
                                              ),
                                            ]
                                          : null,
                                    ),
                                  ),
                                ),
                                validator: (value) => value!.trim().isEmpty
                                    ? AppLocalizations.of(
                                        context,
                                      )!.requiredField
                                    : null,
                              ),
                            ),
                          ],
                        ),

                        CustomInputContainer(
                          child: TextFormField(
                            controller: emailController,
                            onChanged: (value) {
                              checkIfUpdated();
                            },
                            style: AppTextStyles.body,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: AppTextStyles.body,
                              label: RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(context)!.email,
                                  style: AppTextStyles.body,
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: AppColors.errorColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              labelStyle: AppTextStyles.body,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.requiredField;
                              }
                              final emailRegex = RegExp(
                                r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                              );
                              if (!emailRegex.hasMatch(value)) {
                                return AppLocalizations.of(
                                  context,
                                )!.validEmailError;
                              }
                              return null;
                            },
                          ),
                        ),

                        CustomInputContainer(
                          child: TextFormField(
                            controller: phoneNumberController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9+\s]'),
                              ),
                            ],
                            onChanged: (value) {
                              checkIfUpdated();
                            },
                            style: AppTextStyles.body,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: AppTextStyles.body,
                              label: RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(
                                    context,
                                  )!.phoneNumber,
                                  style: AppTextStyles.body,
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: AppColors.errorColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              labelStyle: AppTextStyles.body,
                            ),
                            validator: (value) {
                              final RegExp irishPhoneRegex = RegExp(
                                r'^(?:\+353|0)8[35679](?:\s?\d{3,4}){2}$',
                              );
                              if (value != null &&
                                  !irishPhoneRegex.hasMatch(value)) {
                                return AppLocalizations.of(
                                  context,
                                )!.validIrishPhoneNumberError;
                              } else if (value == null ||
                                  value.trim().isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.requiredField;
                              }
                              return null;
                            },
                          ),
                        ),
                        CustomInputContainer(
                          isEnabled: widget.employeeId == null,
                          child: TextFormField(
                            enabled: widget.employeeId == null,
                            controller: dobController,
                            readOnly: true,
                            onTap: pickDateOfBirth,
                            style: AppTextStyles.body,
                            validator: (value) => value!.trim().isEmpty
                                ? AppLocalizations.of(context)!.requiredField
                                : null,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(context)!.dob,
                                  style: AppTextStyles.body,
                                  children: widget.employeeId == null
                                      ? [
                                          TextSpan(
                                            text: ' *',
                                            style: TextStyle(
                                              color: AppColors.errorColor,
                                            ),
                                          ),
                                        ]
                                      : null,
                                ),
                              ),
                              border: InputBorder.none,
                              hintStyle: AppTextStyles.body,
                              labelStyle: AppTextStyles.body,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomInputContainer(
                          child: DropdownButtonFormField<EmployeeRole>(
                            value: selectedRole,
                            validator: (value) => value == null
                                ? AppLocalizations.of(context)!.requiredField
                                : null,
                            decoration: InputDecoration(
                              hintStyle: AppTextStyles.body,
                              label: RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(context)!.role,
                                  style: AppTextStyles.body,
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: AppColors.errorColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              border: InputBorder.none,
                              labelStyle: AppTextStyles.body,
                            ),
                            items: EmployeeRole.values.map((role) {
                              return DropdownMenuItem(
                                value: role,
                                child: Text(
                                  role.name[0].toUpperCase() +
                                      role.name.substring(1),
                                  style: AppTextStyles.body,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedRole = value;
                              employeeBloc.add(UpdateRoleEvent(value!));
                              checkIfUpdated();
                            },
                          ),
                        ),

                        CustomInputContainer(
                          child: TextFormField(
                            controller: roleDescriptionController,
                            minLines: 3,
                            maxLines: 10,
                            onChanged: (value) {
                              checkIfUpdated();
                            },
                            style: AppTextStyles.body,
                            decoration: InputDecoration(
                              hintStyle: AppTextStyles.body,
                              border: InputBorder.none,
                              labelText: AppLocalizations.of(
                                context,
                              )!.roleDescription,
                              labelStyle: AppTextStyles.body,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
