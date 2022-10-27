
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/chat/chat_response.dart';
import 'package:loby/domain/repositories/chat_repository.dart';

class GetChats extends UseCase<ChatResponse, Params> {
  final ChatRepository _repository;

  GetChats(this._repository);

  @override
  Future<Either<Failure, ChatResponse>> call(Params params) {
    return _repository.getChats(
      name: params.chatParams?.name,
      page: params.chatParams?.page,
    );
  }
}
