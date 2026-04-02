import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
    this.textColor,
    this.trailingColor,
    this.withDivider = true,
  });
  final String title;
  final Widget leading;
  final Function() onTap;
  final bool withDivider;
  final Color? textColor;
  final Color? trailingColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          textColor: textColor ?? Color(0xFF161F1B),
          title: Text(
            title,
            style: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400),
          ),
          leading: leading,
          trailing: SvgPicture.asset(
            height: AppSizes.h16,
            width: AppSizes.w16,
            'assets/images/back_Icon.svg',
            colorFilter: ColorFilter.mode(trailingColor ?? Color(0xFF3A4640), BlendMode.srcIn),
          ),
        ),
        if (withDivider) Divider(thickness: 1, color: Color(0xFFD1DAD6)),
      ],
    );
  }
}
