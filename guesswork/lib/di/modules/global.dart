import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore_framework.dart';
import 'package:guesswork/core/data/repository/image_repository_impl.dart';
import 'package:guesswork/core/domain/repository/image_repository.dart';
import 'package:guesswork/core/domain/use_case/get_network_image_use_case.dart';
import 'package:injectable/injectable.dart';

@module
abstract class Global {
  @Injectable()
  ImageRepository imageRepositoryFactory() {
    return ImageRepositoryImpl();
  }

  @Injectable()
  GetNetworkImageUseCase getNetworkImageUseCaseFactory(
    ImageRepository imageRepository,
  ) {
    return GetNetworkImageUseCase(imageRepository);
  }

  @Singleton()
  FirestoreFramework firestoreFrameworkFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return FirestoreFramework(firebaseFirestore);
  }
}
