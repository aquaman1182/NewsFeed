import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/viewmodel/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../components/search_bar.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "更新",
          onPressed: () => onRefresh(context),
          ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                //TODO 検索ワード
                SearchBar(
                  onSearch: (keyword) => getKeywordNews(context, keyword),
                ),
                //TODO カテゴリー選択Chips
                CategoryChips(
                  onCategorySelected: (category) => getCategoryNews(context, category),
                ),
                //TODO 記事表示
                Expanded
                (child: Center(child: CircularProgressIndicator()))
              ],
            ),
          ),
        ),
      ),
    );
  }
  //TODO 記事更新処理
  onRefresh(BuildContext context) {
    final viewModel = context.read<NewsListViewModel>();
    viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
  }
  
  //TODO キーワード記事取得処理
  getKeywordNews(BuildContext context, keyword) {
    final viewModel = context.read<NewsListViewModel>();
    viewModel.getNews(
      searchType: SearchType.KEYWORD, 
      keyword: keyword, 
      category: categories[0],
    );
  }
  //TODO カテゴリー記事取得処理
  getCategoryNews(BuildContext context, category) {
    final viewModel = context.read<NewsListViewModel>();
    viewModel.getNews(
      searchType: SearchType.CATEGORY, 
      category: category,
    );
  }
}