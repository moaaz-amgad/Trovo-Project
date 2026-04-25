import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/game_model.dart';

enum FeedbackState { none, correct, wrong }

class GameController extends ChangeNotifier {
  // Config
  static const int totalGameTimeSeconds = 60;
  
  // State
  int _timeLeft = totalGameTimeSeconds;
  int _score = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  bool _isPaused = false;
  bool _isGameOver = false;
  
  StroopQuestion? _currentQuestion;
  FeedbackState _feedbackState = FeedbackState.none;
  
  Timer? _gameTimer;
  DateTime? _questionStartTime;
  final List<int> _reactionTimes = [];
  
  // Colors pool
  final Map<String, Color> _colors = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.amber,
    'black': Colors.black,
  };

  final Random _random = Random();

  int get timeLeft => _timeLeft;
  int get score => _score;
  bool get isPaused => _isPaused;
  bool get isGameOver => _isGameOver;
  StroopQuestion? get currentQuestion => _currentQuestion;
  FeedbackState get feedbackState => _feedbackState;

  void startGame() {
    _timeLeft = totalGameTimeSeconds;
    _score = 0;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _isPaused = false;
    _isGameOver = false;
    _reactionTimes.clear();
    
    _generateNextQuestion();
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) return;
      
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        endGame();
      }
    });
  }

  void pauseGame() {
    _isPaused = true;
    notifyListeners();
  }

  void resumeGame() {
    _isPaused = false;
    _questionStartTime = DateTime.now(); // reset reaction time start
    notifyListeners();
  }

  void stopGame() {
    _gameTimer?.cancel();
  }

  void endGame() {
    _isGameOver = true;
    stopGame();
    notifyListeners();
  }

  void _generateNextQuestion() {
    final List<String> colorNames = _colors.keys.toList();
    
    String meaningWord = colorNames[_random.nextInt(colorNames.length)];
    String displayWord = colorNames[_random.nextInt(colorNames.length)];
    String displayColorName = colorNames[_random.nextInt(colorNames.length)];
    
   
    if (_random.nextBool()) {
      displayColorName = meaningWord;
    }

    _currentQuestion = StroopQuestion(
      meaningWord: meaningWord,
      displayWord: displayWord,
      displayColor: _colors[displayColorName]!,
      displayColorName: displayColorName,
    );
    
    _feedbackState = FeedbackState.none;
    _questionStartTime = DateTime.now();
    notifyListeners();
  }

  void submitAnswer(bool userSaysYes) {
    if (_currentQuestion == null || _isPaused || _isGameOver) return;

    final DateTime now = DateTime.now();
    final int reactionTime = now.difference(_questionStartTime!).inMilliseconds;
    _reactionTimes.add(reactionTime);

    bool isMatch = _currentQuestion!.isMatch;
    bool isCorrect = (userSaysYes == isMatch);

    if (isCorrect) {
      _score += 100; 
      _correctAnswers++;
      _feedbackState = FeedbackState.correct;
    } else {
      _wrongAnswers++;
      _feedbackState = FeedbackState.wrong;
     
    }
    
    notifyListeners();

    // Show feedback for a short time before next question
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!_isGameOver) {
        _generateNextQuestion();
      }
    });
  }

  GameResult getResult() {
    int total = _correctAnswers + _wrongAnswers;
    double avgReaction = 0;
    if (_reactionTimes.isNotEmpty) {
      avgReaction = _reactionTimes.reduce((a, b) => a + b) / _reactionTimes.length;
    }

    return GameResult(
      totalAnswers: total,
      correctAnswers: _correctAnswers,
      wrongAnswers: _wrongAnswers,
      averageReactionTime: avgReaction,
    );
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }
}
