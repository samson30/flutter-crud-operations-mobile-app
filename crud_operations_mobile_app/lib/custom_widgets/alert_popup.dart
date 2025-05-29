import 'package:crud_operations_mobile_app/common/app_colors.dart';
import 'package:crud_operations_mobile_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// Popup to confirm the deletion of the content
void showDeleteConfirmationDialog(
  BuildContext context,
  VoidCallback onConfirm,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          AppLocalizations.of(context)!.deletionConfirmationHeader,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: Text(
          AppLocalizations.of(context)!.employeeDeletionConfirmationText,
          style: TextStyle(fontSize: 16),
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorColor,
              foregroundColor: AppColors.background,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm(); // Used callback for confirming deletion
            },
            icon: const Icon(Icons.delete_forever),
            label: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      );
    },
  );
}
