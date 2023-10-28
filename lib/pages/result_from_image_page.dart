import 'package:codeathon/models/item_model.dart';
import 'package:codeathon/provider/item_provider.dart';
import 'package:codeathon/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultFromImagePage extends StatelessWidget {
  final String category;
  const ResultFromImagePage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: FutureBuilder(
        future: Provider.of<ItemProvider>(context, listen: false)
            .getSpecificItemFromImage(category: category),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ItemModel> items = snapshot.data;
            return Container(
              child: GridView(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: items
                    .map(
                      (e) => ItemWidget(
                        item: e,
                      ),
                    )
                    .toList(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
