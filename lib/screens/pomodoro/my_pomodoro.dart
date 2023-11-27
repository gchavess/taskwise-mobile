import 'package:flutter/material.dart';
import 'dart:async';

class MyPomodoro extends StatelessWidget {
  const MyPomodoro({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                ),
                const Text(
                  'Pomodoro',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Adicione o código para iniciar o cronômetro aqui
                  },
                  icon: const Icon(Icons.add),
                  iconSize: 45,
                ),
              ],
            ),
            TimerWidget(durationInSeconds: 25 * 60), // 25 minutos em segundos
          ],
        ),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  final int durationInSeconds;

  const TimerWidget({required this.durationInSeconds});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _currentTime;
  bool _isPaused = false;
  Timer? _timer;

  bool _isCountingDown = false;
  int _countDownDuration = 5 * 60;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.durationInSeconds;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationInSeconds),
    );
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void startTimer() {
    _controller.reverse(from: _currentTime / widget.durationInSeconds);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Timer completed
        setState(() {
          _isCountingDown = true;
          _currentTime = _countDownDuration;
        });
        _startCountDown();
      }
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (!_isPaused) {
          if (_currentTime < 1) {
            timer.cancel();
            _controller.reset();
            _controller.forward();
          } else {
            _currentTime--;
            _controller.value = _currentTime / widget.durationInSeconds;
          }
        }
      });
    });
  }

  void _startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (!_isPaused) {
          if (_currentTime < 1) {
            timer.cancel();
            _isCountingDown = false;
            _currentTime = widget.durationInSeconds;
            _controller.reverse(
              from: _currentTime / widget.durationInSeconds,
            );
          } else {
            _currentTime--;
          }
        }
      });
    });
  }

  String get timerText {
    int minutes = _currentTime ~/ 60;
    int seconds = _currentTime % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel(); // Cancela o timer ao descartar o estado
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 10.0,  
            color: const Color.fromRGBO(58, 59, 59, 0.753),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CustomPaint(
                painter: TimerPainter(
                  percentage: _isCountingDown
                      ? 1 - (_currentTime / _countDownDuration)
                      : _animation.value,
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        timerText,
                        style: const TextStyle(
                          fontSize: 47.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                cancelTimer();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                primary: Colors.grey,
                minimumSize: const Size(150, 60),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showModal();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                primary: const Color.fromARGB(255, 0, 71, 178),
                minimumSize: const Size(150, 60),
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Iniciar Timer'),
          content: const Text('Deseja iniciar o cronômetro?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _isPaused = false;
                startTimer();
                Navigator.of(context).pop();
              },
              child: const Text('Iniciar Timer'),
            ),
          ],
        );
      },
    );
  }

  void cancelTimer() {
    _isPaused = true;
    setState(() {
      _currentTime = widget.durationInSeconds;
      _controller.reset(); // Reinicia o AnimationController ao cancelar
    });
    _timer?.cancel(); // Cancela o timer ao cancelar
  }
}

class TimerPainter extends CustomPainter {
  final double percentage;

  TimerPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = const Color.fromARGB(255, 0, 71, 178)
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (3.1415926535897932 / 180),
      3.1415926535897932 * 2 * percentage,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(MaterialApp(
    home: MyPomodoro(),
  ));
}
