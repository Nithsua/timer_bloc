import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/bloc/timer_events.dart';
import 'package:timer_bloc/bloc/timer_state.dart';
import 'package:timer_bloc/model/ticker.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc(Ticker ticker)
      : _ticker = ticker,
        super(const TimerInitial(_duration));

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState(event);
    } else if (event is TimerPaused) {
      yield* _mapTimerPausedTostate(event);
    } else if (event is TimerResumed) {
      yield* _mapTimerResumedToState(event);
    } else if (event is TimerTicked) {
      yield* _mapTimerTickedToState(event);
    }
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted start) async* {
    yield TimerProgress(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(start.duration).listen((event) => add(TimerTicked(event)));
  }

  Stream<TimerState> _mapTimerPausedTostate(TimerPaused paused) async* {
    if (state is TimerProgress) {
      _tickerSubscription?.pause();
      yield TimerPause(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumed resumed) async* {
    if (state is TimerPause) {
      _tickerSubscription?.resume();
      yield (TimerProgress(state.duration));
    }
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked ticked) async* {
    yield state.duration > 0
        ? TimerProgress(state.duration)
        : const TimerComplete();
  }
}
