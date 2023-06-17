import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as WebViewFlutter;
import 'package:flutter_app_testing/screens/quizPage.dart';

class EducationalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Page'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Hazardous and electronic waste deposit site directory in Edmonton '),
            onTap: () {
              // Open article link using WebView
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebPage(
                    url: 'https://www.edmonton.ca/programs_services/garbage_waste/eco-stations',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Compost Facility in Edmonton'),
            onTap: () {
              // Open article link using WebView
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebPage(
                    url: 'https://www.edmonton.ca/programs_services/garbage_waste/edmonton-composting-facility#:~:text=Food%20scraps%20and%20yard%20waste%20collected%20from%20residents%20are%20sent,of%20our%20contracted%20regional%20partners',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('What happens whens you compost?'),
            onTap: () {
              // Open first YouTube video using WebView
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebPage(
                    url: 'https://www.youtube.com/watch?v=oFlsjRXbnSk',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('What happens to the stuff in your recycling bin?'),
            onTap: () {
              // Open second YouTube video using WebView
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebPage(
                    url: 'https://www.youtube.com/watch?v=s4LZwCDaoQM',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Waste Sorting Quiz'),
            onTap: () {
              // Open the waste sorting quiz page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WasteSortingQuizPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class WebPage extends StatelessWidget {
  final String url;

  WebPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
      ),
      body: WebViewFlutter.WebView(
        initialUrl: url,
        javascriptMode: WebViewFlutter.JavascriptMode.unrestricted,
      ),
    );
  }
}

class WasteSortingQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waste Sorting Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Description of Waste Sorting Quiz',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Take Quiz'),
              onPressed: () {
                // Handle quiz button tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
