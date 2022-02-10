// ignore_for_file: public_member_api_docs
// TODO(sergei): add docs

import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:utopic_slide_puzzle/src/models/models.dart';
import 'package:utopic_slide_puzzle/src/utils/image_file_utils.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

int _kRageClicksLimit = 5;

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc({
    this.size = 4,
    this.random,
    this.level = 0,
  }) : super(const PuzzleState()) {
    on<_PuzzleInitializedEvent>(_onPuzzleInitialized);
    on<_PuzzleTileTappedEvent>(_onTileTapped);
    on<_PuzzleResetEvent>(_onPuzzleReset);
    on<_PuzzleSolveEvent>(_onPuzzleSolve);
    on<_PuzzleAddImageEvent>(_onAddImage);
  }

  final int size;

  final Random? random;

  final int level;

  int _theSameTileTapCounter = 0;

  void initialize({bool shufflePuzzle = true, Uint8List? imageData}) {
    add(
      _PuzzleInitializedEvent(
        shufflePuzzle: shufflePuzzle,
        imageData: imageData,
      ),
    );
  }

  void tileTapped(Tile tile) {
    add(_PuzzleTileTappedEvent(tile));
  }

  void addImage(Uint8List imageData) {
    add(_PuzzleAddImageEvent(imageData));
  }

  void reset() {
    add(const _PuzzleResetEvent());
  }

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

  void _onTileTapped(_PuzzleTileTappedEvent event, Emitter<PuzzleState> emit) {
    final tappedTile = event.tile;
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
              lastTappedTile: tappedTile,
            ),
          );
        } else {
          bool? proposeToSolve;
          if (tappedTile.correctPosition == state.lastTappedTile?.correctPosition) {
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
              lastTappedTile: tappedTile,
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
