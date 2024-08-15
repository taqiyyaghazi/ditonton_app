import 'dart:io';

String readJsonTv(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  if (dir.endsWith('tv')) {
    return File('$dir/test/$name').readAsStringSync();
  }
  return File('$dir/module/tv/test/$name').readAsStringSync();
}
