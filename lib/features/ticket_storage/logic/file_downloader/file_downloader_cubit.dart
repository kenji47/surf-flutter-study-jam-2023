import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/directories_handler.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/file_downloader.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/file_downloader/file_downloader_state.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/utils.dart';
import 'package:surf_flutter_study_jam_2023/getit_service_locator.dart';

class FileDownloaderCubit extends Cubit<FileDownloaderState> {
  late final FileDownloader _fileDownloader =
      getIt<FileDownloader>();
  late final DirectoriesHandler _directoriesHandler = getIt<DirectoriesHandler>();

  FileDownloaderCubit() : super(FileDownloaderState()) {
  }


  @override
  Future<void> close() async{
    cancelDownload();
   super.close();

  }

  cancelDownload() {
    _fileDownloader.cancelDownload();
    emit(state.copyWith(
      status: FileDownloaderStatus.initial,
      progress: 0.0,
      progressString: '0%',
    ));
  }

  Future<void> downloadFile(String fileUrl) async {
    emit(state.copyWith(
      status: FileDownloaderStatus.downloading,
      progress: 0.0,
      progressString: '0%',
    ));

    String path;
    try {
      path = await _directoriesHandler.getAppDocumentsDirectory();
    } catch (e) {
      emit(state.copyWith(
        status: FileDownloaderStatus.failure,
        errorMessage: 'directory failure', // todo handle error: can't get directory
      ));
      return;
    }
    final name = getFileName(fileUrl) + '.' + getFileExtension(fileUrl);
    final _fileName = "${path}/$name";
    print(_fileName);
    try {
      await _fileDownloader.downloadFile(
        fileUrl: fileUrl,
        fileName: _fileName,
        onProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            final progressString = "${(progress * 100).toStringAsFixed(0)}%";
            emit(state.copyWith(
              status: FileDownloaderStatus.downloading,
              progress: progress,
              progressString: progressString,
            ));
          }
        },
      );
      // todo update ticket and save
      emit(state.copyWith(
        status: FileDownloaderStatus.completed,
      ));
    } on DioError catch (e) {
      // do nothing when canceled
      if (e.type == DioErrorType.cancel) {
        return;
      }
      emit(state.copyWith(
        status: FileDownloaderStatus.failure,
        errorMessage: 'api error', // todo handle error: API errors
      ));
    }
  }

  void onProgress(double progress, String progressString) {
    emit(state.copyWith(
      progress: progress,
      progressString: progressString,
    ));
  }
}
