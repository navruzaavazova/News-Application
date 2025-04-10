import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/components/navigation_bar_components/nav_bar.dart';
import 'package:news_app/core/local/set_parameters.dart';
import 'package:news_app/presentation/archive/view/archive_page.dart';
import 'package:news_app/presentation/home/view/home_page.dart';
import 'package:news_app/presentation/main/bloc/news_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pageController = PageController();
  final currentPageIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 26, 27),
        title: const Text(
          'Srochno News',
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          PopupMenuButton<String>(
            color: const Color.fromARGB(255, 26, 26, 27),
            icon: const Icon(
              Icons.language,
              color: Colors.white,
            ),
            onSelected: (String value) async {
              await SetParameters.saveLanguage(value);
              context.read<NewsBloc>().add(GetNewsEvent(
                    country: SetParameters.getSavedLanguage(),
                    category: SetParameters.getSavedCategory(),
                  ));
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                  value: 'us',
                  child: Text('English 🇺🇸',
                      style: TextStyle(color: Colors.white))),
              const PopupMenuItem(
                  value: 'es',
                  child: Text('Español 🇪🇸',
                      style: TextStyle(color: Colors.white))),
              const PopupMenuItem(
                  value: 'fr',
                  child: Text('Français 🇫🇷',
                      style: TextStyle(color: Colors.white))),
              const PopupMenuItem(
                  value: 'de',
                  child: Text('Deutsch 🇩🇪',
                      style: TextStyle(color: Colors.white))),
              const PopupMenuItem(
                  value: 'zh',
                  child:
                      Text('中文 🇨🇳', style: TextStyle(color: Colors.white))),
              const PopupMenuItem(
                  value: 'ar',
                  child: Text('العربية 🇸🇦',
                      style: TextStyle(color: Colors.white))),
              const PopupMenuItem(
                  value: 'ru',
                  child: Text('Русский 🇷🇺',
                      style: TextStyle(color: Colors.white))),
            ],
          ),
        ],
      ),
      extendBody: true,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          currentPageIndex.value = value;
        },
        children: const [
          HomePage(),
          ArchivePage(),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 26, 26, 27),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentPageIndex,
        builder: (context, value, _) {
          return Container(
            height: width / 4.5,
            padding: EdgeInsets.only(bottom: width * 0.05),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 26, 26, 27),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavBarItem(
                  icon: Icons.home_filled,
                  label: 'Home',
                  selected: value == 0,
                  onTap: () {
                    pageController.jumpToPage(0);
                    currentPageIndex.value = 0;
                  },
                  width: width,
                ),
                NavBarItem(
                  width: width,
                  icon: Icons.explore,
                  label: 'Saved',
                  selected: value == 1,
                  onTap: () {
                    pageController.jumpToPage(1);
                    currentPageIndex.value = 1;
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
