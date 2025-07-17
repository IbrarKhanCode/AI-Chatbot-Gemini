import 'package:ai_chatbot_grok/message.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [
    Message(text: 'Hi', isUser: true),
    Message(text: 'Hello What\'s up ?', isUser: false),
    Message(text: 'Great and you ?', isUser: true),
    Message(text: 'I\' am excellent', isUser: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context,index){
                  final message = _messages[index];
                   return ListTile(
                     title: Align(
                       alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                       child: Container(
                         padding: EdgeInsets.all(8),
                         decoration: BoxDecoration(
                           color: message.isUser ? Colors.blue : Colors.white,
                           borderRadius: message.isUser ?
                               BorderRadius.only(
                                 topLeft: Radius.circular(20),
                                 bottomRight: Radius.circular(20),
                                 bottomLeft: Radius.circular(20),
                               ) :
                           BorderRadius.only(
                             topRight: Radius.circular(20),
                             bottomRight: Radius.circular(20),
                             bottomLeft: Radius.circular(20),
                         ),
                         ),
                         child: Text(message.text,style: TextStyle(
                           color: message.isUser ? Colors.white : Colors.black,fontSize: 14,
                           fontWeight: FontWeight.w500
                         ),),
                       ),
                     ),
                   );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: Colors.grey,
                    spreadRadius: 3,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.blue,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.send,color: Colors.blue,))
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
