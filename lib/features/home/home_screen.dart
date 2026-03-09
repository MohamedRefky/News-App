import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_controlle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeControlle>(
      create: (BuildContext context) => HomeControlle(),

      child: Consumer<HomeControlle>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: controller.errorMessage?.isNotEmpty ?? false
                ? Center(child: Text(controller.errorMessage!))
                : controller.everythingLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.newsTopHeadlineList.length,
                          itemBuilder: (context, index) {
                            return Text(
                              controller.newsTopHeadlineList[index].title ?? '',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
