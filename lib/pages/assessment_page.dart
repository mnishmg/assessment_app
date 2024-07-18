import 'dart:developer';

import 'package:assessment_app/pages/home_page.dart';
import 'package:assessment_app/pages/score_page.dart';
import 'package:assessment_app/providers/assessment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

// The AssessmentPage is a StatefulWidget that manages the state of the assessment.
class AssessmentPage extends StatefulWidget {
  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

// The _AssessmentPageState class holds the state for the AssessmentPage.
class _AssessmentPageState extends State<AssessmentPage> {
  // Variables to track the selected option and the current question index.
  int _selectedOption = -1;
  int _currentQuestion = 0;

  @override
  void initState() {
    super.initState();
    // Sets the questions when the widget is first built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AssessmentProvider>().setQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with a transparent background and a logout button.
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () async {
                // Logs out the user by updating shared preferences and popping the current screen.
                var prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', false);
                Navigator.pop(context);
              },
              child: Text(
                'Log Out',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        // Consumer to listen to changes in the AssessmentProvider.
        child: Consumer<AssessmentProvider>(
          builder: (_, provider, __) {
            int currentIndex = provider.currentQuestionIndex;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Displays a loading indicator while the data is being fetched.
                provider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          // Displays the current question.
                          Text(
                            'Q${(currentIndex + 1).toString()}. ${provider.assessmentModel!.results![currentIndex].question!}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: kDefaultPadding),
                          // Radio buttons for answer options.
                          RadioListTile(
                            value: 0,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                              provider.recordAnswer(value!);
                            },
                            title: Text(
                              provider.assessmentModel!.results![currentIndex]
                                  .incorrectAnswers![0],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          RadioListTile(
                            value: 1,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                              provider.recordAnswer(value!);
                            },
                            title: Text(
                              provider.assessmentModel!.results![currentIndex]
                                  .incorrectAnswers![1],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          RadioListTile(
                            value: 2,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                              provider.recordAnswer(value!);
                            },
                            title: Text(
                              provider.assessmentModel!.results![currentIndex]
                                  .incorrectAnswers![2],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          RadioListTile(
                            value: 3,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                              provider.recordAnswer(value!);
                            },
                            title: Text(
                              provider.assessmentModel!.results![currentIndex]
                                  .correctAnswer!,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                SizedBox(height: kDefaultPadding),
                // Buttons to show the score and move to the next question.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        var score = provider.calculateScore();
                        // Displays a dialog showing the user's score.
                        showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Your Score',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: kDefaultPadding / 2),
                                  Text(
                                    '$score/${provider.assessmentModel!.results!.length}',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: kDefaultPadding),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    child: Text(
                                      "Okay",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: Text(
                        "Show Score",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Moves to the next question and resets the selected option.
                        provider.nextQuestion(
                            provider.assessmentModel!.results!.length);
                        setState(() {
                          _selectedOption = -1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: Text(
                        "Next Question",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
