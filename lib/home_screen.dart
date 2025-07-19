import 'package:ai_chatbot_gemini/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

   final List<Message> _messages = [];

  callGeminiModel() async{
    try{
      if(_controller.text.isNotEmpty){
        setState(() {
          _messages.add(Message(text: _controller.text, isUser: true));
          _isLoading = true;
        });
      }

      final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: dotenv.env['GOOGLE_API_KEY']!);
      final prompt = _controller.text.trim();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        _messages.add(Message(text: response.text!, isUser: false));
        _isLoading = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });

      _controller.clear();
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
            content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
           Expanded(
            child: ListView.builder(
              controller: _scrollController,
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
                         child: message.isUser ? Text(
                           message.text,style: TextStyle(
                           color: message.isUser ? Colors.white : Colors.black,fontSize: 14,
                           fontWeight: FontWeight.w500
                         ),
                         )
                             : MarkdownBody(data: message.text),

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
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.blue,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask Gemini',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                  ),
                  _isLoading ?
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 15),
                   child: SizedBox(
                     height: 24,
                     width: 24,
                     child: CircularProgressIndicator(
                       strokeWidth: 2.5,
                       color: Colors.blue,
                     ),
                   ),
                 )
                      : IconButton(
                      onPressed: callGeminiModel,
                      icon: Icon(Icons.send,color: Colors.blue,)
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
