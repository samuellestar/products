import 'package:flutter/material.dart';
import 'package:forms/api/fetch_product_data.dart';
import 'package:forms/models/product_model.dart';

class SerachProductDialog extends StatefulWidget {
  const SerachProductDialog({super.key});

  @override
  State<SerachProductDialog> createState() => _SerachProductDialogState();
}

class _SerachProductDialogState extends State<SerachProductDialog> {
  late Future<List<Product>> productList = fetchData();

  late Future<List<Product>> searchList;

  @override
  void initState() {
    super.initState();
    searchList = productList;
  }

  void updateList(String value) {
    setState(() {
      searchList = productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      // ignore: sized_box_for_whitespace
      content: Container(
        width: 300,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => updateList(value),
              decoration: const InputDecoration(
                hintText: 'Search Product Name',
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(0),
                // ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: searchList,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Product data = snapshot.data[index];
                          return GestureDetector(
                            onTap: (){},
                            child: Card(
                              child: ListTile(
                                title: Text(data.title),
                                subtitle: Text((data.price).toStringAsFixed(2)),
                                // leading: Text('${index + 1}'),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
