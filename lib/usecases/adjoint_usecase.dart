import 'package:smo/usecases/cofactor_matrix_usecase.dart';
import 'package:smo/usecases/transpose_usecase.dart';

class AdjointUsecase {
  Map<int, Map<int, num>> call(Map<int, Map<int, num>> matrix, int matrixSize) {
    var cofactorMatrix = CofactorMatrixUsecase()(matrix, matrixSize);
    return TransposeUsecase()(cofactorMatrix);
  }
}
