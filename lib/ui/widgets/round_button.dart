import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  String title = "";
  late VoidCallback onTap;
  bool loading;
  RoundButton(
      {super.key, required this.title, required this.onTap, this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child:loading?const CircularProgressIndicator(strokeWidth: 3,color: Colors.white,): Text(
          title,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
