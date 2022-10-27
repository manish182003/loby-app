
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/chat_repository.dart';

class SendMessage extends UseCase<Map<String, dynamic>, Params> {
  final ChatRepository _repository;

  SendMessage(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.sendMessage(
      receiverId: params.chatParams?.receiverId,
      message: params.chatParams?.message,
      fileType: params.chatParams?.fileType,
      file: params.chatParams?.file,
    );
  }
}
