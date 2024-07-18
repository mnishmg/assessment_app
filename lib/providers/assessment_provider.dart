import 'package:assessment_app/helpers/api_helper.dart';
import 'package:assessment_app/models/assessment_model.dart';
import 'package:flutter/material.dart';

// AssessmentProvider class that extends ChangeNotifier to manage state for assessments.
class AssessmentProvider extends ChangeNotifier {
  // Model to hold the assessment data.
  AssessmentModel? assessmentModel;
  // Instance of ApiHelper to make API calls.
  ApiHelper _apiHelper = ApiHelper();

  // Boolean to track loading state.
  bool isLoading = false;
  // Index to track the current question.
  int _currentQuestionIndex = 0;
  // List to store user answers.
  List<int> userAnswers = [];

  // Getter for the current question index.
  int get currentQuestionIndex => _currentQuestionIndex;

  // Function to set questions by making an API call.
  void setQuestions() async {
    isLoading = true;
    notifyListeners(); // Notify listeners about the loading state.
    assessmentModel = await questions(); // Fetch questions from the API.
    isLoading = false;
    notifyListeners(); // Notify listeners about the loaded state.
  }

  // Function to fetch questions from the API.
  Future<AssessmentModel?> questions() async {
    String endpoint =
        'api.php?amount=5&category=18&difficulty=easy&type=multiple';
    try {
      var data = await _apiHelper.get(urlEndpoint: endpoint);
      return AssessmentModel.fromJson(data);
    } catch (e) {
      return AssessmentModel();
    }
  }

  // Function to go to the next question if available.
  void nextQuestion(int totalResult) {
    if (_currentQuestionIndex < totalResult - 1) {
      _currentQuestionIndex++;
      notifyListeners(); // Notify listeners about the current question index change.
    }
  }

  // Function to record the user's selected answer.
  void recordAnswer(int selectedOption) {
    if (currentQuestionIndex < userAnswers.length) {
      userAnswers[currentQuestionIndex] = selectedOption;
    } else {
      userAnswers.add(selectedOption);
    }
    notifyListeners(); // Notify listeners about the recorded answer.
  }

  // Function to calculate the user's score based on their answers.
  int calculateScore() {
    int score = 0;
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i] == 3) {
        // Assuming 3 is the index for the correct answer.
        score++;
        notifyListeners(); // Notify listeners about the score calculation.
      }
    }
    return score;
  }
}
