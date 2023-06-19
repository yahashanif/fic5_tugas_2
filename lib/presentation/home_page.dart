import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/cubit/products_cubit/product_cubit.dart';
import 'package:flutter_ecatalog/data/datasources/local_datasource.dart';
import 'package:flutter_ecatalog/data/models/request/product_request_model.dart';
import 'package:flutter_ecatalog/presentation/add_product_page.dart';
import 'package:flutter_ecatalog/presentation/login_page.dart';
import 'package:flutter_ecatalog/themes/app_theme.dart';

import '../cubit/add_cubit/add_product_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;

  final scrollController = ScrollController();
  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
    context.read<ProductCubit>().getProduct();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context.read<ProductCubit>().nextProduct();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController!.dispose();
    priceController!.dispose();
    descriptionController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: context.theme.appColors.primary,
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () async {
              await LocalDataSource().removeToken();
              context.read<ProductCubit>().clearProduct();
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const LoginPage();
              }));
            },
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return Center(child: CircularProgressIndicator());
          },loaded: (data, offset, limit, isNext) {
             debugPrint('totaldata : ${data.length}');
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                controller: scrollController,
                // reverse: true,
                itemBuilder: (context, index) {
                  if (isNext && index == data.length) {
                    return const Card(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }
                  return Card(
                    child: ListTile(
                      title: Text(
                          data.reversed.toList()[index].title ?? '-'),
                      subtitle: Text('${data[index].price}\$'),
                    ),
                  );
                },
                itemCount:
                    isNext ? data.length + 1 : data.length,
              ),
            );
          },);
        
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.theme.appColors.primary,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const AddProductPage();
          }));
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return AlertDialog(
          //         title: const Text('Add Product'),
          //         content: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             TextField(
          //               controller: titleController,
          //               decoration: const InputDecoration(labelText: 'Title'),
          //             ),
          //             TextField(
          //               controller: priceController,
          //               decoration: const InputDecoration(labelText: 'Price'),
          //             ),
          //             TextField(
          //               controller: descriptionController,
          //               decoration:
          //                   const InputDecoration(labelText: 'Description'),
          //               maxLines: 3,
          //             ),
          //           ],
          //         ),
          //         actions: [
          //           ElevatedButton(
          //               onPressed: () {
          //                 Navigator.pop(context);
          //               },
          //               child: const Text('Cancel')),
          //           const SizedBox(
          //             width: 8,
          //           ),
          BlocConsumer<AddProductCubit, AddProductState>(
            listener: (context, state) 
            {
              state.maybeWhen(orElse: () {
                
              },error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Add Product ${message}')),
                );
              },loaded: (model) {
                   ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add Product Success')),
                );
                 context
                    .read<ProductCubit>()
                    .addSingleProduct(model);
                titleController!.clear();
                priceController!.clear();
                descriptionController!.clear();
                Navigator.pop(context);
              },);
             
            },
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                 return ElevatedButton(
                  onPressed: () {
                    final model = ProductRequestModel(
                      title: titleController!.text,
                      price: int.parse(priceController!.text),
                      description: descriptionController!.text,
                    );

                    context
                        .read<AddProductCubit>()
                        .addProduct( model);
                  },
                  child: const Text('Add'));
              },loading: () {
                 return const Center(
                  child: CircularProgressIndicator(),
                );
              },);
            
             
            },
          );
          //         ],
          //       );
          //     });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
