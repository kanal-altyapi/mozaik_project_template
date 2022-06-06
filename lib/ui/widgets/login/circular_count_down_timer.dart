import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'custom_timer_painter.dart';

class CircularCountDownTimer extends StatefulWidget {
  const CircularCountDownTimer(
      {required this.width,
      required this.height,
      required this.duration,
      required this.fillColor,
      required this.color,
      this.isReverse,
      this.onComplete,
      this.strokeWidth,
      this.textStyle});

  final Color fillColor;
  final Color color;
  final Function? onComplete;
  final int duration;
  final double width;
  final double height;
  final double? strokeWidth;
  final TextStyle? textStyle;
  final bool? isReverse;

  @override
  _CircularCountDownTimerState createState() => _CircularCountDownTimerState();
}

class _CircularCountDownTimerState extends State<CircularCountDownTimer> with TickerProviderStateMixin {
 late AnimationController controller;

  bool flag = true;
  late String time;

  String get timerString {
    final Duration duration = controller.duration! * controller.value;
    _setTimeFormat(duration);
    time = _getTime(duration);
    return time;
  }

  void _setTimeFormat(Duration duration) {
    if (duration.inHours != 0) {
      time = '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      time = '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
  }

  String _getTime(Duration duration) {
    if (widget.isReverse == null || !widget.isReverse!) {
      final Duration forwardDuration = Duration(seconds: widget.duration);
      if (forwardDuration.inSeconds == duration.inSeconds && flag) {
        flag = false;
        _callOnComplete();
        return time;
      }
      return time;
    } else {
      if (controller.isDismissed && flag) {
        _callOnComplete();
        return '0:00';
      }
      return time;
    }
  }

  void _callOnComplete() {
    if (widget.onComplete != null) {
      SchedulerBinding.instance!.addPostFrameCallback((_) => widget.onComplete!(controller));
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    _setAnimation();
  }

  void _setAnimation() {
    if (widget.isReverse == null || !widget.isReverse!) {
      controller.forward(from: controller.value);
    } else {
      controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                          animation: controller, fillColor: widget.fillColor, color: widget.color, strokeWidth: widget.strokeWidth)),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Text(
                                    timerString,
                                    style: widget.textStyle ?? const TextStyle(fontSize: 16.0, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }
}
