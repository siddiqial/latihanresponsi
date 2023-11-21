import 'package:flutter/material.dart';
import 'package:latihanresponsi/blogs/blogs_data_source.dart';
import 'package:latihanresponsi/space_model.dart';

class BlogsDetail extends StatefulWidget {
  final int idBlogs;

  const BlogsDetail({Key? key, required this.idBlogs}) : super(key: key);

  @override
  State<BlogsDetail> createState() => _BlogsDetailState();
}

class _BlogsDetailState extends State<BlogsDetail> {
  late Future<Map<String, dynamic>> _futureBlogsDetail;

  @override
  void initState() {
    super.initState();
    _futureBlogsDetail = ApiDataSource.instance.loadDetailBlogs(widget.idBlogs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        title: const Text('BLOGS DETAIL', style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder(
        future: _futureBlogsDetail,
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
