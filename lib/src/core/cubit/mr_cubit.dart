import 'dart:core';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playbaloot/src/core/cubit/mr_states.dart';

class MrCubit extends Cubit<MrState> {
  //MrCubit({this.roomCode = "7654321"}) : super(0);
  MrCubit() : super(const MrState());

  //this functino generates random code for room. and its being used in roomScreen  {{{ context.read<MrCubit>().generateRoomCode(); }}}

  void generateRoomCode() {
    {
      final random = Random();
      // generates a 7-digit random number (1000000–9999999)
      final newCode = (1000000 + random.nextInt(9000000)).toString();
      emit(
        state.copyWith(roomCode: newCode),
      ); //emit is responsible for displaying data in ui.
    }
  }

  //add a function for addRound for scores
  //this function takes data from users textfield
  // and increments team1Score or team2Score. or adds on top of it
  // and emits the change

  void addRoundScore(int team1RoundScore, int team2RoundScore) {
    emit(
      state.copyWith(
        team1Score: state.team1Score + team1RoundScore,
        team2Score: state.team2Score + team2RoundScore,
      ),
    );
    checkRoundEnded(); //check if round ended after updatinng score
  }

  //to check if target score reached if yes end the round else no keep playing
  void checkRoundEnded() {
    final ended =
        state.team1Score >= state.targetScore ||
        state.team2Score >= state.targetScore;
    emit(state.copyWith(roundEnded: ended));
  }

  //any widget listening to mrState will rebuild when targetscore changes
  void setTargetScore(int score) {
    emit(state.copyWith(targetScore: score));
  }

  void resetGame() {
    emit(const MrState());
  }

  void numberOfPlayers() {
    //here we will do the following:
    // take cubit state.. and then say the number whcih user chooses in textfield
    // becomes the state of cubit number. then we will go and display it in our roomScreen
    // then the number of players displayed in UI be exactly the number of players inthe game
  }
}

/*
! has business Logic (what actions can change the state)
  functions that modify the state
  like setPLayerName, AddpOINTS, STARTgame

*/
