import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:social_login/providers/global_provider.dart';
import 'package:social_login/resources/locator.dart';
import 'package:social_login/resources/routes.dart';
import 'package:social_login/resources/theme/app_theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 앱 초기화 완료까지 스플래시 유지
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 카카오 sdk 초기화
  KakaoSdk.init(nativeAppKey: '6dd6e60799eadf16dab92fd5ebf7c7ae');

  // 디펜던시 초기화
  await initDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // 포커스 해재용 위젯
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ChangeNotifierProvider.value(
            value: di<GlobalProvider>(),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: CustomAppThemeData(context).themeData,
              scrollBehavior: const ScrollBehavior(
                  androidOverscrollIndicator:
                      AndroidOverscrollIndicator.stretch),
              initialRoute: 'splash',
              routes: Routes.routeList,
            )));
  }
}
