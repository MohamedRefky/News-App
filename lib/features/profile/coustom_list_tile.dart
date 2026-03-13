import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class CoustomListtile extends StatelessWidget {
  const CoustomListtile({super.key, required this.title, required this.leading, this.textColor});
  final String title;
  final String leading;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          textColor: textColor ?? Color(0xFF161F1B),
          title: Text(
            title,
            style: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400),
          ),
          leading: SvgPicture.asset(leading),
          trailing: SvgPicture.asset(
            height: AppSizes.h16,
            width: AppSizes.w16,
            'assets/images/back_Icon.svg',
            colorFilter: ColorFilter.mode(Color(0xFF3A4640), BlendMode.srcIn),
          ),
        ),
        Divider(thickness: 1, color: Color(0xFFD1DAD6)),
      ],
    );
  }
}
