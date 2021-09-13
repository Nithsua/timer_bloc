import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object?> get props => [duration];
}

class TimerIntial extends TimerState {
  const TimerIntial(int duration) : super(duration);
}

class TimerProgress extends TimerState {
  const TimerProgress(int duration) : super(duration);
}

class TimerPause extends TimerState {
  const TimerPause(int duration) : super(duration);
}

class TimerComplete extends TimerState {
  const TimerComplete() : super(0);
}
