import 'package:ai_chatbot_grok/home_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: 'Your AI Assistant Developed By\n',style: TextStyle(color: Colors.white,
                  fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Muhammad Ibrar',style: TextStyle(color: Color(0xffB0BEC5),fontSize: 20)
                      )
                    ],
                  ),
              ),
              SizedBox(height: 20,),
              RichText(
                textAlign: TextAlign.justify,
                  text: TextSpan(
                      text: 'Your Intelligent companion for smarter conversation '
                          'and seamless productivity .Discover how AI can assist,'
                          ' inspire and empower you in everything you do.\n',
                    children: [
                      TextSpan(
                        text: 'Let\'s Get Started!',style: TextStyle(color: Color(0xffB0BEC5),fontSize: 17)
                      )
                    ],
                  ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: AssetImage('assets/images/ai.jpg'))
                ),
              ),
              SizedBox(height: 100,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Continue',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
                      SizedBox(width: 15,),
                      Icon(Icons.arrow_forward,color: Colors.white,)
                    ],
                  ),
                ),
              )
            ],
        ),
      ),
    );
  }
}
