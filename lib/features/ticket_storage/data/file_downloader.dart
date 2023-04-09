abstract class FileDownloader {
  downloadFile(
      {required String fileUrl,
        required String fileName,
        required Function(int, int) onProgress});
  cancelDownload();
}