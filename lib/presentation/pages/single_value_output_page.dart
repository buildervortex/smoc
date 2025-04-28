import 'package:flutter/material.dart';

class SingleValueOutputPage extends StatelessWidget {
  final String value;
  final String operation;
  
  const SingleValueOutputPage({
    required this.operation, 
    required this.value, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final lightBlue = Colors.lightBlue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Result'),
        backgroundColor: lightBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            tooltip: 'Return to home',
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Result card
              Expanded(
                child: Center(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: lightBlue.shade100, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Operation icon
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: lightBlue.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _getOperationIcon(),
                              size: 40,
                              color: lightBlue.shade700,
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Operation name
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: lightBlue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              operation,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: lightBlue.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Result label
                          Text(
                            'Result',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          
                          // Result value
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: lightBlue.shade200),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: lightBlue.shade800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Info text
                          Text(
                            _getOperationDescription(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Return button
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text(
                    'RETURN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightBlue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Helper method to get appropriate icon based on operation
  IconData _getOperationIcon() {
    switch (operation.toLowerCase()) {
      case 'determinant':
        return Icons.calculate;
      case 'trace':
        return Icons.timeline;
      default:
        return Icons.functions;
    }
  }
  
  // Helper method to get description based on operation
  String _getOperationDescription() {
    switch (operation.toLowerCase()) {
      case 'determinant':
        return 'The determinant is a scalar value that provides information about the system of linear equations represented by the matrix.';
      case 'trace':
        return 'The trace is the sum of the elements on the main diagonal of the matrix.';
      default:
        return 'This is the calculated result for the $operation operation.';
    }
  }
}