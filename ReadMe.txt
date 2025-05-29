Below are the steps to launch the application. 
Alternatively, I have provided the apk for the android mobile app (app-release.apk) in case you are unable to run the app due to versions conflict.
Step 1: Open the crud_operations_mobile_app using Visual Studio code.
Step 2: Open a new terminal inside the Visual studio code app.
Step 3: Make sure you are inside the crud_operations_mobile_app directory or else navigate using 'cd crud_operations_mobile_app'. command.
Step 4: Run 'flutter pub get' command.
Step 5: After it finishes, run 'flutter gen-l10n'. (This is need as I have used localization in my project).
Step 6: Run the app using 'flutter run'

Implementation Notes:
 - I have used localization for all the constant strings in the application.
 - In the edit page, the tick button will only get triggered when changes are made.
 - When you click back in your mobile when you are inside the employee list page, I have made sure to ask for confirmation before user exits the application.
 - In the list page, when pulled from top the page refreshes.
 - If you feel the app to stutter when swiping through the list, it might be due to pullToRefresh plugin I have used.
 - I have changed the mobile application's icon.
 - When creating employee, role description field is optional and other fields are mandatory.
 - When editing, some fields will be disabled and cannot be edited.
 - For every errors, I have used flutter toast to show the message to the user.
 - If any data fail to load in the app, please re install the app and check again.
 - Every methods, custom widgets, bloc implementations I have used are based on my previous experience.
 - This is to let you know my skillsets are not only limited to the implemented application.
 - If there is any improvement or correction to be made, please let me know.
