import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherDemo extends StatelessWidget {
  const UrlLauncherDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Launcher Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final url = Uri.parse('https://blog.logrocket.com');
                // const url = 'https://www.youtube.com/watch?v=SP_h-m2vmv0';
                try {
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                } catch (e) {
                  debugPrint('Something went wrong');
                }
              },
              child: const Text('Click'),
            ),
          ],
        ),
      ),
    );
  }
}
