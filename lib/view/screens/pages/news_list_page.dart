import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view/components/article_tile.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/viewmodel/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../components/search_bar.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NewsListViewModel>();

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getNews(searchType: SearchType.CATEGORY, category: categories[0]));
    }


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
                Expanded(
                  child: Consumer<NewsListViewModel>(
                    builder: (context, model, child){
                      return model.isLoading
                      ? Center(child: CircularProgressIndicator(),)
                      :ListView.builder(
                        itemCount: model.articles.length,
                        itemBuilder: (context, int position) 
                        => ArticleTile(
                          article: model.articles[position], 
                          onArticleClicked: (article) => 
                            _openArticleWebPage(article, context),
                          )
                      );
                    } 
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> onRefresh(BuildContext context) async{
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
  }
  Future<void> getKeywordNews(BuildContext context, keyword) async{
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: SearchType.KEYWORD, 
      keyword: keyword, 
      category: categories[0],
    );
  }
  Future<void> getCategoryNews(BuildContext context, category) async{
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
      searchType: SearchType.CATEGORY, 
      category: category,
    );
  }
  //TODO
  _openArticleWebPage(article, BuildContext context) {}
}