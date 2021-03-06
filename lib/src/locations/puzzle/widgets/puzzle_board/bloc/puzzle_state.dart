// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

enum PuzzleStatus { incomplete, complete }

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

enum TrafficLight { green, yellow, red }

class PuzzleState extends Equatable {
  const PuzzleState({
    this.puzzle = const Puzzle(tiles: []),
    this.puzzleStatus = PuzzleStatus.incomplete,
    this.tileMovementStatus = TileMovementStatus.nothingTapped,
    this.numberOfCorrectTiles = 0,
    this.numberOfMoves = 0,
    this.tappedTilesHistory = const <Tile>[],
    this.resizedImage,
    this.proposeToSolve = false,
    this.trafficLight = TrafficLight.green,
  });

  /// [Puzzle] containing the current tile arrangement.
  final Puzzle puzzle;

  /// Status indicating the current state of the puzzle.
  final PuzzleStatus puzzleStatus;

  /// Status indicating if a [Tile] was moved or why a [Tile] was not moved.
  final TileMovementStatus tileMovementStatus;

  /// Represents the history of tapped tiles of the puzzle.
  ///
  /// The value is empty list if the user has not interacted with
  /// the puzzle yet.
  final List<Tile> tappedTilesHistory;

  /// Number of tiles currently in their correct position.
  final int numberOfCorrectTiles;

  /// Number of tiles currently not in their correct position.
  int get numberOfTilesLeft => puzzle.tiles.length - numberOfCorrectTiles - 1;

  /// Number representing how many moves have been made on the current puzzle.
  ///
  /// The number of moves is not always the same as the total number of tiles
  /// moved. If a row/column of 2+ tiles are moved from one tap, one move is
  /// added.
  final int numberOfMoves;

  /// The image data for puzzle
  ///
  /// Only in use in puzzle with image
  final ui.Image? resizedImage;

  /// It turns true in case a user tapped on the same movable tile too many times
  final bool proposeToSolve;

  /// Current state of the traffic light
  ///
  /// Only in use in puzzle with the traffic light logic
  final TrafficLight trafficLight;

  PuzzleState copyWith({
    Puzzle? puzzle,
    PuzzleStatus? puzzleStatus,
    TileMovementStatus? tileMovementStatus,
    int? numberOfCorrectTiles,
    int? numberOfMoves,
    List<Tile>? tappedTilesHistory,
    ui.Image? resizedImage,
    bool? proposeToSolve,
    TrafficLight? trafficLight,
  }) {
    return PuzzleState(
      puzzle: puzzle ?? this.puzzle,
      puzzleStatus: puzzleStatus ?? this.puzzleStatus,
      tileMovementStatus: tileMovementStatus ?? this.tileMovementStatus,
      numberOfCorrectTiles: numberOfCorrectTiles ?? this.numberOfCorrectTiles,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
      tappedTilesHistory: tappedTilesHistory ?? this.tappedTilesHistory,
      resizedImage: resizedImage ?? this.resizedImage,
      proposeToSolve: proposeToSolve ?? false,
      trafficLight: trafficLight ?? this.trafficLight,
    );
  }

  @override
  List<Object?> get props => [
        puzzle,
        puzzleStatus,
        tileMovementStatus,
        numberOfCorrectTiles,
        numberOfMoves,
        tappedTilesHistory,
        resizedImage,
        proposeToSolve,
        trafficLight,
      ];
}
