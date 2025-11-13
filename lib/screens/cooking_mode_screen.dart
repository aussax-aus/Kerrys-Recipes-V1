import 'package:flutter/material.dart';
import 'dart:async';
import '../models/recipe.dart';

class CookingModeScreen extends StatefulWidget {
  final Recipe recipe;

  const CookingModeScreen({super.key, required this.recipe});

  @override
  State<CookingModeScreen> createState() => _CookingModeScreenState();
}

class _CookingModeScreenState extends State<CookingModeScreen> {
  int _currentStep = 0;
  final List<bool> _completedSteps = [];
  Timer? _timer;
  int _timerSeconds = 0;
  bool _timerRunning = false;

  @override
  void initState() {
    super.initState();
    _completedSteps.addAll(List.filled(widget.recipe.steps.length, false));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final step = widget.recipe.steps[_currentStep];

    return Scaffold(
      appBar: AppBar(
        title: Text('Cooking: ${widget.recipe.title}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.timer),
            onPressed: _showTimerDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_currentStep + 1) / widget.recipe.steps.length,
            minHeight: 6,
          ),

          // Timer display
          if (_timerRunning)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: theme.colorScheme.primaryContainer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.timer),
                  const SizedBox(width: 8),
                  Text(
                    _formatTime(_timerSeconds),
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: _stopTimer,
                  ),
                ],
              ),
            ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step counter
                  Text(
                    'Step ${_currentStep + 1} of ${widget.recipe.steps.length}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Step content
                  Expanded(
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: SingleChildScrollView(
                          child: Text(
                            step,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Completed checkbox
                  CheckboxListTile(
                    title: const Text('Mark step as complete'),
                    value: _completedSteps[_currentStep],
                    onChanged: (value) {
                      setState(() {
                        _completedSteps[_currentStep] = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _currentStep--;
                        });
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Previous'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _currentStep < widget.recipe.steps.length - 1
                        ? () {
                            setState(() {
                              _currentStep++;
                            });
                          }
                        : _finishCooking,
                    icon: Icon(_currentStep < widget.recipe.steps.length - 1
                        ? Icons.arrow_forward
                        : Icons.check),
                    label: Text(_currentStep < widget.recipe.steps.length - 1
                        ? 'Next'
                        : 'Finish'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showTimerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        int minutes = 5;
        return AlertDialog(
          title: const Text('Set Timer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Minutes',
                  suffixText: 'min',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  minutes = int.tryParse(value) ?? 5;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _startTimer(minutes * 60);
                Navigator.pop(context);
              },
              child: const Text('Start'),
            ),
          ],
        );
      },
    );
  }

  void _startTimer(int seconds) {
    setState(() {
      _timerSeconds = seconds;
      _timerRunning = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _stopTimer();
          _showTimerCompleteDialog();
        }
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _timerRunning = false;
      _timerSeconds = 0;
    });
    _timer?.cancel();
  }

  void _showTimerCompleteDialog() {
    if (!mounted) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Timer Complete!'),
        content: const Text('Your timer has finished.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _finishCooking() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cooking Complete!'),
        content: const Text('Great job! Your dish is ready.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Exit cooking mode
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
