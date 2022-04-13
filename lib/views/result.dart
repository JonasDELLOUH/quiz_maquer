import 'package:flutter/material.dart';
import 'package:quiz_maquer/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;

  const Results(
      {Key? key,
      required this.correct,
      required this.incorrect,
      required this.total})
      : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.correct}/${widget.total}",
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Vous trouvé ${widget.correct} bonnes réponses "
                "et ${widget.incorrect} mauvaises",
                style: const TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 14,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: blueButton(
                    context: context,
                    label: "Aller à l'Accueil",
                    buttonWidth: MediaQuery.of(context).size.width / 2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
