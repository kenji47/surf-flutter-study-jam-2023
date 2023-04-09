
enum FileDownloaderStatus { initial, downloading, completed, failure }

class FileDownloaderState {
  final FileDownloaderStatus status;
  final String? errorMessage;
  final double progress;
  final String progressString;

  FileDownloaderState({
    this.status = FileDownloaderStatus.initial,
    this.errorMessage,
    this.progress = 0.0,
    this.progressString = '0%',
  });

  FileDownloaderState copyWith({
    FileDownloaderStatus? status,
    String? errorMessage,
    double? progress,
    String? progressString,
  }) {
    return FileDownloaderState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      progress: progress ?? this.progress,
      progressString: progressString ?? this.progressString,
    );
  }
}
