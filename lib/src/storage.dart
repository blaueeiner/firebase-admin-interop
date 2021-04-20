import 'package:meta/meta.dart';
import 'package:node_interop/stream.dart';
import 'package:node_interop/util.dart';

import 'bindings.dart' as js;

class Storage {
  Storage(this.nativeInstance);

  @protected
  final js.Storage nativeInstance;

  Bucket bucket() => Bucket(nativeInstance.bucket());
}

class Bucket {
  Bucket(this.nativeInstance);

  @protected
  final js.Bucket nativeInstance;

  String get name => nativeInstance.name;

  StorageFile file(String name, [js.StorageFileOptions options]) =>
      StorageFile(options == null ? nativeInstance.file(name) : nativeInstance.file(name, options));

  Future<UploadResponse> upload(String pathString, [js.UploadOptions options, callback]) =>
      promiseToFuture(nativeInstance.upload(pathString, options)).then(
        (response) => UploadResponse(
          file: StorageFile((response as List)[0]),
          metadata: (response as List)[1] as js.StorageMetadata,
        ),
      );
}

class UploadResponse {
  UploadResponse({this.file, this.metadata});

  final StorageFile file;

  final js.StorageMetadata metadata;
}

class StorageFile {
  StorageFile(this.nativeInstance);

  @protected
  final js.StorageFile nativeInstance;

  String get name => nativeInstance.name;

  Bucket get bucket => Bucket(nativeInstance.bucket);

  Storage get storage => Storage(nativeInstance.storage);

  Bucket get parent => Bucket(nativeInstance.parent);

  Future<bool> exists([options]) async =>
      (await promiseToFuture<List>(nativeInstance.exists(options))).map((e) => e as bool).first;

  Future<void> save(data, [js.CreateWriteStreamOptions options]) =>
      promiseToFuture(nativeInstance.save(data, options));

  Writable createWriteStream([js.CreateWriteStreamOptions options]) =>
      nativeInstance.createWriteStream(options);

  Readable createReadStream([js.CreateReadStreamOptions options]) =>
      nativeInstance.createReadStream(options);

  Future<void> delete() => promiseToFuture(nativeInstance.delete());

  Future<void> copy(StorageFile destinationFile) =>
      promiseToFuture(nativeInstance.copy(destinationFile.nativeInstance));
}
