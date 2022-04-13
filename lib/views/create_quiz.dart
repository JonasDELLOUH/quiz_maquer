import 'package:flutter/material.dart';
import 'package:quiz_maquer/services/database.dart';
import 'package:quiz_maquer/views/addquestion.dart';
import 'package:quiz_maquer/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgurl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription
      };

      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AddQuestion(
                        quizId: quizId,
                      )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) => val!.isEmpty
                          ? "Veuillez entrer l'url de l'image"
                          : null,
                      decoration: const InputDecoration(
                          hintText: "Image de votre Questionnaire (Optionnel)"),
                      onChanged: (val) {
                        quizImageUrl = val;
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty
                          ? "Veuillez entrer le titre de votre questionnaire"
                          : null,
                      decoration: const InputDecoration(
                          hintText: "Titre du questionnaire"),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty
                          ? "Veuillez entrer la description de votre questionnaire"
                          : null,
                      decoration: const InputDecoration(
                          hintText: "Description du questionaire"),
                      onChanged: (val) {
                        quizDescription = val;
                      },
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          createQuizOnline();
                        },
                        child: blueButton(
                          context: context,
                          label: "Créer le Questionnaire",
                        )),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
