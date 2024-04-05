import 'package:flutter/material.dart';
import 'package:yapilacaklarnotlarlisteler/widgets/my_alert_dialog_for_premium.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: currentWidth < 400 ? currentWidth - 10 : 400,
        height: 135,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const MyAlertDialogForPremium());
              },
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            const Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Create task so easy.",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isChecked,
                  side: const BorderSide(color: Colors.white),
                  activeColor: const Color.fromARGB(255, 0, 174, 0),
                  onChanged: (newValue) {
                    isChecked = newValue!;
                    setState(() {});
                  },
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    size: 20,
                    Icons.mode_edit,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    size: 20,
                    Icons.delete_rounded,
                    color: Colors.white,
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

 /* appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "✓&✓",
          style: TextStyle(
            color: Colors.white, //fontFamily: "Lunada"
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: MyGradientColors),
          ),
        ),
      ), */