import 'package:flutter/material.dart';
import 'package:latihanresponsi/blogs/blogs_data_source.dart';
import 'package:latihanresponsi/space_model.dart';
import 'package:latihanresponsi/blogs/blogsdetail.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key? key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: const Text("BLOGS LIST", style: TextStyle(color: Colors.black)),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadBlogs(),
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
    return const Center(
      child: Text("Error"),
    );
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(SpacesModel results) {
    return ListView.builder(
      itemCount: results.results!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(results.results![index]);
      },
    );
  }

  Widget _buildItemUsers(Results spacesModel) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlogsDetail(idBlogs: spacesModel.id!),
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