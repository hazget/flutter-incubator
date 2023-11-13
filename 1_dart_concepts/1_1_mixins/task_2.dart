extension StringLinkParser on String {
  List<Linkable> parseLinks() {
    final List<Linkable> result = [];
    final UriMatcher uriMatcher = UriMatcher();

    final matches = uriMatcher.allMatches(this);

    int start = 0;

    for (final match in matches) {
      if (match.start > start) {
        result.add(Text(this.substring(start, match.start)));
      }

      result.add(Link(this.substring(match.start, match.end)));

      start = match.end;
    }

    if (start < length) {
      result.add(Text(this.substring(start)));
    }

    return result;
  }
}

class UriMatcher {
  static final RegExp _uriRegex =
      RegExp(r'http[s]?:\/\/(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');

  Iterable<Match> allMatches(String input) => _uriRegex.allMatches(input);
}

abstract class Linkable {}

class Text implements Linkable {
  final String text;

  Text(this.text);
}

class Link implements Linkable {
  final String url;

  Link(this.url);
}

void main() {
  final textWithLinks = 'Hello, check out https://google.com or visit https://example.com, yay';
  
  final parsedItems = textWithLinks.parseLinks();
  
  for (final item in parsedItems) {
    if (item is Text) {
      print('Text: ${item.text}');
    } else if (item is Link) {
      print('Link: ${item.url}');
    }
  }
}