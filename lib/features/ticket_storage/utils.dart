// https://journal-free.ru/download/dachnye-sekrety-11-noiabr-2019.pdf
bool isValidPdfUrl(String url) {
  if (!Uri.parse(url).isAbsolute ||
      url.isEmpty ||
      getFileExtension(url) != 'pdf') {
    return false;
  }
  return true;
}

String getFileName(String url) {
  return Uri.parse(url).pathSegments.last.split('.').first;
}

String getFileExtension(String url) {
  return Uri.parse(url).pathSegments.last.split('.').last;
}