import '/third_party/third_party.dart';
import '/models/models.dart';

part 'history.g.dart';

@riverpod
class History extends _$History {
  @override
  List<Image> build() {
    return const [
      Image(
        id: '1',
        name: 'Image 1',
        url: 'https://picsum.photos/200/300',
        editedUrl: 'https://picsum.photos/200/300',
        thumbnailUrl: 'https://picsum.photos/200/300',
      ),
      Image(
        id: '2',
        name: 'Image 2',
        url: 'https://picsum.photos/200/300',
        editedUrl: 'https://picsum.photos/200/300',
        thumbnailUrl: 'https://picsum.photos/200/300',
      ),
      Image(
        id: '3',
        name: 'Image 3',
        url: 'https://picsum.photos/200/300',
        editedUrl: 'https://picsum.photos/200/300',
        thumbnailUrl: 'https://picsum.photos/200/300',
      ),
    ];
  }
}