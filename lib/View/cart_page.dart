import 'package:flutter/material.dart';
import '../Services/cart_service.dart';
import '../theme/app_colors.dart';

class CartPage extends StatefulWidget {

  final Map? product;

  const CartPage({super.key, this.product});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),

      body: AnimatedBuilder(
        animation: cartService,
        builder: (context, child) {
          return Column(
            children: [

              Expanded(
                child: ListView.builder(
                  itemCount: cartService.items.length,
                  itemBuilder: (context,index){

                    final item = cartService.items[index];
                    final product = item.product;

                    String name = product["name"] ?? "Product";
                    String priceStr = product["discountPrice"]?.toString() ?? product["price"]?.toString() ?? "0";
                    String image = product["image"] ?? "https://via.placeholder.com/150";

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [

                            Image.network(
                              image,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),

                            const SizedBox(width:10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 4),
                                  
                                  Row(
                                    children: [
                                      Text(
                                        "Size: ${item.selectedSize.split(' ')[0]}",
                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: item.selectedColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.grey.shade300, width: 1),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "₹$priceStr",
                                    style: const TextStyle(
                                        color: AppColors.primaryGold,
                                        fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              children: [

                                IconButton(
                                    onPressed: (){
                                      cartService.decreaseQty(index);
                                    },
                                    icon: const Icon(Icons.remove_circle_outline)
                                ),

                                Text(item.qty.toString()),

                                IconButton(
                                    onPressed: (){
                                      cartService.increaseQty(index);
                                    },
                                    icon: const Icon(Icons.add_circle_outline)
                                ),
                              ],
                            ),

                            IconButton(
                                onPressed: (){
                                  cartService.remove(index);
                                },
                                icon: const Icon(Icons.delete,color: Colors.red)
                            )

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        color: Colors.black12
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "Total: ₹${cartService.total.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGold,
                        foregroundColor: AppColors.textBlack,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "checkout");
                      },
                      child: const Text("Checkout"),
                    )

                  ],
                ),
              )

            ],
          );
        }
      ),
    );
  }
}
