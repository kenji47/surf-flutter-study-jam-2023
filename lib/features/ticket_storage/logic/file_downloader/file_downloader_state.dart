
enum FileDownloaderStatus { initial, downloading, completed, failure }

class FileDownloaderState {
  final FileDownloaderStatus status;
  final String? errorMessage;
  final double progress;
  final String progressString;
  final String? filePath;

  FileDownloaderState({
    this.status = FileDownloaderStatus.initial,
    this.errorMessage,
    this.progress = 0.0,
    this.progressString = '0%',
    this.filePath,
  });

  FileDownloaderState copyWith({
    FileDownloaderStatus? status,
    String? errorMessage,
    double? progress,
    String? progressString,
    String? filePath,
  }) {
    return FileDownloaderState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      progress: progress ?? this.progress,
      progressString: progressString ?? this.progressString,
      filePath: filePath ?? this.filePath,
    );
  }
}
