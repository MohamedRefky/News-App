import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/features/home/home_controlle.dart';
import 'package:provider/provider.dart';

import 'viewall_component.dart';

class TrindingNews extends StatelessWidget {
  const TrindingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            top: 45,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/NEWEST.png',
                  height: 50,
                  width: 125,
                  fit: BoxFit.contain,
                ),
                ViewallComponent(title: 'Trending News', onTap: () {  },),
                SizedBox(
                  height: 140,
                  child: Consumer<HomeControlle>(
                    builder: (BuildContext context, HomeControlle controller, Widget? child) {
                      switch (controller.everyThingStatus) {
                        case RequestStatusEnum.loading:
                          return Center(child: CircularProgressIndicator());
                        case RequestStatusEnum.error:
                          return Center(child: Text(controller.errorMessage!));
                        case RequestStatusEnum.loaded:
                          return ListView.separated(
                            padding: const EdgeInsets.only(left: 16),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(width: 12),
                            itemCount: controller.newsTopEverythingList.take(7).length,
                            itemBuilder: (context, index) {
                              final model = controller.newsTopEverythingList[index];
                              if (controller.newsTopEverythingList[index].urlToImage != null) {
                                return SizedBox(
                                  width: 240,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          model.urlToImage!,
                                          fit: BoxFit.cover,
                                          width: 240,
                                          height: 140,
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withValues(alpha: 0.3),
                                                  Colors.black.withValues(alpha: 0.7),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 60,
                                          left: 12,
                                          right: 12,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.title!,
                                                style: TextStyle(
                                                  color: Color(0xFFFFFCFC),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 12,
                                                          backgroundImage: NetworkImage(
                                                            model.urlToImage ?? '',
                                                          ),
                                                        ),
                                                        SizedBox(width: 6),
                                                        Expanded(
                                                          child: Text(
                                                            model.author ?? '',
                                                            style: TextStyle(
                                                              color: Color(0xFFFFFCFC),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    formatDateTime(model.publishedAt),
                                                    style: TextStyle(
                                                      color: Color(0xFFFFFCFC),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return null;
                            },
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(String? date) {
    if (date == null) return '';

    final deff = DateTime.now().difference(DateTime.parse(date));

    if (deff.inMinutes < 60) {
      return '${deff.inMinutes} minutes ago';
    } else if (deff.inHours < 24) {
      return '${deff.inHours} hours ago';
    } else {
      return '${deff.inDays} days ago';
    }
  }
}
