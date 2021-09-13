import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  final int duration;
  const TimerStarted(this.duration);
}

class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class TimerResumed extends TimerEvent {
  const TimerResumed();
}

class TimerTicked extends TimerEvent {
  final int duration;
  const TimerTicked(this.duration);

  @override
  List<Object> get props => [duration];
}
