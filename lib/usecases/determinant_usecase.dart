import 'package:smo/usecases/get_sign_from_permuntation_matrix_usecase.dart';
import 'package:smo/usecases/guassian_elimination_usecase.dart';

class DeterminantUsecase {
  num? call(Map<int, Map<int, num>> sparseMatrix, int matrixSize) {
    Map<int, Map<int, num>> permutationMatrix;
    permutationMatrix = GuassianEliminationUsecase()(sparseMatrix, matrixSize);
    // Check if the matrix is singular
    for (int rowIndex = 0; rowIndex < matrixSize; rowIndex++) {
      if (sparseMatrix.containsKey(rowIndex) == false) {
        return 0;
      }
      if (sparseMatrix[rowIndex]?.isEmpty ?? true) {
        return 0;
      }
      if (!(sparseMatrix[rowIndex]!.containsKey(rowIndex))) {
        return 0;
      }
    }
    num determinant =
        truncateToFive(multiplicationOfDialognal(sparseMatrix, matrixSize));
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

  num truncateToFive(num value) {
    int factor = 100000;
    return (value * factor).truncate() / factor;
  }
}
