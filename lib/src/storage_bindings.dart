@JS()
library firebase_storage;

import "package:js/js.dart";
import 'package:node_interop/node.dart';
import 'package:node_interop/stream.dart';

import 'bindings.dart';

/// The Cloud Storage service interface.
@JS()
@anonymous
abstract class Storage {
  /// The app associated with this Storage instance.
  external App get app;

  /// Returns a reference to a Google Cloud Storage bucket.
  ///
  /// Returned reference can be used to upload and download content from
  /// Google Cloud Storage.
  ///
  /// [name] of the bucket to be retrieved is optional. If [name] is not
  /// specified, retrieves a reference to the default bucket.
  external Bucket bucket();
}

@JS()
@anonymous
abstract class Bucket {
  external String get name;

  /// Combine multiple files into one new file.
  ///
  /// [sources] can be a list of strings or [StorageFile]s.
  /// [destination] can be a string or [StorageFile].
  ///
  /// Returns promise containing list with following values:
  /// [0] [StorageFile] - The new file.
  /// [1] [Object]      - The full API response.
  external Promise combine(List sources, dynamic destination, [options, callback]);

  /// Create a bucket.
  ///
  /// Returns promise containing CreateBucketResponse.
  external Promise create([CreateBucketOptions option, callback]);

  /// Checks if the bucket exists.
  ///
  /// Returns promise containing list with following values:
  /// [0] [boolean] - Whether this bucket exists.
  external Promise exists([BucketExistsOptions options, callback]);

  /// Creates a [StorageFile] object.
  ///
  /// See [StorageFile] to see for more details.
  external StorageFile file(String name, [StorageFileOptions options]);

  /// Upload a file to the bucket. This is a convenience method that wraps
  /// [StorageFile.createWriteStream].
  ///
  /// [path] is the fully qualified path to the file you wish to upload to your
  /// bucket.
  ///
  /// You can specify whether or not an upload is resumable by setting
  /// `options.resumable`. Resumable uploads are enabled by default if your
  /// input file is larger than 5 MB.
  ///
  /// For faster crc32c computation, you must manually install `fast-crc32c`:
  ///
  ///     npm install --save fast-crc32c
  external Promise upload(String pathString, [UploadOptions options, callback]);
}

@JS()
@anonymous
abstract class CombineOptions {
  /// Resource name of the Cloud KMS key that will be used to encrypt the
  /// object.
  ///
  /// Overwrites the object metadata's kms_key_name value, if any.
  external String get kmsKeyName;

  /// The ID of the project which will be billed for the request.
  external String get userProject;

  external factory CombineOptions({String kmsKeyName, String userProject});
}

@JS()
@anonymous
abstract class CreateBucketOptions {
  // TODO: complete
}

@JS()
@anonymous
abstract class BucketExistsOptions {
  /// The ID of the project which will be billed for the request.
  external String get userProject;

  external factory BucketExistsOptions({String userProject});
}

@JS()
@anonymous
abstract class StorageFileOptions {
  /// Only use a specific revision of this file.
  external String get generation;

  /// A custom encryption key.
  external String get encryptionKey;

  /// Resource name of the Cloud KMS key that will be used to encrypt the
  /// object.
  ///
  /// Overwrites the object metadata's kms_key_name value, if any.
  external String get kmsKeyName;

  external String get userProject;

  external factory StorageFileOptions({
    String generation,
    String encryptionKey,
    String kmsKeyName,
    String userProject,
  });
}

@JS()
@anonymous
abstract class StorageFile {
  external String get name;

  external Bucket get bucket;

  external Storage get storage;

  external Bucket get parent;

  external Promise exists([options]);

  external Promise save(data, [CreateWriteStreamOptions options]);

  external Writable createWriteStream([CreateWriteStreamOptions options]);

  external Readable createReadStream([CreateReadStreamOptions options]);

  external Promise delete([options]);

  external Promise copy(StorageFile destinationFile);
}

@JS()
@anonymous
class CreateWriteStreamOptions {
  external String get contentType;

  external bool get gzip;

  external bool get resumable;

  external bool get validation;

  external StorageMetadata get metadata;

  external factory CreateWriteStreamOptions({
    String contentType,
    bool gzip,
    bool resumable,
    bool validation,
    StorageMetadata metadata,
  });
}

@JS()
@anonymous
class CreateReadStreamOptions {
  external String get userProject;

  external bool get validation;

  external num get start;

  external num get end;

  external bool get decompress;

  external factory CreateReadStreamOptions({
    String userProject,
    bool validation,
    num start,
    num end,
    bool decompress,
  });
}

@JS()
@anonymous
class CreateResumableUploadOptions {
  external String get configPath;

  external StorageMetadata get metadata;

  external String get origin;

  external num get offset;

  external String get predefinedAcl;

  external bool get private;

  external bool get public;

  external String get uri;

  external String get userProject;

  external factory CreateResumableUploadOptions({
    String configPath,
    StorageMetadata metadata,
    String origin,
    num offset,
    String predefinedAcl,
    bool private,
    bool public,
    String uri,
    String userProject,
  });
}

@JS()
@anonymous
abstract class UploadOptions {
  external String get destination;

  external StorageMetadata get metadata;

  external String get generation;

  /// A custom encryption key.
  external String get encryptionKey;

  /// Resource name of the Cloud KMS key that will be used to encrypt the
  /// object.
  ///
  /// Overwrites the object metadata's kms_key_name value, if any.
  external String get kmsKeyName;

  external bool get resumable;

  external String get contentType;

  external factory UploadOptions({
    StorageMetadata metadata,
    String destination,
    String generation,
    String encryptionKey,
    String kmsKeyName,
    bool resumable,
    String contentType,
  });
}

@JS()
@anonymous
abstract class StorageMetadata {
  external String get contentType;

  external dynamic get metadata;

  external factory StorageMetadata({
    String contentType,
    dynamic metadata,
  });
}
