
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_login/models/common/api_response.dart';
import 'package:social_login/providers/ep_org_select_provider.dart';
import 'package:social_login/resources/locator.dart';
import 'package:social_login/resources/strings.dart';
import 'package:social_login/screens/ep_org_password_input_page.dart';
import 'package:social_login/widgets/appbar/custom_app_bar.dart';
import 'package:social_login/widgets/button/elevated_rounded_button.dart';
import 'package:social_login/widgets/layout/custom_body_container.dart';
import 'package:social_login/widgets/layout/custom_safe_area.dart';
import 'package:social_login/widgets/layout/custom_scaffold.dart';


class ExpertProposalOrgSelectPage extends StatelessWidget {
  const ExpertProposalOrgSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController orgPageListCtrl = PageController();

    return ChangeNotifierProvider.value(
      value: di<ExpertProposalOrgSelectProvider>(),
      child: CustomScaffold(
        appbar: CustomAppBar(
          context: context,
          useDrawer: true,
        ),
        useDrawer: true,
        body: CustomSafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBodyContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 37.0),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: '해당하는 기업에 들어가\n'),
                          TextSpan(
                            text: '패스워드',
                            style: TextStyle(color: Strings.appSecondColor),
                          ),
                          const TextSpan(text: '를 입력해주세요.'),
                        ],
                      ),
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                  ],
                ),
              ),
              _OrganizationList(orgPageListCtrl: orgPageListCtrl),
              _OrganizationListPagination(orgPageListCtrl: orgPageListCtrl),
              const SizedBox(height: 37.0),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// 단체 페이지
///
class _OrganizationList extends StatelessWidget {
  const _OrganizationList({
    Key? key,
    required this.orgPageListCtrl,
  }) : super(key: key);

  final PageController orgPageListCtrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<ApiResponse>(
        // 단체 리스트 조회 매소드 실행
        future: context.read<ExpertProposalOrgSelectProvider>().getAllOrganization(),
        builder: (context, snapshot) {
          // 조회중
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
            // 조회 완료
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<ExpertProposalOrgSelectProvider>(
              builder: (context, provider, child) {
                // 조회된 단체가 있을 때
                if (provider.orgList.isNotEmpty) {
                  return _organizationListBuilder(provider);
                  // 등록된 단체가 없을 때
                } else {
                  return const Center(
                    child: Text('등록된 단체가 없습니다.'),
                  );
                }
              },
            );
            // 조회 실패
          } else {
            return const Center(
              child: Text('조회 실패'),
            );
          }
        },
      ),
    );
  }

  Widget _organizationListBuilder(ExpertProposalOrgSelectProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 34.0),
      child: PageView.builder(
        controller: orgPageListCtrl,
        itemBuilder: (context, pageIndex) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...List.generate(4, (index) {
                  try {
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: ElevatedRoundedButton(
                          child: Text(
                            provider.orgList[pageIndex * 4 + index].name ?? '',
                            style: Theme.of(context).primaryTextTheme.subtitle2!.copyWith(
                                  color: const Color(0xFF333333),
                                ),
                          ),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ExpertOrganizationPasswordInputPage(),
                              fullscreenDialog: true,
                              settings: RouteSettings(
                                arguments: {'organization': provider.orgList[index]},
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } catch (_) {
                    return Expanded(
                      child: Container(),
                    );
                  }
                }),
              ],
            ),
          );
        },
        itemCount: (provider.orgList.length / 4).ceil(),
      ),
    );
  }
}

///
///  단체 리스트 페이지네이션
///
class _OrganizationListPagination extends StatefulWidget {
  const _OrganizationListPagination({
    Key? key,
    required this.orgPageListCtrl,
  }) : super(key: key);

  final PageController orgPageListCtrl;

  @override
  State<_OrganizationListPagination> createState() => _OrganizationListPaginationState();
}

class _OrganizationListPaginationState extends State<_OrganizationListPagination> {
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.orgPageListCtrl.initialPage;
  }

  /// 이전 페이지로 이동
  void movePreviousPage() {
    // 첫 페이지가 아니라면
    if (currentIndex > 0) {
      // 현재인덱스 - 1 로 이동하기 위해 빼기
      setState(() {
        currentIndex -= 1;
      });
      // 단체 리스트 페이지 이동
      widget.orgPageListCtrl.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutExpo,
      );
      // 페이지네이션 이동
      carouselController.animateToPage(currentIndex);
    }
  }

  /// 선택한 페이지로 이동
  void moveSpecificPage(int index) {
    // 단체 리스트 페이지 이동
    widget.orgPageListCtrl.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutExpo,
    );
    // 페이지네이션 이동
    carouselController.animateToPage(index);
    // 현재인덱스 변수에 저장
    setState(() {
      currentIndex = index;
    });
  }

  /// 다음 페이지로 이동
  void moveNextPage(ExpertProposalOrgSelectProvider provider) {
    // 마지막 페이지가 아니라면
    if (currentIndex < ((provider.orgList.length / 4).floor() - 1)) {
      // 현재인덱스 + 1 로 이동하기 위해 빼기
      setState(() {
        currentIndex += 1;
      });
      // 단체 리스트 페이지 이동
      widget.orgPageListCtrl.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutExpo,
      );
      // 페이지네이션 이동
      carouselController.animateToPage(currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Consumer<ExpertProposalOrgSelectProvider>(
        builder: (_, provider, __) {
          if (provider.orgList.isNotEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () => movePreviousPage(),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Expanded(
                  flex: 3,
                  child: CarouselSlider.builder(
                    carouselController: carouselController,
                    itemBuilder: (context, index, realIndex) {
                      return TextButton(
                        onPressed: () => moveSpecificPage(index),
                        child: FittedBox(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: currentIndex == index ? Colors.black : const Color(0xFFAAAAAA),
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(0.0),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 0.20,
                      initialPage: currentIndex,
                    ),
                    itemCount: (provider.orgList.length / 4).ceil(),
                    // itemCount: (provider.orgList.length / 4).ceil(),
                  ),
                ),
                IconButton(
                  onPressed: () => moveNextPage(provider),
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
                const Spacer(),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
