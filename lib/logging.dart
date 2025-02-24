import 'package:logger/logger.dart';

_CustomLogFilter _logFilter = _CustomLogFilter(level: Level.debug);

void muteLogging() {
  _logFilter.muted = true;
}

void unmuteLogging() {
  _logFilter.muted = false;
}

Logger createLogger(Type type) {
  return Logger(
    printer: _CustomLogPrinter(
      type,
      noBoxingByDefault: true,
      methodCount: 0,
    ),
    filter: _logFilter,
  );
}

class _CustomLogPrinter extends PrettyPrinter {
  Type type;
  PrettyPrinter? p;
  _CustomLogPrinter(
    this.type, {
    required super.noBoxingByDefault,
    required super.methodCount,
  });

  @override
  List<String> log(LogEvent event) {
    final typeName = type.toString();
    final time = DateTime.now();
    final customMessage = '$typeName ($time): ${event.message}';
    final customEvent = LogEvent(
      event.level,
      customMessage,
      error: event.error,
      stackTrace: event.stackTrace,
    );
    return super.log(customEvent);
  }
}

class _CustomLogFilter extends LogFilter {
  bool muted = false;

  _CustomLogFilter({required Level level}) {
    super.level = level;
  }

  @override
  bool shouldLog(LogEvent event) {
    return muted ? false : event.level.index >= level!.index;
  }
}
