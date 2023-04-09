import 'package:dio/dio.dart';
import 'package:surf_flutter_study_jam_2023/constants.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/file_downloader.dart';
import 'package:surf_flutter_study_jam_2023/getit_service_locator.dart';

class FileDownloaderImpl extends FileDownloader {
  final _dio = getIt<Dio>();
  CancelToken _cancelToken = CancelToken();

  Future<void> downloadFile(
      {required String fileUrl,
      required String fileName,
      required Function(int, int) onProgress}) async {
    _cancelToken = CancelToken();
    await _dio.download(
      fileUrl,
      fileName,
      onReceiveProgress: (received, total) {
        //print('onReceiveProgress');
        onProgress(received, total);
      },
      deleteOnError: true,
      cancelToken: _cancelToken,
    );
  }

  cancelDownload() {
    _cancelToken.cancel();
  }

  String getSavePath(String path, String fileName) {
    return path + DIRECTORY_APP + fileName + '.pdf';
  }
}
