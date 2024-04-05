import 'package:flutter/material.dart';
import '../common/colors.dart';

class MyAlertDialogForPremium extends StatelessWidget {
  const MyAlertDialogForPremium({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Yapay zeka ile resimlerinizin otomatik",
                    style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("tanımlanması ve eklenmesi için,",
                    style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "premiyum üyeliği almalısınız.",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: MyGradientColors),
                        //color: Colors.white.withOpacity(0.25),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 120,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        "Satın Al",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
