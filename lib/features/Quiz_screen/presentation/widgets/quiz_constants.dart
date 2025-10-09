import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/assets_sound.dart';

class QuizConstants {
  static final List<String> successSounds = [
    AssetsSound.win1sound,
    AssetsSound.win2sound,
    AssetsSound.win3sound,
    AssetsSound.win4sound,
  ];

  static final List<String> failSounds = [
    AssetsSound.lose1sound,
    AssetsSound.lose2sound,
    AssetsSound.lose3sound,
    AssetsSound.lose4sound,
    AssetsSound.lose5sound,
    AssetsSound.lose6sound,
  ];

  static final List<String> happyImage = [
    AssetsPaths.happy1,
    AssetsPaths.happy2,
    AssetsPaths.happy3,
    AssetsPaths.happy4,
    AssetsPaths.happy5,
    AssetsPaths.happy7,
  ];

  static final List<String> sadImage = [
    AssetsPaths.sad1,
    AssetsPaths.sad2,
    AssetsPaths.sad3,
    AssetsPaths.sad4,
    AssetsPaths.sad5,
    AssetsPaths.sad6,
    AssetsPaths.sad7,
  ];

  static final List<String> motivationalWords = [
    'Don’t give up! You can do it! 💪',
    'Almost there! Try again 🌟',
    'Not this time, but you’re getting smarter 🧠',
    'Keep pushing! Success is near 🚀',
    "Good effort! Let’s try once more! 😊",
  ];

  static final List<String> successfulWords = [
    "Awesome! You’re a real champion! 💪",
    'Excellent! You’re doing amazing! 🏆',
    "Bravo! You did it!",
    "Yay! You got it right! 🎉",
    "Correct! You’re a superstar! 🌟",
  ];
}
