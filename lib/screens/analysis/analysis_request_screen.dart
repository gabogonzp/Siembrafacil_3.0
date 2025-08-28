import 'package:flutter/material.dart';
import '../../services/app_state.dart';
import '../../models/analysis_result.dart';

class AnalysisRequestScreen extends StatefulWidget {
  const AnalysisRequestScreen({super.key});

  @override
  State<AnalysisRequestScreen> createState() => _AnalysisRequestScreenState();
}

class _AnalysisRequestScreenState extends State<AnalysisRequestScreen>
    with TickerProviderStateMixin {
  bool _isAnalyzing = false;
  late AnimationController _rotationController;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _progressController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    // Check if no parcel is selected and redirect
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AppState.activeParcel == null) {
        _showNoParcelDialog();
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _showNoParcelDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Sin Parcela Seleccionada'),
        content: const Text(
          'Necesitas seleccionar una parcela antes de realizar un análisis. ¿Deseas ir a la gestión de parcelas?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to previous screen
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              // Navigate to parcels screen and wait for result
              final result = await Navigator.pushNamed(context, '/parcels');
              // If a parcel was selected, stay on analysis screen
              if (AppState.activeParcel == null) {
                Navigator.pop(context); // Go back if no parcel selected
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
            ),
            child: const Text(
              'Seleccionar Parcela',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _startAnalysis() async {
    if (AppState.activeParcel == null) {
      _showNoParcelDialog();
      return;
    }

    setState(() {
      _isAnalyzing = true;
    });

    _rotationController.repeat();
    _progressController.forward();

    // Simulate 10-second analysis
    await Future.delayed(const Duration(seconds: 10));

    // Generate analysis result
    final analysisResult = AnalysisResult.generateSimulated(
      AppState.activeParcel!,
    );
    
    AppState.addAnalysisResult(analysisResult);

    _rotationController.stop();
    _progressController.stop();

    if (mounted) {
      // Use pushReplacement to replace the current screen on the stack
      // This is crucial for a smooth navigation flow and ensures the user
      // cannot go back to the loading screen.
      Navigator.pushReplacementNamed(context, '/analysis-results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Análisis de Suelo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF1F8E9),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (!_isAnalyzing) ...[ //ojo aqui
                  // Analysis Info
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.science,
                            size: 60,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Análisis de Suelo Inteligente',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Obtén información detallada sobre las condiciones de tu suelo para optimizar tus cultivos.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        
                        // Selected Parcel Info
                        if (AppState.activeParcel != null)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Parcela Seleccionada',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  AppState.activeParcel!.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  AppState.activeParcel!.location,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        const SizedBox(height: 30),
                        
                        // Analysis Features
                        const Column(
                          children: [
                            _AnalysisFeature(
                              icon: Icons.thermostat,
                              title: 'Temperatura del Suelo',
                              description: 'Medición precisa de temperatura',
                            ),
                            SizedBox(height: 12),
                            _AnalysisFeature(
                              icon: Icons.water_drop,
                              title: 'Humedad',
                              description: 'Nivel de humedad del suelo',
                            ),
                            SizedBox(height: 12),
                            _AnalysisFeature(
                              icon: Icons.science,
                              title: 'pH y Conductividad',
                              description: 'Análisis químico completo',
                            ),
                            SizedBox(height: 12),
                            _AnalysisFeature(
                              icon: Icons.eco,
                              title: 'Nutrientes',
                              description: 'NPK y micronutrientes',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Start Analysis Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _startAnalysis,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Iniciar Análisis',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  // Loading Screen
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _rotationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotationController.value * 2 * 3.14159,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2E7D32).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.science,
                                  size: 60,
                                  color: Color(0xFF2E7D32),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Analizando Suelo...',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Analizando ${AppState.activeParcel?.name ?? 'parcela'}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // Progress Bar
                        AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: _progressAnimation.value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2E7D32),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  '${(_progressAnimation.value * 100).toInt()}%',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        
                        // Analysis Steps
                        const Column(
                          children: [
                            _AnalysisStep(
                              step: 1,
                              title: 'Recolectando datos del sensor',
                              isActive: true,
                            ),
                            SizedBox(height: 12),
                            _AnalysisStep(
                              step: 2,
                              title: 'Procesando información',
                              isActive: true,
                            ),
                            SizedBox(height: 12),
                            _AnalysisStep(
                              step: 3,
                              title: 'Generando recomendaciones',
                              isActive: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnalysisFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _AnalysisFeature({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2E7D32),
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E7D32),
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnalysisStep extends StatelessWidget {
  final int step;
  final String title;
  final bool isActive;

  const _AnalysisStep({
    required this.step,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive 
                ? const Color(0xFF2E7D32) 
                : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isActive
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                : Text(
                    step.toString(),
                    style: const TextStyle(
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isActive 
                ? const Color(0xFF2E7D32) 
                : const Color(0xFF666666),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
