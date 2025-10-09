import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'quiz_constants.dart';

class QuizHelpers {
  late AudioPlayer player = AudioPlayer();
  static final random = Random();

  Future<void> playRandomSuccessSound() async {
    int index = random.nextInt(QuizConstants.successSounds.length);
    String soundPath = QuizConstants.successSounds[index];
    // print(":__________________index $index");
    await player.play(AssetSource(soundPath));
    Future.delayed(Duration(seconds: 3), () {
      player.stop();
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> PlayRandamFailSound() async {
    int index = random.nextInt(QuizConstants.failSounds.length);
    String soundPath = QuizConstants.failSounds[index];
    // print(":__________________index $index");
    await player.play(AssetSource(soundPath));
    Future.delayed(Duration(seconds: 3), () {
      player.stop();
    });
  }

  String getRandomHappyImage() {
    int index = random.nextInt(QuizConstants.happyImage.length);
    return QuizConstants.happyImage[index];
  }

  String getRandomSadImage() {
    int index = random.nextInt(QuizConstants.sadImage.length);
    return QuizConstants.sadImage[index];
  }

  String getRandomMotivationalWord() {
    int index = random.nextInt(QuizConstants.motivationalWords.length);
    return QuizConstants.motivationalWords[index];
  }

  String getRandomSuccessfulWord() {
    int index = random.nextInt(QuizConstants.successfulWords.length);
    return QuizConstants.successfulWords[index];
  }
}
