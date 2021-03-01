import 'dart:typed_data';

@TestOn('node')
import 'package:firebase_admin_interop/firebase_admin_interop.dart';
import 'package:js/js_util.dart';
import 'package:node_interop/fs.dart';
import 'package:node_interop/util.dart';
import 'package:test/test.dart';

import 'setup.dart';

void main() {
  App app = initFirebaseApp();

  group('$Storage', () {
    tearDownAll(() {
      return app.delete();
    });

    test('delete', () async {
      await app.storage().bucket().file('test.txt').delete();
    });

    test(
      'upload',
      () async {
        final storageFile = app.storage().bucket().file('test.jpg');

        final localFile =
            fs.readFileSync('/Users/maximilianwinter/Development/test.jpg') as Uint8List;

        await storageFile.save(localFile, CreateWriteStreamOptions(contentType: 'image/jpeg'));

        await app.storage().bucket().upload(
              '/Users/maximilianwinter/Development/test.jpg',
              UploadOptions(
                destination: 'test.jpg',
                contentType: 'image/jpeg',
                metadata: StorageMetadata(
                  contentType: 'image/jpeg',
                  metadata: jsify({
                    'firebaseStorageDownloadTokens': '4a2c9a1c-ad8e-4e2a-b9e2-aa7ce4aef9a8',
                  }),
                ),
              ),
            );
      },
    );
  });
}
