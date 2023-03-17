import 'package:flutter/material.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/view/components/head_line_item.dart';
import 'package:news_feed/view/components/page_transformer.dart';
import 'package:news_feed/viewmodel/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final viewModel = context.read<HeadLineViewModel>();

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }
    
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<HeadLineViewModel>(
            builder: (context, model, child){
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageTransformer(
                pageViewBuilder: (contect, pageVisibilityResolver) {
                  return PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: model.articles.length,
                  itemBuilder: (context, index){
                    final article = model.articles[index];
                    final pageVisibility = pageVisibilityResolver.resolvePageVisibility(index);
                    final visibleFraction = pageVisibility.visibleFraction;
                    return Opacity(
                      opacity: visibleFraction,
                      child: HeadLineItem(
                        article: article, 
                        pageVisibility: pageVisibility, 
                        onArticleClicked: (article) => _openArticleWebPage(context, article),
                        ),
                    );
                  },
                );
                },
              );
              }
            }
            ),
        ), 
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => onRefresh(context),
          ),
      ),
    );
  }
  //TODO
  onRefresh(BuildContext context) async{
    final viewModel = context.read<HeadLineViewModel>();
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }
  
  //TODO
  _openArticleWebPage(BuildContext context, Article article) {

  }
}