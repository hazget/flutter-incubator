// void main() {
//   // Implement an extension on [String], parsing links from a text.
//   //
//   // Extension should return a [List] of texts and links, e.g.:
//   // - `Hello, google.com, yay` ->
//   //   [Text('Hello, '), Link('google.com'), Text(', yay')].
// }
extension ParseLinks on String {
  List<dynamic> parseLinks() {
    final List<dynamic> result = [];
    final RegExp linkRegex = RegExp(r'https?://\S+');

    var remainingText = this;
    while (remainingText.isNotEmpty) {
      final RegExpMatch? match = linkRegex.firstMatch(remainingText);

      if (match != null) {
        // Found a link
        final linkText = match.group(0);
        final textBeforeLink = remainingText.substring(0, match.start);
        
        if (textBeforeLink.isNotEmpty) {
          result.add(textBeforeLink);
        }
        result.add(Link(linkText!));

        // Update the remaining text
        remainingText = remainingText.substring(match.end);
      } else {
        // No more links found
        result.add(remainingText);
        break;
      }
    }

    return result;
  }
}

class Text {
  final String text;
  Text(this.text);
}

class Link {
  final String link;
  Link(this.link);
}

void main() {
  final inputText = 'Hello, check out https://www.google.com, yay, and also visit https://www.example.com';
  final parsedList = inputText.parseLinks();

  for (final item in parsedList) {
    if (item is Text) {
      print('Text: ${item.text}');
    } else if (item is Link) {
      print('Link: ${item.link}');
    }
  }
}

