import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as WebViewFlutter;
import 'package:flutter_app_testing/screens/quizPage.dart';

import '../main.dart';

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
            title: Text('Want to Learn about Waste Sorting? Here is a list of resourses! Click on the buttons to read/watch \n Dont forget to take the quiz at the end!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF664229),
              ),
            )
          ),
          Divider(height: 20, // Set the height of the divider line
            thickness: 4, // Set the thickness of the divider line
            ),
          ListTile(
            title: Text('Where to throw away waste in Edmonton',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100), // Adjust the radius as desired
            ),
            color: getColor()[200],
            child: ListTile(
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
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100), // Adjust the radius as desired
            ),
            color: getColor()[200],
            child:
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
          ),
           Divider(height: 20, // Set the height of the divider line
            thickness: 4, // Set the thickness of the divider line
            ),
          ListTile(
            title: Text('What happens to waste you throw away?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100), // Adjust the radius as desired
            ),
            color: getColor()[200],
            child:
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
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100), // Adjust the radius as desired
            ),
            color: getColor()[200],
            child:
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
          ),
           Divider(height: 20, // Set the height of the divider line
            thickness: 4, // Set the thickness of the divider line
            ),
          ListTile(
            title: Text('Click below to save on fertilizer and soil, produced by composting food and yard waste collected from your community',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            )
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100), // Adjust the radius as desired
            ),
            color: getColor()[200],
            child:
            ListTile(
              title: Text('Compost giveaway!'),
              onTap: () {
                // Open article link using WebView
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebPage(
                      url: 'https://www.calgary.ca/waste/residential/green-cart-compost-giveaway.html',
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 10, // Set the height of the divider line
            thickness: 4, // Set the thickness of the divider line
            ),

          ListTile(
              title: Text(' \nTest Your Knowledge',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100), // Adjust the radius as desired
            ),
            color: getColor()[200],
            child:
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
                // material
                // Handle quiz button tap
              },
            ),
          ],
        ),
      ),
    );
  }
}