import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login/data/apis/member_api.dart';
import 'package:social_login/data/apis/sign_api.dart';
import 'package:social_login/data/repository/member_repository.dart';
import 'package:social_login/providers/global_provider.dart';
import 'package:social_login/providers/splash_provider.dart';
import 'package:social_login/repository/sign_repository.dart';

final GetIt di = GetIt.instance;
final http.Client _client = http.Client();
late SharedPreferences preferences;

Future initDependencies() async {
  preferences = await SharedPreferences.getInstance();

  // api & repository
  // 회원가입, 로그인, 비밀번호 찾기 관련
  di.registerSingleton(SignApi(client: _client));
  di.registerSingletonAsync(
    () async => SignRepository(signApi: di<SignApi>()),
  );
  // 회원 관련
  di.registerSingleton(MemberApi(client: _client));
  di.registerSingletonAsync(
    () async => MemberRepository(memberApi: di<MemberApi>()),
  );

  // provider
  di.registerFactory(
    () => GlobalProvider(
      memberRepository: di<MemberRepository>(),
    ),
  );
  di.registerFactory(() => SplashProvider(signRepo: di<SignRepository>()));

  return await di.allReady();
}
