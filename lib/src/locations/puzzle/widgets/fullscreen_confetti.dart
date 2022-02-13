part of '../puzzle_page.dart';

class _FullScreenConfetti extends StatelessWidget {
  const _FullScreenConfetti({
    required this.confettiAnimationController,
    Key? key,
  }) : super(key: key);

  final AnimationController confettiAnimationController;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenOrientationType = ScreenSize.getOrientationType(context);
          late String confettiAnimationAsset;

          switch (screenOrientationType) {
            case OrientationType.landscape:
              confettiAnimationAsset = 'assets/animations/confetti-landscape.json';
              break;
            case OrientationType.portrait:
              confettiAnimationAsset = 'assets/animations/confetti-portrait.json';
              break;
            case OrientationType.square:
              confettiAnimationAsset = 'assets/animations/confetti-square.json';
              break;
          }

          return Lottie.asset(
            confettiAnimationAsset,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
            controller: confettiAnimationController,
            onLoaded: (composition) {
              confettiAnimationController.duration = composition.duration;
            },
          );
        },
      ),
    );
  }
}
