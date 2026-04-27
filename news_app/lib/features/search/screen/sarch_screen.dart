import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/data/remote_data/news/news_api_servise.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/news%20details/news_details_screen.dart';
import 'package:news_app/features/search/cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SarchScreen extends StatelessWidget {
  const SarchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(NewsRepository(NewsApiService())),
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, title: const Text('Search')),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (BuildContext context, state) {
            final controller = context.read<SearchCubit>();
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
                      itemCount: state.newsTopEverythingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final model = state.newsTopEverythingList[index];
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
                      separatorBuilder: (BuildContext context, int index) => Divider(),
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
