
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/chat/message_response.dart';
import 'package:loby/domain/repositories/chat_repository.dart';

class GetMessages extends UseCase<MessageResponse, Params> {
  final ChatRepository _repository;

  GetMessages(this._repository);

  @override
  Future<Either<Failure, MessageResponse>> call(Params params) {
    return _repository.getMessages(
      chatId: params.chatParams?.chatId,
    );
  }
}
