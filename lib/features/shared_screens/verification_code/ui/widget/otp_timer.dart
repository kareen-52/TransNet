import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';

class OtpTimer extends StatefulWidget {
  final VoidCallback onResend;
  final int initialSeconds;
  final bool isResending;

  const OtpTimer({
    super.key,
    required this.onResend,
    this.initialSeconds = 59,
    this.isResending = false,
  });

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  late int seconds;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    seconds = widget.initialSeconds;
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  void resetTimer() {
    setState(() {
      seconds = widget.initialSeconds;
    });
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canResend = seconds == 0 && !widget.isResending;

    return Column(
      children: [
        Text(
          'إعادة إرسال الكود خلال 00:${seconds.toString().padLeft(2, '0')}',
          style: theme.textTheme.bodySmall,
        ),
        verticalSpace(8),
        GestureDetector(
          onTap: canResend
              ? () {
                  widget.onResend();
                  resetTimer();
                }
              : null,
          child: Text(
            widget.isResending ? 'جاري الإرسال...' : 'إعادة إرسال الكود',
            style: theme.textTheme.bodyMedium!.copyWith(
              color: canResend
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant.withOpacity(0.2),
            ),
          ),
        ),
      ],
    );
  }
}