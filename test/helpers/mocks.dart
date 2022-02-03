import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/bloc/puzzle_bloc.dart';
import 'package:utopic_slide_puzzle/src/models/models.dart';

class MockPuzzleBloc extends MockBloc<PuzzleEvent, PuzzleState> implements PuzzleBloc {}

class MockPuzzleState extends Mock implements PuzzleState {}

class MockPuzzle extends Mock implements Puzzle {}

class MockTile extends Mock implements Tile {}
