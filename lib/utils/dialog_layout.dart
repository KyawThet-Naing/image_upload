import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogLayout extends StatelessWidget {
  final String msg;

  const DialogLayout({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding:const EdgeInsets.all(20),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              msg,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                button('Close', onTap: () => Navigator.pop(context)),
                const SizedBox(width: 10),
                button('Copy', onTap: () async {
                  await Clipboard.setData(ClipboardData(text: msg));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied')),
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget button(text, {required Function()? onTap}) {
    return Expanded(
      child: MaterialButton(
        height: 40,
        color: Colors.blue,
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
