import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../widgets/stroop_card.dart';
import '../widgets/game_button.dart';
import '../widgets/feedback_icon.dart';
import '../widgets/pause_menu.dart';
import 'result_screen.dart';

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({Key? key}) : super(key: key);

  @override
  _MainGameScreenState createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  final GameController _controller = GameController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onGameStateChanged);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.startGame();
    });
  }

  void _onGameStateChanged() {
    if (_controller.isGameOver) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(result: _controller.getResult()),
        ),
      );
    } else {
      
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onGameStateChanged);
    _controller.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final question = _controller.currentQuestion;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF654E44), Color(0xFF543B31)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _controller.pauseGame,
                        child: Container(
                          width: 40,
                          height: 40,
                          color: const Color(0xFF3B2C25),
                          child: const Icon(
                            Icons.pause,
                            color: Color(0xFF30B0D6),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        color: Colors.white.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            const Text(
                              'TIME',
                              style: TextStyle(
                                color: Color(0xFF3B2C25),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatTime(_controller.timeLeft),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(width: 1, height: 20, color: const Color(0xFF3B2C25)),
                            const SizedBox(width: 16),
                            const Text(
                              'SCORE',
                              style: TextStyle(
                                color: Color(0xFF3B2C25),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${_controller.score}',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Question Text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Does the meaning match the text color?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Cards Area
                if (question != null)
                  SizedBox(
                    height: 350,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const LabelBubble(text: 'meaning', isPointingDown: true),
                            const SizedBox(height: 8),
                            StroopCard(
                              text: question.meaningWord,
                              textColor: Colors.black87, // Top word is always neutral
                            ),
                            const SizedBox(height: 30), // Space for feedback icon
                            StroopCard(
                              text: question.displayWord,
                              textColor: question.displayColor, // Bottom word is colored
                            ),
                            const SizedBox(height: 8),
                            const LabelBubble(text: 'text color', isPointingDown: false),
                          ],
                        ),
                        // Feedback Icon overlays between the cards
                        Positioned(
                          child: AnimatedFeedbackIcon(
                            feedbackState: _controller.feedbackState,
                          ),
                        ),
                      ],
                    ),
                  ),
                
                const Spacer(),
                
                // Bottom Buttons
                Row(
                  children: [
                    GameButton(
                      text: 'NO',
                      onTap: () => _controller.submitAnswer(false),
                    ),
                    Container(width: 2, color: const Color(0xFF231B18)),
                    GameButton(
                      text: 'YES',
                      onTap: () => _controller.submitAnswer(true),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Pause Menu Overlay
          if (_controller.isPaused)
            PauseMenu(
              onResume: _controller.resumeGame,
              onRestart: () {
                _controller.startGame();
              },
              onQuit: () {
                _controller.endGame();
              },
            ),
        ],
      ),
    );
  }
}
