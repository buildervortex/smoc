part of 'operation_cubit_cubit.dart';

sealed class OperationCubitState extends Equatable {
  
  const OperationCubitState();

  @override
  List<Object> get props => [];
}

final class OperationCubitInitial extends OperationCubitState {}

final class OperationCubitLoading extends OperationCubitState {}

final class OperationCubitSuccess extends OperationCubitState {}

final class OperationCubitError extends OperationCubitState {}
