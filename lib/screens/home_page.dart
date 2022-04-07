
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_login/providers/global_provider.dart';
import 'package:social_login/providers/home_provider.dart';
import 'package:social_login/resources/locator.dart';
import 'package:social_login/resources/strings.dart';
import 'package:social_login/screens/ep_org_select_page.dart';
import 'package:social_login/widgets/appbar/custom_app_bar.dart';
import 'package:social_login/widgets/button/rounded_button.dart';
import 'package:social_login/widgets/layout/custom_body_container.dart';
import 'package:social_login/widgets/layout/custom_future_builder.dart';
import 'package:social_login/widgets/layout/custom_safe_area.dart';
import 'package:social_login/widgets/layout/custom_scaffold.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appbar: CustomAppBar(
        context: context,
        useDrawer: true,
        usePop: false,
      ),
      useDrawer: true,
      body: CustomFutureBuilder(
        // 유저 정보 조회 후 전역 프로바이더에 저장
        future: context.read<HomeProvider>().getLoginMemberInfo().then((loginMember) {
          context.read<GlobalProvider>().setMember(loginMember);
          print(loginMember);
        }),
        complete: CustomSafeArea(
          isScroll: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _HomePopUpAd(),
              const _HomeBannerSlider(),
              const SizedBox(height: 20.0),
              CustomBodyContainer(
                isScroll: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    _CommonProposalCard(),
                    SizedBox(height: 7.0),
                    _SubMenuCard(),
                    SizedBox(height: 20.0),
                    _ShowSupportsButton(),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}


///
/// 홈 팝업 광고
///
class _HomePopUpAd extends StatelessWidget {
  const _HomePopUpAd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 3));

      int? timeToHidePopUp = preferences.getInt('timeToHidePopUp');
      if (timeToHidePopUp == null) {
        _showPopUpAd(context);
      } else {
        Duration gabTime =
            DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(timeToHidePopUp));
        // if (gabTime.inHours < 24) {
        if (gabTime.inMinutes > 60) {
          _showPopUpAd(context);
        }
      }
    });

    return const SizedBox();
  }

  Future _showPopUpAd(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (_) => ChangeNotifierProvider.value(
          value: context.read<HomeProvider>(),
          child: _popUpBanner(context),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        barrierColor: Colors.black.withAlpha(200),
        // constraints: const BoxConstraints.tightFor(),
      );

  Widget _popUpBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 19.0,
        horizontal: 15.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/images/picture/home_banner.png', fit: BoxFit.cover),
          const SizedBox(height: 15.0),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Selector<HomeProvider, bool>(
                      selector: (_, provider) => provider.notShowToday,
                      builder: (_, isNotShowToday, __) {
                        return TextButton.icon(
                          onPressed: () => context.read<HomeProvider>().toggleNotShowToday(),
                          icon: SvgPicture.asset(isNotShowToday
                              ? 'assets/images/icon/checkbox_selected.svg'
                              : 'assets/images/icon/checkbox.svg'),
                          label: const Text(
                            '오늘 보지 않기',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                          ),
                        );
                        return Radio<bool>(
                          onChanged: (value) => context.read<HomeProvider>().toggleNotShowToday(),
                          value: isNotShowToday,
                          groupValue: true,
                          activeColor: Strings.appPrimaryColor,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          splashRadius: 10.0,
                          toggleable: true,
                        );
                      },
                    ),
                  ],
                ),
              ),
              RoundedButton(
                onPressed: () {
                  context.read<HomeProvider>().applyNotShowToday();
                  Navigator.of(context).pop();
                },
                child: const Text('닫기'),
              ),
              const SizedBox(width: 5.0),
              RoundedButton(
                onPressed: () {
                  launch('https://naver.com', forceSafariVC: false);
                },
                child: const Text('자세히 보기'),
                primary: Colors.white,
                backgroundColor: const Color(0xFF4E4E4E),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

///
/// 홈 배너
///
class _HomeBannerSlider extends StatelessWidget {
  const _HomeBannerSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    // 인디케이터용 인덱스
    int carouselIndex = 0;
    // 나중에 배너 객체로 대체
    int carouselItemCount = 12;

    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black.withAlpha(150),
              ],
              stops: const [0.5, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          position: DecorationPosition.foreground,
          child: CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: carouselItemCount,
            options: CarouselOptions(
              aspectRatio: 1.8 / 1,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlayCurve: Curves.easeInOutQuart,
              autoPlayInterval: const Duration(seconds: 5),
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) => carouselIndex = index,
            ),
            itemBuilder: (context, index, realIndex) => Container(
              color: Colors.red,
              child: Image.asset('assets/images/picture/banner01.png', fit: BoxFit.cover),
            ),
          ),
        ),
        _sliderLeftArrow(carouselController),
        _sliderRightArrow(carouselController),
        _sliderIndicator(carouselController, carouselIndex, carouselItemCount),
      ],
    );
  }

  Widget _sliderIndicator(
    CarouselController carouselController,
    int carouselIndex,
    int carouselItemCount,
  ) {
    bool isAutoPlaying = true;

    return Positioned(
      bottom: 10,
      right: 0,
      left: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              isAutoPlaying
                  ? carouselController.stopAutoPlay()
                  : carouselController.startAutoPlay();
              isAutoPlaying = !isAutoPlaying;
            },
            icon: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
            ),
            padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
            constraints: const BoxConstraints.tightFor(),
          ),
          Text(
            '${carouselIndex + 1}/$carouselItemCount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              letterSpacing: 1.87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliderRightArrow(CarouselController carouselController) {
    return Positioned(
      bottom: 0,
      right: 15,
      child: IconButton(
        onPressed: () => carouselController.nextPage(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutQuart,
        ),
        icon: SvgPicture.asset('assets/images/icon/banner_arrow_right.svg'),
      ),
    );
  }

  Widget _sliderLeftArrow(CarouselController carouselController) {
    return Positioned(
      bottom: 0,
      left: 15,
      child: IconButton(
        onPressed: () => carouselController.previousPage(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutQuart,
        ),
        icon: SvgPicture.asset('assets/images/icon/banner_arrow_left.svg'),
      ),
    );
  }
}

///
/// 시민 정책 카드 버튼
///
class _CommonProposalCard extends StatelessWidget {
  const _CommonProposalCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed('/proposal'),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFCFE3FF),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Stack(
          children: [
            Container(
              height: 150.0,
              padding: const EdgeInsets.symmetric(vertical: 29.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '시민 정책제안',
                    style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 6.0),
                  const Text(
                    '주저리주저리\n블라블라',
                    style: TextStyle(color: Color(0xFF838A92), fontSize: 16.0, letterSpacing: -0.8),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 30,
              bottom: 30,
              child: SvgPicture.asset(
                'assets/images/icon/common_proposal.svg',
              ),
            )
          ],
        ),
      ),
    );
  }
}

///
/// 전문가 및 지역별 제안 현황 카드 버튼
///
class _SubMenuCard extends StatelessWidget {
  const _SubMenuCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.biggest.width < 360) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ExpertProposalOrgSelectPage(),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC2AF),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 150.0,
                        padding: const EdgeInsets.symmetric(vertical: 29.0, horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '전문가\n정책제안',
                              style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 30,
                        bottom: 30,
                        child: SvgPicture.asset('assets/images/icon/expert_proposal.svg'),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 7.0),
              InkWell(
                onTap: () => {},
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE7C1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 150.0,
                        padding: const EdgeInsets.symmetric(vertical: 29.0, horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '지역별\n제안현황',
                              style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 30,
                        bottom: 30,
                        child: SvgPicture.asset('assets/images/icon/proposal.svg'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC2AF),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: 150.0,
                          padding: const EdgeInsets.symmetric(vertical: 29.0, horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '전문가\n정책제안',
                                style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 13,
                          bottom: 13,
                          child: SvgPicture.asset('assets/images/icon/expert_proposal.svg'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 7.0),
              Expanded(
                child: InkWell(
                  onTap: () => {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE7C1),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: 150.0,
                          padding: const EdgeInsets.symmetric(vertical: 29.0, horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '지역별\n제안현황',
                                style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 13,
                          bottom: 13,
                          child: SvgPicture.asset('assets/images/icon/proposal.svg'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

///
/// 후원단체 보기 버튼
///
class _ShowSupportsButton extends StatelessWidget {
  const _ShowSupportsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 13.0),
        decoration: BoxDecoration(
          color: const Color(0xFFDCDCDC),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          '후원단체보기',
          style: Theme.of(context).primaryTextTheme.subtitle2!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
