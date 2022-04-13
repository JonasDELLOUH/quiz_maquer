import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maquer/models/question_model.dart';
import 'package:quiz_maquer/services/database.dart';
import 'package:quiz_maquer/views/result.dart';
import 'package:quiz_maquer/widgets/quiz_play_widgets.dart';
import 'package:quiz_maquer/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;

  const PlayQuiz({Key? key, required this.quizId}) : super(key: key);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0, _correct = 0, _incorrect = 0, _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = DatabaseService();
  late QuerySnapshot questionsSnapshot;

  QuestionModel getQuestionFromDatasnapshot(
      QueryDocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = QuestionModel();

    questionModel.question = questionSnapshot["question"];

    List<String> options = [
      questionSnapshot["option1"],
      questionSnapshot["option2"],
      questionSnapshot["option3"],
      questionSnapshot["option4"]
    ];

    options.shuffle();

    questionModel.option1 = options[0];

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];

    questionModel.correctOption = questionSnapshot["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    databaseService.getQuizData(widget.quizId).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      questionsSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot.docs.length;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: questionsSnapshot == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: questionsSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        return QuizPlayTile(
                          questionModel: getQuestionFromDatasnapshot(
                              questionsSnapshot.docs[index]),
                          index: index,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Results(
                        total: total,
                        incorrect: _incorrect,
                        correct: _correct,
                      )));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  const QuizPlayTile(
      {Key? key, required this.questionModel, required this.index})
      : super(key: key);

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q n°${widget.index + 1} ${widget.questionModel.question}",
          style: const TextStyle(fontSize: 17, color: Colors.black87),
        ),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered == false) {
              optionSelected = widget.questionModel.option1;
              widget.questionModel.answered = true;

              ///coorect
              if (widget.questionModel.option1 ==
                  widget.questionModel.correctOption) {
                _correct++;
                _notAttempted--;
                setState(() {});
              } else {
                _incorrect++;
                _notAttempted--;
                setState(() {});
              }
            }
          },
          child: OptionTile(
              option: "A",
              description: widget.questionModel.option1,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered == false) {
              optionSelected = widget.questionModel.option2;
              widget.questionModel.answered = true;

              ///coorect
              if (widget.questionModel.option2 ==
                  widget.questionModel.correctOption) {
                _correct++;
                _notAttempted--;
                setState(() {});
              } else {
                _incorrect++;
                _notAttempted--;
                setState(() {});
              }
            }
          },
          child: OptionTile(
              option: "B",
              description: widget.questionModel.option2,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered == false) {
              optionSelected = widget.questionModel.option3;
              widget.questionModel.answered = true;

              ///coorect
              if (widget.questionModel.option3 ==
                  widget.questionModel.correctOption) {
                _correct++;
                _notAttempted--;
                setState(() {});
              } else {
                _incorrect++;
                _notAttempted--;
                setState(() {});
              }
            }
          },
          child: OptionTile(
              option: "C",
              description: widget.questionModel.option3,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered == false) {
              optionSelected = widget.questionModel.option4;
              widget.questionModel.answered = true;

              ///coorect
              if (widget.questionModel.option4 ==
                  widget.questionModel.correctOption) {
                _correct++;
                _notAttempted--;
                setState(() {});
              } else {
                _incorrect++;
                _notAttempted--;
                setState(() {});
              }
            }
          },
          child: OptionTile(
              option: "D",
              description: widget.questionModel.option4,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
