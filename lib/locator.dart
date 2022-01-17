import 'package:get_it/get_it.dart';
import 'package:provider_test/domain/meme_controller.dart';
import 'package:provider_test/responsitory/meme_responsitory.dart';

final locator = GetIt.instance;
void setup() {
  locator.registerLazySingleton<MemeRepo>(() => MemeRepo());
  locator.registerSingleton<AppModelNew>(MemeDomainController(),
      signalsReady: true);
}
