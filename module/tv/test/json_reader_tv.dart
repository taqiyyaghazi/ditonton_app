import 'dart:io';

String readJsonTv(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/module/tv/test/$name').readAsStringSync();
}
