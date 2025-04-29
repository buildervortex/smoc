import 'package:smo/usecases/adjoint_usecase.dart';
import 'package:smo/usecases/determinant_usecase.dart';
import 'package:smo/usecases/scaler_division_usecase.dart';

class InverseUsecase {
  Map<int, Map<int, num>> call(Map<int, Map<int, num>> matrix, int matrixSize) {
    var adjoint = AdjointUsecase()(matrix, matrixSize);
    var determinant = DeterminantUsecase()(matrix, matrixSize);

    if (determinant == 0) {
      throw Exception('Matrix is singular and cannot be inverted.');
    }

    return ScalerDivisionUsecase()(
      adjoint,
      determinant,
    );
  }
}
