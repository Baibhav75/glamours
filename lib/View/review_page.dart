import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  int rating = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Back to Shop"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            const Text(
              "Classic Oxford Shirt",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:18
              ),
            ),

            const SizedBox(height:20),

            const Text("Write Your Reviews"),

            const SizedBox(height:10),

            Row(
              children: List.generate(
                5,
                    (index) => IconButton(
                  onPressed: (){
                    setState(() {
                      rating = index + 1;
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: index < rating
                        ? Colors.yellow
                        : Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height:10),

            const TextField(
              maxLines:4,
              decoration: InputDecoration(
                  hintText:"Write your review",
                  border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height:20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){},
                child: const Text("Submit Review"),
              ),
            ),

            const SizedBox(height:10),

            Center(
              child: TextButton(
                onPressed: (){},
                child: const Text("Not Now"),
              ),
            )

          ],
        ),
      ),
    );
  }
}