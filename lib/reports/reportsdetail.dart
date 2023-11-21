import 'package:flutter/material.dart';
import 'package:latihanresponsi/reports/reports_data_source.dart';
import 'package:latihanresponsi/space_model.dart';
import 'package:latihanresponsi/base_network.dart';

class ReportsDetail extends StatefulWidget {
  final int idReports;

  const ReportsDetail({Key? key, required this.idReports}) : super(key: key);

  @override
  State<ReportsDetail> createState() => _ReportsDetailState();
}

class _ReportsDetailState extends State<ReportsDetail> {
  late Future<Map<String, dynamic>> _futureReportsDetail;

  @override
  void initState() {
    super.initState();
    _futureReportsDetail = ApiDataSource.instance.loadDetailReports(widget.idReports);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        title: const Text('REPORTS DETAIL', style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder(
        future: _futureReportsDetail,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          } else {
            Results reportsDetail = Results.fromJson(snapshot.data!);
            return _buildReportsDetail(reportsDetail);
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

  Widget _buildReportsDetail(Results reportsDetail) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            reportsDetail.imageUrl ?? '',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            reportsDetail.title ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            reportsDetail.publishedAt ?? '',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            reportsDetail.summary ?? '',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}