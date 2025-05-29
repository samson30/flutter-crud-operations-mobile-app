import 'package:crud_operations_mobile_app/blocs/enroll_employee/enroll_employee_bloc.dart';
import 'package:crud_operations_mobile_app/custom_widgets/alert_popup.dart';
import 'package:crud_operations_mobile_app/custom_widgets/app_exit_popup.dart';
import 'package:crud_operations_mobile_app/custom_widgets/employee_list_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:crud_operations_mobile_app/blocs/employee_list/employee_list_bloc.dart';
import 'package:crud_operations_mobile_app/blocs/employee_list/employee_list_event.dart';
import 'package:crud_operations_mobile_app/blocs/employee_list/employee_list_state.dart';
import 'package:crud_operations_mobile_app/models/employee.dart';
import 'package:crud_operations_mobile_app/pages/enroll_employee_page.dart';
import 'package:crud_operations_mobile_app/common/app_colors.dart';
import 'package:crud_operations_mobile_app/common/app_text_styles.dart';
import 'package:crud_operations_mobile_app/l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => EmployeeListPageState();
}

class EmployeeListPageState extends State<EmployeeListPage> {
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  late EmployeeListBloc employeeBloc;

  @override
  void initState() {
    super.initState();
    employeeBloc = BlocProvider.of<EmployeeListBloc>(context);
    employeeBloc.add(EmployeeListLoadedEvent());
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    employeeBloc.add(EmployeeListLoadedEvent());
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () => onExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            width: double.infinity,
            child: Text(localization.appTitle, style: AppTextStyles.heading),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.accent, AppColors.background],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: BlocConsumer<EmployeeListBloc, EmployeeListState>(
                    listener: (context, state) {
                      if (state is DeleteEmployeeState) {
                        Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!.employeeDeleted,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: AppColors.toastSuccess,
                          textColor: AppColors.toastText,
                          fontSize: AppTextStyles.toast.fontSize ?? 16.0,
                        );
                      } else if (state is EmployeeListErrorState) {
                        Fluttertoast.showToast(
                          msg: state.message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: AppColors.errorColor,
                          textColor: AppColors.toastText,
                          fontSize: AppTextStyles.toast.fontSize ?? 16.0,
                        );
                      }
                    },
                    builder: (context, state) {
                      List<Employee> employees = [];
                      if (state is EmployeeListLoadedState) {
                        employees = state.employees;
                      }
                      if (state is EmployeeListLoadingState) {
                        return EmployeeListShimmer(); // the shimmer effect is added to show when api takes time to load the page
                      }
                      return SmartRefresher(
                        controller: refreshController,
                        onRefresh: onRefresh,
                        onLoading: _onLoading,
                        enablePullDown: true,
                        enablePullUp: false,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          itemCount: employees.length,
                          itemBuilder: (context, i) {
                            final emp = employees[i];
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundColor: AppColors.primary,

                                          child: Text(
                                            emp.firstName[0],
                                            style: AppTextStyles.heading
                                                .copyWith(
                                                  color: AppColors.lightText,
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${emp.firstName} ${emp.lastName}",
                                                overflow: TextOverflow.ellipsis,

                                                style: AppTextStyles.label,
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                "${emp.role.name.toUpperCase()} — ${emp.roleDescription}",
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles.body,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              tooltip: AppLocalizations.of(
                                                context,
                                              )!.edit,
                                              icon: const Icon(
                                                Icons.edit,
                                                color: AppColors.primary,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                          create: (context) =>
                                                              EnrollEmployeeBloc(),
                                                          child:
                                                              EnrollEmployeePage(
                                                                employeeId:
                                                                    emp.id ?? 0,
                                                              ),
                                                        ),
                                                  ),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              tooltip: AppLocalizations.of(
                                                context,
                                              )!.delete,
                                              icon: const Icon(
                                                Icons.delete,
                                                color: AppColors.errorColor,
                                              ),
                                              onPressed: () {
                                                showDeleteConfirmationDialog(
                                                  context,
                                                  () {
                                                    employeeBloc.add(
                                                      DeleteEmployeeEvent(emp),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          tooltip: localization.create,
          child: const Icon(Icons.add, color: AppColors.lightText),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => EnrollEmployeeBloc(),
                  child: const EnrollEmployeePage(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
