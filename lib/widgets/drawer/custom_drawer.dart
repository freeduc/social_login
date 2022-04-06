import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_login/resources/locator.dart';
import 'package:social_login/widgets/layout/custom_safe_area.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomSafeArea(
        isScroll: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const _DrawerHeader(),
            const _MyProfile(),
            const _MyActivity(),
            const _HomeMenuList(),
            Center(
              child: TextButton(
                onPressed: () {
                  preferences.clear();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/signIn',
                    (route) => false,
                  );
                },
                child: const Text('logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// 메뉴 리스트
///
class _HomeMenuList extends StatelessWidget {
  const _HomeMenuList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView(
        itemExtent: 60,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _menuItem(
            context: context,
            text: '시민정책제안',
          ),
          _menuItem(
            context: context,
            text: '전문가 정책제안',
          ),
          _menuItem(
            context: context,
            text: '지역별 제안현황',
          ),
          _menuItem(
            context: context,
            text: '후원단체보기',
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required BuildContext context,
    required String text,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context).primaryTextTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}

///
/// 나의 활동
///  * 제안한 정책, 공감한 정책, 참여한 정책
///
class _MyActivity extends StatelessWidget {
  const _MyActivity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFFF6F3),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Color(0xFFE1E1E1),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          _activityItem(
            title: '제안한\n정책',
            activityCount: '1',
          ),
          _activityItem(
            title: '공감한\n정책',
            isMiddle: true,
          ),
          _activityItem(
            title: '참여한\n정책',
            activityCount: '1',
          ),
        ],
      ),
    );
  }

  Widget _activityItem(
      {required String title, String? activityCount, bool isMiddle = false}) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 28.0),
            decoration: isMiddle
                ? const BoxDecoration(
                    border: Border.symmetric(
                      vertical: BorderSide(
                        color: Color(0xFFE1E1E1),
                        width: 0.5,
                      ),
                    ),
                  )
                : null,
            child: Text(
              title,
              style: TextStyle(
                color: activityCount == null ? const Color(0xFFB7B7B7) : null,
                fontSize: 17.0,
                letterSpacing: -0.85,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -13,
            child: Container(
              width: 26.0,
              height: 26.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: activityCount == null
                    ? Border.all(color: const Color(0xFFE4E4E4))
                    : null,
                shape: BoxShape.circle,
                color: activityCount == null
                    ? Colors.white
                    : const Color(0xFFEF5A2B),
              ),
              child: Text(
                activityCount ?? '0',
                style: TextStyle(
                  color: activityCount == null ? Colors.black : Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

///
/// 드로어 헤더
/// * 로고, 닫기 버튼
///
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo/logo_with_text_horizon.png',
            width: 100.0,
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset('assets/images/icon/close.svg'),
            iconSize: 16.0,
            constraints: const BoxConstraints.tightFor(),
          ),
        ],
      ),
    );
  }
}

///
/// 내정보 컨테이너
/// * 정보수정, 이름, 프로필 이미지 등 출력
///
class _MyProfile extends StatelessWidget {
  const _MyProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/icon/smile_face.svg'),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '임익기님',
                    style:
                        Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  const SizedBox(height: 3.0),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      '정보수정하기   >',
                      style: TextStyle(
                        color: Color(0xFF575757),
                        fontSize: 16.0,
                        letterSpacing: -1.44,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SvgPicture.asset('assets/images/icon/edit_pencil.svg'),
        ],
      ),
    );
  }
}
