
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_admin_dashboard/services/local_hive/pref_box.dart';
import 'package:responsive_admin_dashboard/services/network/api_provider.dart';

/// method used for inject all common instances used in app
Future<void> configureDependencies() async {
  /// Hive need a path for storing the data. Note: Web doesn't require
  if (!kIsWeb) {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  GetIt.I.registerSingletonAsync(
    () => PrefBox.getInstance(),
  );
  GetIt.I.registerSingletonAsync(
        () => APIProviderIml.getInstance(),
  );
  // GetIt.I.registerSingletonAsync<GooglePlacesAPI>(
  //   () => GooglePlacesAPI.getInstance(),
  // );
}
