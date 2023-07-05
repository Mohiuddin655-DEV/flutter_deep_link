import 'package:flutter/material.dart';
import 'package:flutter_androssy/widgets.dart';
import 'package:go_router/go_router.dart';

class DetailsPage extends StatelessWidget {
  final String? data;

  const DetailsPage({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const RawTextView(
          text: "Details",
          textSize: 20,
          textColor: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: LinearLayout(
        gravity: Alignment.center,
        layoutGravity: LayoutGravity.center,
        children: [
          Button(
            text: "Go Sub Details",
            borderRadius: 12,
            widthMin: 100,
            onClick: (context) => context.pushNamed(
              'sub_details',
              extra: "I'm sub contents!",
              pathParameters: {
                "sq": "products",
                "page": "1",
              },
              queryParameters: {"orderBy": "name", "queryBy": "price"},
            ),
          ),
          TextView(
            text: data,
            textSize: 16,
            textColor: Colors.grey,
            fontWeight: FontWeight.bold,
            background: Colors.grey.shade50,
            padding: 24,
            gravity: Alignment.center,
            width: double.infinity,
            heightMin: 100,
            borderRadius: 24,
            margin: 40,
          ),
        ],
      ),
    );
  }
}
