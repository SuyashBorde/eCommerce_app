// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedsize = 0;
  void onTap() {
    if (selectedsize != 0) {
      Provider.of<CartProvider>(context, listen: false).addproduct({  // statemanagement function used to display card item in the screen
        "id": widget.product['id'],                                   // these are dumy data 
        "title": widget.product['title'],
        "price": widget.product['price'],
        "imageUrl": widget.product['imageUrl'],
        "company": widget.product['company'],
        "size": selectedsize,
      });
      ScaffoldMessenger.of(context).showSnackBar(  // if size is selected then the message will pop up
        const SnackBar(
          content: Text(
            "Product Added Successfully",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar( // if size is not selected then this message will pop up
        const SnackBar(
          content: Text(
            "Please Select Size First!",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  // header for the UI 
        title: const Text(
          "Details",
          style: TextStyle(),
        ),
      ),
      body: Column(  // Main Body of UI
        children: [
          Text(
            widget.product["title"] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.product['imageUrl'] as String,
              height: 250,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(  
            height: 248,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 236, 238, 240),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "₹ ${widget.product['price']}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size =
                            (widget.product['sizes'] as List<int>)[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedsize = size;
                              });
                            },
                            child: Chip(
                              label: Text(size.toString()),
                              backgroundColor: selectedsize == size
                                  ? Theme.of(context).colorScheme.primary
                                  : const Color.fromARGB(255, 236, 238, 240),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () => onTap(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      fixedSize: const Size(350, 50),
                    ),
                    child: const Text(
                      "Add To Cart",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
