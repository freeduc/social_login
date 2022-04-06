import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:social_login/resources/function.dart';
import 'package:social_login/resources/strings.dart';
import 'package:social_login/widgets/layout/custom_scaffold.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: _SplashContent());
  }
}

class _SplashContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.microtask(() async {
      // 스플래시 제거
      FlutterNativeSplash.remove();
      // 안정성 딜레이
      await Future.delayed(const Duration(seconds: 3));

      // 개발용 임시 라우팅
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/signIn', (route) => false);
      return;

      // 자동 로그인 처리
      // 성공 시 홈페이지, 실패 시 로그인 페이지
      // if (await context.read<SplashProvider>().autoLogin()) {
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       settings: const RouteSettings(
      //         name: 'home',
      //       ),
      //       builder: (context) {
      //         return const HomePage();
      //       },
      //     ),
      //     (route) => false,
      //   );
      // } else {
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       settings: const RouteSettings(
      //         name: 'login',
      //       ),
      //       builder: (context) {
      //         return const LoginPage();
      //       },
      //     ),
      //     (route) => false,
      //   );
      // }
    });

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/picture/splash_bg.png"),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 9,
            child: Column(
              children: [
                Image.asset("assets/images/logo/logo_with_text.png"),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Campaign for "),
                      TextSpan(
                        text: "Citizen",
                        style: TextStyle(
                          color: Strings.appSecondColor,
                        ),
                      ),
                      const TextSpan(text: " Policy Proposal"),
                    ],
                  ),
                  style: TextStyle(
                    fontFamily: Strings.engFont,
                    fontSize: 13.0,
                  ),
                ),
                Divider(
                  color: const Color(0xffDFDFDF),
                  thickness: 1.0,
                  height: Functions.getHeight(53.0),
                  indent: Functions.getWidth(88.0),
                  endIndent: Functions.getWidth(88.0),
                ),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "시민",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: "에 의해\n"),
                      TextSpan(
                        text: "발전하는 사회",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: "를 만들어갑니다."),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -1.19,
                    height: 1.3,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
