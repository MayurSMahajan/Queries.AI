import 'package:flutter/material.dart';

class Flashcard extends StatelessWidget {
  final int cardNum;
  final Color color;
  final String phrase;
  final String explanation;

  const Flashcard(
      {super.key,
      required this.cardNum,
      required this.color,
      required this.phrase,
      required this.explanation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390,
      width: 280,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              explanation,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
