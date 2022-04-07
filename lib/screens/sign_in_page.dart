
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:social_login/providers/sign_in_provider.dart';
import 'package:social_login/resources/function.dart';
import 'package:social_login/resources/strings.dart';
import 'package:social_login/widgets/button/filled_button.dart';
import 'package:social_login/widgets/layout/custom_body_container.dart';
import 'package:social_login/widgets/layout/custom_safe_area.dart';
import 'package:social_login/widgets/layout/custom_scaffold.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: CustomSafeArea(
        child: CustomBodyContainer(
          isScroll: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 로고
              Container(
                padding: EdgeInsets.only(
                  top: Functions.getHeight(32.0),
                  bottom: 40.0,
                ),
                child: Image.asset(
                  "assets/images/logo/logo_with_text_horizon.png",
                  fit: BoxFit.fitHeight,
                  height: 65.0,
                ),
              ),
              const _LoginContainer(),
              const SizedBox(height: 25.0),
              const _SnsLoginContainer(),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// 로그인 폼, 버튼, 아이디 찾기
///
class _LoginContainer extends StatelessWidget {
  const _LoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController(text: '01012345678');
    final passwordController = TextEditingController(text: '12345');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 아이디 입력 필드
        _LoginFormField(
          controller: idController,
          label: '아이디',
          isPhone: true,
        ),
        // 비밀번호 입력 필드
        _LoginFormField(
          controller: passwordController,
          label: '비밀번호',
          isPassword: true,
        ),
        const SizedBox(height: 35.0),
        // 로그인 버튼
        _SignInButton(
          idController: idController,
          passwordController: passwordController,
        ),
        const SizedBox(height: 11.0),
        // 회원가입 버튼
        const _SignUpButton(),
        const SizedBox(height: 11.0),
        // 아아디 및 비밀번호 찾기 버튼
        const _FindIdAndPasswordButton()
      ],
    );
  }
}

///
/// 로그인 텍스트 입력 필드
///
class _LoginFormField extends StatelessWidget {
  const _LoginFormField({
    Key? key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.isPhone = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      maxLength: isPhone ? 11 : null,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        counterText: '',
        alignLabelWithHint: true,
        labelStyle: const TextStyle(
          color: Color(0xffB7B7B7),
          fontSize: 19.0,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.54,
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.45,
        ),
      ),
    );
  }
}

///
/// 로그인 버튼
///
class _SignInButton extends StatelessWidget {
  const _SignInButton({
    Key? key,
    required this.idController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController idController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        // 로그인 시도
        final response = await context.read<SignInProvider>().signIn(
              idController.text,
              passwordController.text,
            );

        if (response.success) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        } else {
          Fluttertoast.showToast(msg: response.msg);
        }
      },
      child: const Text(
        '로그인',
        style: TextStyle(
          fontSize: 19.0,
          letterSpacing: -0.54,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.only(
          top: 17.0,
          bottom: 15.0,
        ),
        side: BorderSide(
          width: 1.0,
          color: Strings.appPrimaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

///
/// 회원가입 버튼
///
class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => Navigator.of(context).pushNamed('/signUp/agreements'),
      child: const Text(
        '회원가입',
        style: TextStyle(
          fontSize: 19.0,
          letterSpacing: -0.54,
        ),
      ),
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Strings.appPrimaryColor,
        padding: const EdgeInsets.only(
          top: 17.0,
          bottom: 15.0,
        ),
        side: BorderSide(
          width: 1.0,
          color: Strings.appPrimaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

///
/// 아이디 및 비밀번호 찾기 버튼
///
class _FindIdAndPasswordButton extends StatelessWidget {
  const _FindIdAndPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed('/signIn/findPw'),
      child: const Text('비밀번호 찾기'),
      style: TextButton.styleFrom(
        primary: const Color(0xFF6E6E6E),
        textStyle: const TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }
}

///
/// SNS 로그인 컨테이너
///
class _SnsLoginContainer extends StatelessWidget {
  const _SnsLoginContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            const Divider(
              color: Color(0xFFDFDFDF),
              thickness: 1.0,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text(
                  'SNS 간편로그인',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: -0.51,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          children: const [
            _GoogleLoginButton(),
            SizedBox(width: 13.0),
            _KakaoLoginButton(),
          ],
        ),
        SizedBox(height: Functions.getHeight(15.0)),
        Row(
          children: const [
            _NaverLoginButton(),
            SizedBox(width: 13.0),
            _FacebookLoginButton(),
          ],
        ),
      ],
    );
  }
}

///
/// SNS 아이콘 버튼
///
class _SnsIconButton extends StatelessWidget {
  const _SnsIconButton({
    Key? key,
    required this.name,
    required this.logo,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final String logo;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        icon: Image.asset(logo),
        label: SizedBox(
          width: double.infinity,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 16.0,
              letterSpacing: -1.12,
            ),
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(left: 22.0, right: 30.0),
          minimumSize: const Size(0, 55.0),
          primary: Colors.white,
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );
  }
}

///
/// 구글 로그인 버튼
///
class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SnsIconButton(
      name: '구글',
      logo: 'assets/images/icon/google.png',
      onPressed: () async {
        GoogleSignIn googleSignIn = GoogleSignIn();

        // 구글 로그인 요청
        GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
        print(googleSignInAccount);
      },
    );
  }
}

///
/// 카카오톡 로그인 버튼
///
class _KakaoLoginButton extends StatelessWidget {
  const _KakaoLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SnsIconButton(
      name: '카카오톡',
      logo: 'assets/images/icon/kakaotalk.png',
      onPressed: () async {
        // sns 로그인 api 요청
        final response = await context.read<SignInProvider>().loginWithKakao();
        if (response.code == 200) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        } else {
          Fluttertoast.showToast(msg: response.msg);
        }
      },
    );
  }
}

///
/// 네이버 로그인 버튼
///
class _NaverLoginButton extends StatelessWidget {
  const _NaverLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SnsIconButton(
      name: '네이버',
      logo: 'assets/images/icon/naver.png',
      onPressed: () {},
    );
  }
}

///
/// 페이스북 로그인 버튼
///
class _FacebookLoginButton extends StatelessWidget {
  const _FacebookLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SnsIconButton(
      name: '페이스북',
      logo: 'assets/images/icon/facebook.png',
      onPressed: () {},
    );
  }
}
