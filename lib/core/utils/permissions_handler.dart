import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status == PermissionStatus.granted;
  }

  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }

  static Future<bool> requestStoragePermission() async {
    if (await Permission.storage.isGranted) {
      return true;
    }

    final status = await Permission.storage.request();

    if (status != PermissionStatus.granted) {
      final photos = await Permission.photos.request();
      return photos == PermissionStatus.granted;
    }

    return status == PermissionStatus.granted;
  }

  static Future<bool> requestAllPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
      Permission.storage,
      Permission.photos,
    ].request();

    return statuses.values.every(
      (status) =>
          status == PermissionStatus.granted ||
          status == PermissionStatus.limited,
    );
  }
}
