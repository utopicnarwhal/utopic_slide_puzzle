import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/bloc/puzzle_page_bloc.dart';
import 'package:utopic_slide_puzzle/src/models/models.dart';
import 'package:utopic_slide_puzzle/src/utils/image_file_utils.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

int _kRageClicksLimit = 5;

/// {@template puzzle_bloc}
/// BLoC that handles and manages state changes in one particular slide puzzle
/// {@endtemplate}
class PuzzleBloc extends Bloc<_PuzzleEvent, PuzzleState> {
  /// {@macro puzzle_bloc}
  PuzzleBloc({
    this.size = 4,
    this.random,
    this.level = PuzzleLevels.number,
  }) : super(const PuzzleState()) {
    on<_PuzzleInitializedEvent>(_onPuzzleInitialized);
    on<_PuzzleTileTappedEvent>(_onTileTapped);
    on<_PuzzleResetEvent>(_onPuzzleReset);
    on<_PuzzleSolveEvent>(_onPuzzleSolve);
    on<_PuzzleAddImageEvent>(_onAddImage);
    on<_PuzzleSetTrafficLightEvent>(_onSetTrafficLight);
  }

  /// Number os tiles to build in horizontal and vertical axes (3x3, 4x4, etc.)
  final int size;

  /// Generator for puzzle shuffling
  final Random? random;

  /// Game level of the slide puzzle bloc
  final PuzzleLevels level;

  int _theSameTileTapCounter = 0;

  PausableTimer? _trafficLightTimer;

  /// Inits the puzzle bloc
  void initialize({bool shufflePuzzle = true, Uint8List? imageData}) {
    add(
      _PuzzleInitializedEvent(
        shufflePuzzle: shufflePuzzle,
        imageData: imageData,
      ),
    );
  }

  /// Handle tap on certain tile
  void tileTapped(Tile tile) {
    add(_PuzzleTileTappedEvent(tile));
  }

  /// Try to move a tile from the right of the white space tile to the left if possible
  void moveLeft() {
    final whitespaceTilePosition = state.puzzle.getWhitespaceTile().currentPosition;
    if (whitespaceTilePosition.x >= state.puzzle.getDimension()) {
      return;
    }
    final positionOfTileToMove = Position(x: whitespaceTilePosition.x + 1, y: whitespaceTilePosition.y);
    final tileToMove = state.puzzle.tiles.firstWhere((tile) => tile.currentPosition == positionOfTileToMove);
    add(_PuzzleTileTappedEvent(tileToMove));
  }

  /// Try to move a tile from the bottom of the white space tile to the top if possible
  void moveUp() {
    final whitespaceTilePosition = state.puzzle.getWhitespaceTile().currentPosition;
    if (whitespaceTilePosition.y >= state.puzzle.getDimension()) {
      return;
    }
    final positionOfTileToMove = Position(x: whitespaceTilePosition.x, y: whitespaceTilePosition.y + 1);
    final tileToMove = state.puzzle.tiles.firstWhere((tile) => tile.currentPosition == positionOfTileToMove);
    add(_PuzzleTileTappedEvent(tileToMove));
  }

  /// Try to move a tile from the left of the white space tile to the right if possible
  void moveRight() {
    final whitespaceTilePosition = state.puzzle.getWhitespaceTile().currentPosition;
    if (whitespaceTilePosition.x <= 1) {
      return;
    }
    final positionOfTileToMove = Position(x: whitespaceTilePosition.x - 1, y: whitespaceTilePosition.y);
    final tileToMove = state.puzzle.tiles.firstWhere((tile) => tile.currentPosition == positionOfTileToMove);
    add(_PuzzleTileTappedEvent(tileToMove));
  }

  /// Try to move a tile from the top of the white space tile to the bottom if possible
  void moveDown() {
    final whitespaceTilePosition = state.puzzle.getWhitespaceTile().currentPosition;
    if (whitespaceTilePosition.y <= 1) {
      return;
    }
    final positionOfTileToMove = Position(x: whitespaceTilePosition.x, y: whitespaceTilePosition.y - 1);
    final tileToMove = state.puzzle.tiles.firstWhere((tile) => tile.currentPosition == positionOfTileToMove);
    add(_PuzzleTileTappedEvent(tileToMove));
  }

  /// Adds an image data to the image level puzzle
  void addImage(Uint8List imageData) {
    if (level != PuzzleLevels.image) {
      return;
    }
    add(_PuzzleAddImageEvent(imageData));
  }

  /// Shuffles the tiles of the slide puzzle
  void reset() {
    add(const _PuzzleResetEvent());
  }

  /// Moves the bloc to the solved puzzle state
  void solve() {
    add(const _PuzzleSolveEvent());
  }

  Future _onPuzzleInitialized(
    _PuzzleInitializedEvent event,
    Emitter<PuzzleState> emit,
  ) async {
    final puzzle = _generatePuzzle(size, shuffle: event.shufflePuzzle);

    ui.Image? resizedImage;
    if (event.imageData != null) {
      resizedImage = await ImageFileUtils.resizeImage(event.imageData);
      state.resizedImage?.dispose();
    }

    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
        resizedImage: resizedImage,
      ),
    );
  }

  Future _onAddImage(
    _PuzzleAddImageEvent event,
    Emitter<PuzzleState> emit,
  ) async {
    final resizedImage = await ImageFileUtils.resizeImage(event.imageData);

    emit(state.copyWith(resizedImage: resizedImage));
  }

  /// Pauses the [_trafficLightTimer] if it's the [PuzzleLevels.trafficLight] level
  void pause() {
    if (level == PuzzleLevels.trafficLight) {
      _trafficLightTimer?.pause();
    }
  }

  /// Resumes/starts the [_trafficLightTimer] if it's the [PuzzleLevels.trafficLight] level
  void resume() {
    if (level == PuzzleLevels.trafficLight) {
      if (_trafficLightTimer == null) {
        _startTrafficLightTimer();
      } else {
        _trafficLightTimer!.start();
      }
    }
  }

  /// Starts a recursive timer that switches state's traffic light
  void _startTrafficLightTimer() {
    _trafficLightTimer = PausableTimer(
      _randomDurationBetween(2, 4),
      () {
        add(const _PuzzleSetTrafficLightEvent(TrafficLight.yellow));

        _trafficLightTimer = PausableTimer(const Duration(seconds: 1), () {
          add(const _PuzzleSetTrafficLightEvent(TrafficLight.red));

          _trafficLightTimer = PausableTimer(
            _randomDurationBetween(2, 4),
            () {
              add(const _PuzzleSetTrafficLightEvent(TrafficLight.green));
              _startTrafficLightTimer();
            },
          )..start();
        })
          ..start();
      },
    )..start();
  }

  Duration _randomDurationBetween(int min, int max) {
    return const Duration(seconds: 1) * ((Random().nextDouble() * (max - min)) + min);
  }

  void _onTileTapped(
    _PuzzleTileTappedEvent event,
    Emitter<PuzzleState> emit,
  ) {
    final tappedTile = event.tile;
    if (state.trafficLight == TrafficLight.red) {
      reset();
      return;
    }

    if (state.puzzleStatus == PuzzleStatus.incomplete) {
      if (state.puzzle.isTileMovable(tappedTile)) {
        final mutablePuzzle = Puzzle(tiles: [...state.puzzle.tiles]);
        final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
        if (puzzle.isComplete()) {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              tappedTilesHistory: [...state.tappedTilesHistory, tappedTile],
            ),
          );
        } else {
          bool? proposeToSolve;
          if (state.tappedTilesHistory.isNotEmpty &&
              tappedTile.correctPosition == state.tappedTilesHistory.last.correctPosition) {
            _theSameTileTapCounter += 1;
          } else {
            _theSameTileTapCounter = 0;
          }
          if (_theSameTileTapCounter == _kRageClicksLimit) {
            proposeToSolve = true;
            _theSameTileTapCounter = 0;
          }
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              tappedTilesHistory: [...state.tappedTilesHistory, tappedTile],
              proposeToSolve: proposeToSolve,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
        );
      }
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }
  }

  void _onPuzzleReset(_PuzzleResetEvent event, Emitter<PuzzleState> emit) {
    final puzzle = _generatePuzzle(size);
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
        resizedImage: state.resizedImage,
      ),
    );

    if (level == PuzzleLevels.trafficLight) {
      _trafficLightTimer?.cancel();
      _trafficLightTimer = null;
      _startTrafficLightTimer();
    }
  }

  void _onPuzzleSolve(_PuzzleSolveEvent event, Emitter<PuzzleState> emit) {
    final puzzle = _generatePuzzle(size, shuffle: false);
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
        resizedImage: state.resizedImage,
        puzzleStatus: PuzzleStatus.complete,
        numberOfMoves: state.numberOfMoves,
      ),
    );

    _trafficLightTimer?.cancel();
    _trafficLightTimer = null;
  }

  void _onSetTrafficLight(_PuzzleSetTrafficLightEvent event, Emitter<PuzzleState> emit) {
    emit(
      state.copyWith(
        trafficLight: event.trafficLight,
        tileMovementStatus: TileMovementStatus.cannotBeMoved,
      ),
    );
  }

  /// Build a randomized, solvable puzzle of the given size.
  Puzzle _generatePuzzle(int size, {bool shuffle = true}) {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    // Create all possible board positions.
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        if (x == size && y == size) {
          correctPositions.add(whitespacePosition);
          currentPositions.add(whitespacePosition);
        } else {
          final position = Position(x: x, y: y);
          correctPositions.add(position);
          currentPositions.add(position);
        }
      }
    }

    if (shuffle) {
      // Randomize only the current tile posistions.
      currentPositions.shuffle(random);
    }

    var tiles = _getTileListFromPositions(
      size,
      correctPositions,
      currentPositions,
    );

    var puzzle = Puzzle(tiles: tiles);

    if (shuffle) {
      // Assign the tiles new current positions until the puzzle is solvable and
      // zero tiles are in their correct position.
      while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
        currentPositions.shuffle(random);
        tiles = _getTileListFromPositions(
          size,
          correctPositions,
          currentPositions,
        );
        puzzle = Puzzle(tiles: tiles);
      }
    }

    return puzzle;
  }

  /// Build a list of tiles - giving each tile their correct position and a
  /// current position.
  List<Tile> _getTileListFromPositions(
    int size,
    List<Position> correctPositions,
    List<Position> currentPositions,
  ) {
    final whitespacePosition = Position(x: size, y: size);
    return [
      for (int i = 1; i <= size * size; i++)
        if (i == size * size)
          Tile(
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }
}
