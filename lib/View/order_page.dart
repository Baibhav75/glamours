import 'package:flutter/material.dart';

import 'order_details_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  int selectedTab = 0;

  List<String> tabs = [
    "Pending (10)",
    "Progress (0)",
    "Delivered (0)"
  ];

  List orders = [
    {
      "qty":1,
      "amount":40,
      "track":"890025427"
    },
    {
      "qty":3,
      "amount":248,
      "track":"1201045373"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Order"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          /// TABS
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context,index){

                bool selected = selectedTab == index;

                return GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF8B2A9B)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height:10),

          /// ORDER LIST
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context,index){

                final item = orders[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal:16,
                      vertical:8
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius:4,
                            color: Colors.black12
                        )
                      ]
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Quantity : ${item["qty"]}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text("Total Amount : \$${item["amount"]}")
                        ],
                      ),

                      const SizedBox(height:10),

                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.shade50,
                        child: Text(
                          "Order Tracking Number : ${item["track"]}",
                        ),
                      ),

                      const SizedBox(height:10),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [

                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OrderDetailsPage(),
                                ),
                              );
                            },
                            child: const Text("View Details"),
                          ),

                           Text(
                            "Pending",
                            style: TextStyle(
                                color: Colors.green
                            ),
                          )
                        ],
                      )

                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}