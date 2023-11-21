import 'package:flutter/material.dart';
import 'package:latihanresponsi/news/news_data_source.dart';
import 'package:latihanresponsi/space_model.dart';

class NewsDetail extends StatefulWidget {
  final int idNews;

  const NewsDetail({Key? key, required this.idNews}) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  late Future<Map<String, dynamic>> _futureNewsDetail;

  @override
  void initState() {
    super.initState();
    _futureNewsDetail = ApiDataSource.instance.loadDetailNews(widget.idNews);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        title: const Text('NEWS DETAIL', style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder(
        future: _futureNewsDetail,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          } else {
            Results newsDetail = Results.fromJson(snapshot.data!);
            return _buildNewsDetail(newsDetail);
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: const Text(
          'See More',
          style: TextStyle(color: Colors.black),
        ),
        icon:
        const Icon(Icons.content_paste_search_rounded, color: Colors.black),
        backgroundColor: const Color(0xFFECDDFF),
      ),
    );
  }

  Widget _buildNewsDetail(Results newsDetail) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            newsDetail.imageUrl ?? '',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            newsDetail.title ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            newsDetail.publishedAt ?? '',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            newsDetail.summary ?? '',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}