import 'package:permission_handler/permission_handler.dart';

requestStoragePermission() async {
  PermissionStatus status = await Permission.storage.request();
  //print(status.isDenied);
  if (status.isPermanentlyDenied) openAppSettings();
}
