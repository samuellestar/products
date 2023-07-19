import 'package:flutter/material.dart';
import 'package:forms/api/fetch_product_data.dart';
import 'package:forms/models/product_model.dart';

class PageProductList extends StatefulWidget {
  const PageProductList({super.key});

  @override
  State<PageProductList> createState() => _PageProductListState();
}

class _PageProductListState extends State<PageProductList> {
  late Future<List<ProductModel>> productList;

  @override
  void initState() {
    super.initState();
    productList = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Product List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 3,
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: productList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  ProductModel data = snapshot.data[index];
                  return ListTile(
                    title: Text(data.title),
                    trailing: Text('₹${data.price}'),
                    // leading: Text('${index + 1}'),
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
    );
  }
}
