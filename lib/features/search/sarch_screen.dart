import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/data/remote_data/api_servise.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/news%20details/news_details_screen.dart';
import 'package:provider/provider.dart';
import 'controller/search_controller.dart';

class SarchScreen extends StatelessWidget {
  const SarchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchScreenController>(
      create: (BuildContext context) =>
          SearchScreenController(NewsRepository(ApiServise())),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search')),
        body: Consumer<SearchScreenController>(
          builder:
              (BuildContext context, SearchScreenController controller, Widget? child) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.w16,
                        vertical: AppSizes.h20,
                      ),
                      child: TextField(
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.geTopEverything();
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          suffixIcon: Icon(
                            Icons.search,
                            size: AppSizes.r30,
                            color: Color(0xFFA0A0A0),
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: AppSizes.sp14,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          itemCount: controller.newsTopEverythingList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final model = controller.newsTopEverythingList[index];
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return NewsDetailsScreen(model: model);
                                    },
                                  ),
                                );
                              },
                              leading: Icon(
                                Icons.search,
                                size: AppSizes.r20,
                                color: Color(0xFFA0A0A0),
                              ),
                              title: Text(
                                model.title ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(),
                        ),
                      ),
                    ),
                  ],
                );
              },
        ),
      ),
    );
  }
}
