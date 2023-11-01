import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        child: const Column(
          children: [
            Text(
              "Oops... Couldn't fetch data",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 153, 6, 6),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Icon(
              Icons.do_disturb_alt_outlined,
              size: 34,
              color: Color.fromARGB(255, 153, 6, 6),
            )
          ],
        ),
      ),
    );
  }
}
