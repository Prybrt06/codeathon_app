import 'package:codeathon/models/item_model.dart';
import 'package:codeathon/pages/search_page.dart';
import 'package:codeathon/pages/search_result_page.dart';
import 'package:codeathon/provider/item_provider.dart';
import 'package:codeathon/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Myntra",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ItemProvider>(context, listen: false).getAllItem(),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ItemModel> items = snapshot.data;
            return SizedBox(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      // width: 200,
                      // height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Search",
                          border: InputBorder.none
                        ),
                        onFieldSubmitted: (value) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchResultPage(
                              category: value,
                            ),
                          ));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 650,
                    child: GridView.count(
                      padding: const EdgeInsets.all(20),
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: items
                          .map(
                            (e) => ItemWidget(
                              item: e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
