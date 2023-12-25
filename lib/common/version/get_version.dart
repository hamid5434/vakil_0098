
import '../../model/version/app_version_model.dart';
import '../common.dart';


class GetVersion {
  static AppVersionModel? appVersion;

  static Future<bool> setVersion() async {
    appVersion = await Common.getVersionApp();
    return true;
  }
  static Future<AppVersionModel> getVersion() async{
    appVersion = await Common.getVersionApp();
    return appVersion!;
  }
}