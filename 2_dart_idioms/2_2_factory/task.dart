
// Define Board entity using the newtype idiom
class Board {
  final String id;
  final String name;

  Board(this.id, this.name);
}

// Define Message entity using the newtype idiom
class Message {
  final String id;
  final String boardId;
  final String content;
  final String author;

  Message(this.id, this.boardId, this.content, this.author);
}

// Repository interface for Boards
abstract class BoardsRepository {
  List<Board> getAllBoards();
  Board createBoard(String name);
}

// Repository interface for Messages
abstract class MessagesRepository {
  List<Message> getMessagesByBoardId(String boardId);
  Message postMessage(String boardId, String content, String author);
}

// In-memory implementation of BoardsRepository
class InMemoryBoardsRepository implements BoardsRepository {
  final List<Board> _boards = [];

  @override
  List<Board> getAllBoards() => List.unmodifiable(_boards);

  @override
  Board createBoard(String name) {
    final board = Board(DateTime.now().toIso8601String(), name);
    _boards.add(board);
    return board;
  }
}

// In-memory implementation of MessagesRepository
class InMemoryMessagesRepository implements MessagesRepository {
  final List<Message> _messages = [];

  @override
  List<Message> getMessagesByBoardId(String boardId) =>
      _messages.where((msg) => msg.boardId == boardId).toList();

  @override
  Message postMessage(String boardId, String content, String author) {
    final message =
        Message(DateTime.now().toIso8601String(), boardId, content, author);
    _messages.add(message);
    return message;
  }
}

// Mock implementation for testing
class MockMessagesRepository implements MessagesRepository {
  @override
  List<Message> getMessagesByBoardId(String boardId) => [];

  @override
  Message postMessage(String boardId, String content, String author) {
    throw UnimplementedError('Mock implementation for testing');
  }
}

void main() {
  // Example usage
  final boardsRepository = InMemoryBoardsRepository();
  final messagesRepository = InMemoryMessagesRepository();

  final board = boardsRepository.createBoard('Just Chating');
  print('Created board: ${board.name}');

  final message =
      messagesRepository.postMessage(board.id, 'Hello, World!', 'Roman Makatsaryia');
  print('Posted message: ${message.content} by ${message.author}');
}
