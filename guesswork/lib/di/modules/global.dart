import 'package:guesswork/core/data/framework/internet_availability_operation.dart';
import 'package:guesswork/core/data/repository/image_repository_impl.dart';
import 'package:guesswork/core/data/repository/internet_available_repository_impl.dart';
import 'package:guesswork/core/domain/repository/image_repository.dart';
import 'package:guesswork/core/domain/repository/internet_available_repository.dart';
import 'package:guesswork/core/domain/use_case/get_network_image_use_case.dart';
import 'package:guesswork/core/domain/use_case/internet_available_stream_use_case.dart';
import 'package:guesswork/core/domain/use_case/internet_available_use_case.dart';
import 'package:injectable/injectable.dart';

@module
abstract class Global {
  @Injectable()
  InternetAvailabilityStreamOperation
  internetAvailabilityStreamOperationFactory() {
    return InternetAvailabilityStreamOperation();
  }

  @Injectable()
  InternetAvailabilityRepository internetAvailabilityRepositoryFactory(
    InternetAvailabilityStreamOperation internetAvailabilityStreamOperation,
  ) {
    return InternetAvailabilityRepositoryImpl(
      internetAvailabilityStreamOperation,
    );
  }

  @Injectable()
  GetInternetAvailabilityStreamUseCase
  getInternetAvailabilityStreamUseCaseFactory(
    InternetAvailabilityRepository internetAvailabilityRepository,
  ) {
    return GetInternetAvailabilityStreamUseCase(internetAvailabilityRepository);
  }

  @Injectable()
  GetInternetAvailabilityUseCase getInternetAvailabilityUseCaseFactory(
    InternetAvailabilityRepository internetAvailabilityRepository,
  ) {
    return GetInternetAvailabilityUseCase(internetAvailabilityRepository);
  }

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
}
