import 'package:flutter/material.dart';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    String jsonString = '''
    [
      {"type": "text", "sender": "User1", "message": "Hello!", "profileImageUrl": "../assets/images/placeholder_image.png"},
      {"type": "text", "sender": "User2", "message": "Hi there!", "profileImageUrl": "../assets/images/placeholder_image.png"},
      {"type": "text", "sender": "Me", "message": "How are you?", "profileImageUrl": "../assets/images/placeholder_image.png"},
      {
        "type": "poll",
        "sender": "User2",
        "message": "What is your favorite programming language?",
        "profileImageUrl": "../assets/images/placeholder_image.png",
        "options": ["Python", "JavaScript", "Dart"],
        "responses": [5, 3, 2]
      }
    ]
    ''';

    setState(() {
      _messages.addAll(parseMessages(jsonString));
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(Message(
          type: "text",
          sender: "Me",
          message: _controller.text,
          profileImageUrl: "../assets/images/placeholder_image.png",
        ));
        _controller.clear();
      });
    }
  }

 void _createPoll() {
  TextEditingController questionController = TextEditingController();
  List<TextEditingController> optionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Crear Encuesta"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(hintText: "Pregunta"),
            ),
            for (int i = 0; i < 3; i++)
              TextField(
                controller: optionControllers[i],
                decoration: InputDecoration(hintText: "Opción ${i + 1}"),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              final nonEmptyOptions = optionControllers
                  .where((controller) => controller.text.isNotEmpty)
                  .toList();

              if (questionController.text.isNotEmpty && nonEmptyOptions.length >= 2) {
                setState(() {
                  _messages.add(Message(
                    type: "poll",
                    sender: "Me",
                    message: questionController.text,
                    profileImageUrl: "../assets/images/placeholder_image.png",
                    options: nonEmptyOptions.map((c) => c.text).toList(),
                    responses: List.filled(nonEmptyOptions.length, 0),
                  ));
                });
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("Debes ingresar al menos 2 opciones."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cerrar"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text("Crear"),
          ),
        ],
      );
    },
  );
}
void _voteInPoll(int messageIndex, int optionIndex) {
  setState(() {
    final pollMessage = _messages[messageIndex];

    if (pollMessage.selectedOption == optionIndex) {
      pollMessage.responses![optionIndex]--;
      pollMessage.selectedOption = null;
    } else {
      if (pollMessage.selectedOption != null) {
        pollMessage.responses![pollMessage.selectedOption!]--;
      }
      pollMessage.selectedOption = optionIndex;
      pollMessage.responses![optionIndex]++;
    }
  });
}
 
  void _showPollResults(Message pollMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Resultados de la encuesta"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(pollMessage.options!.length, (index) {
              return ListTile(
                title: Text(pollMessage.options![index]),
                trailing: Text('${pollMessage.responses![index]} votos'),
              );
            }),
          ),
          actions: [
            TextButton(
              child: Text("Cerrar"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Chat'),
    ),
    body: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              final isMe = message.sender == "Me";

              if (message.type == "poll") {
                return _buildPollMessage(message, index);
              }

              return _buildTextMessage(message, isMe);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 246, 164, 42), 
              borderRadius: BorderRadius.circular(30), 
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje',
                        border: InputBorder.none, 
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.poll),
                  onPressed: _createPoll,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
  Widget _buildTextMessage(Message message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              backgroundImage: AssetImage(message.profileImageUrl),
            ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue[100] : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  message.message,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          if (isMe)
            CircleAvatar(
              backgroundImage: AssetImage(message.profileImageUrl),
            ),
        ],
      ),
    );
  }

Widget _buildPollMessage(Message message, int index) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.sender,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            message.message,
            style: TextStyle(fontSize: 16),
          ),
          ...List.generate(message.options!.length, (optionIndex) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(message.options![optionIndex]),
                  Text("(${message.responses![optionIndex]} votos)"),
                ],
              ),
              leading: GestureDetector(
                onTap: () => _voteInPoll(index, optionIndex),
                child: Container(
                  decoration: BoxDecoration(
                    color: message.selectedOption == optionIndex
                        ? Colors.blue 
                        : Colors.transparent, 
                    border: Border.all(
                      color: message.selectedOption == optionIndex
                          ? Colors.blue
                          : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.all(10),
                  child: message.selectedOption == optionIndex
                      ? Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 6,
                        )
                      : SizedBox.shrink(),
                ),
              ),
            );
          }),
          TextButton(
            onPressed: () => _showPollResults(message),
            child: Text("Ver votaciones"),
          ),
        ],
      ),
    ),
  );
}
}

class Message {
  final String type;
  final String sender;
  final String message;
  final String profileImageUrl;
  final List<String>? options; 
  final List<int>? responses;
  int? selectedOption; 

  Message({
    required this.type,
    required this.sender,
    required this.message,
    required this.profileImageUrl,
    this.options,
    this.responses,
    this.selectedOption,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      type: json['type'],
      sender: json['sender'],
      message: json['message'],
      profileImageUrl: json['profileImageUrl'],
      options: (json['options'] as List?)?.cast<String>(),
      responses: (json['responses'] as List?)?.cast<int>(),
    );
  }
}

List<Message> parseMessages(String jsonString) {
  final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<Message>((json) => Message.fromJson(json)).toList();
}
