

import 'package:equatable/equatable.dart';

abstract class GetPdfEvent extends Equatable {
  const GetPdfEvent();

  @override
  List<Object> get props => [];
}

class LoadPdfsEvent extends GetPdfEvent {}
