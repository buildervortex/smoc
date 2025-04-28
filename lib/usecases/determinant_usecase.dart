import 'package:smo/usecases/get_sign_from_permuntation_matrix_usecase.dart';
import 'package:smo/usecases/guassian_elimination_usecase.dart';

class DeterminantUsecase {
  num? call(Map<int, Map<int, num>> sparseMatrix, int matrixSize) {
    var permutationMatrix =
        GuassianEliminationUsecase()(sparseMatrix, matrixSize);
    if (permutationMatrix == null) {
      return null;
    }
    num determinant = multiplicationOfDialognal(sparseMatrix, matrixSize);
    int sign =
        GetSignFromPermuntationMatrixUsecase()(permutationMatrix, matrixSize);
    return sign * determinant;
  }

  num multiplicationOfDialognal(
      Map<int, Map<int, num>> sparseMatrix, int matrixSize) {
    num result = 1;
    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      if (sparseMatrix[rowIndex]?.containsKey(rowIndex) ?? false) {
        result *= sparseMatrix[rowIndex]![rowIndex]!;
      }
    }
    return result;
  }
}
