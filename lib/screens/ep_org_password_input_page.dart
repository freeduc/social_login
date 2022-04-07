
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_login/providers/ep_org_password_input_provider.dart';
import 'package:social_login/resources/locator.dart';
import 'package:social_login/resources/strings.dart';
import 'package:social_login/widgets/appbar/custom_app_bar.dart';
import 'package:social_login/widgets/button/button_rectangle_button.dart';
import 'package:social_login/widgets/form/custom_label_form_field.dart';
import 'package:social_login/widgets/layout/custom_body_container.dart';
import 'package:social_login/widgets/layout/custom_safe_area.dart';
import 'package:social_login/widgets/layout/custom_scaffold.dart';

class ExpertOrganizationPasswordInputPage extends StatelessWidget {
  const ExpertOrganizationPasswordInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: di<ExpertOrganizationPasswordInputProvider>(),
      builder: (context, child) {
        // 전달받은 단체 정보를 프로바이더에 저장
        context
            .read<ExpertOrganizationPasswordInputProvider>()
            .setOrganization((ModalRoute.of(context)!.settings.arguments as Map)['organization']);
        return child!;
      },
      child: CustomScaffold(
        useDrawer: true,
        backgroundColor: Strings.appPrimaryColor,
        appbar: CustomAppBar(
          context: context,
          useDrawer: true,
        ),
        body: CustomSafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _OrgPasswordInputForm(),
              BottomRectangleButton(onPressed: () {}, text: '다음'),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrgPasswordInputForm extends StatelessWidget {
  const _OrgPasswordInputForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordCtrl = TextEditingController();
    final String orgName =
        context.read<ExpertOrganizationPasswordInputProvider>().receivedOrganization!.name ?? '';
    return Expanded(
      child: CustomBodyContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 37.0),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: orgName,
                    style: TextStyle(color: Strings.appSecondColor),
                  ),
                  TextSpan(text: '분들\n'),
                  TextSpan(text: '어서오세요.'),
                ],
              ),
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.25,
              ),
            ),
            SizedBox(height: 53.0),
            CustomLabelFormField(
              onTap: () {},
              label: '비밀번호',
              controller: passwordCtrl,
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}
