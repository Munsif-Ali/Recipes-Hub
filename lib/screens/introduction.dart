import 'package:bs_project/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Image(
              image: AssetImage("assets/images/logowithtext2.png"),
              height: 150,
            ),
          ),
          bodyWidget: Column(
            children: [
              Image(
                image: const AssetImage(
                  "assets/images/welcome.png",
                ),
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "a place where you can found thousand of recipes",
                style: GoogleFonts.aBeeZee(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          decoration: PageDecoration(
            pageColor: Theme.of(context).primaryColor,
          ),
        ),
        PageViewModel(
          titleWidget: const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Image(
              image: AssetImage("assets/images/logowithtext2.png"),
              height: 150,
            ),
          ),
          bodyWidget: Column(
            children: [
              Text(
                "I think baking is very rewarding, and if you follow a good recipe, you will get success.",
                textAlign: TextAlign.start,
                style: GoogleFonts.aBeeZee(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Mary Berry",
                style: GoogleFonts.aBeeZee(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          decoration: PageDecoration(
            pageColor: Theme.of(context).primaryColor,
          ),
        ),
        PageViewModel(
          titleWidget: const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Image(
              image: AssetImage("assets/images/logowithtext2.png"),
              height: 150,
            ),
          ),
          bodyWidget: Column(
            children: [
              const ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image(
                  image: AssetImage("assets/images/chef.png"),
                  width: 250,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "You have one step to become a good chef",
                textAlign: TextAlign.start,
                style: GoogleFonts.aBeeZee(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          decoration: PageDecoration(
            pageColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
      done: const Text(
        "Get Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      next: const Text(
        "Next",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      onDone: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) {
          return  SignIn();
        }));
      },
      showNextButton: true,
      dotsDecorator: const DotsDecorator(
        color: Colors.white,
        activeColor: Color(0xFFAA3911),
        activeSize: Size(40, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      dotsContainerDecorator: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
