import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/local/set_parameters.dart';
import 'package:news_app/presentation/main/bloc/news_bloc.dart';

class CustomTapBar extends StatelessWidget {
  const CustomTapBar({super.key, required this.categories});
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: TabBar(
          isScrollable: true,
          indicatorColor: Colors.red,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
          tabs: categories.map((category) => Tab(text: category)).toList(),
          onTap: (value) async{
            final selectedCategory = categories[value].toLowerCase();
            context.read<NewsBloc>().add(GetNewsEvent(
                  country: SetParameters.getSavedLanguage(),
                  category: selectedCategory,
                ));
            await SetParameters.saveCategory(selectedCategory);
          },
        ),
      ),
    );
  }
}
