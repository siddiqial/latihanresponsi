import 'package:flutter/material.dart';
import 'package:latihanresponsi/reports/reports_data_source.dart';
import 'package:latihanresponsi/space_model.dart';
import 'package:latihanresponsi/reports/reportsdetail.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          centerTitle: true,
          title: const Text("REPORTS LIST", style: TextStyle(color: Colors.black)),
        ),
        body: _buildListUsersBody());
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadReports(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            SpacesModel spacesModel = SpacesModel.fromJson(snapshot.data);
            return _buildSuccessSection(spacesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(SpacesModel results) {
    return ListView.builder(
        itemCount: results.results!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemUsers(results.results![index]);
        });
  }

  Widget _buildItemUsers(Results spacesModel) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportsDetail(idReports: spacesModel.id!),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          color: Color(0xFFF8F2FA),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    spacesModel.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spacesModel.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}