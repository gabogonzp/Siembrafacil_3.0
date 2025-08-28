import 'package:flutter/material.dart';
import '../../services/app_state.dart';
import '../../models/parcel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_button.dart';

class ParcelManagementScreen extends StatefulWidget {
  const ParcelManagementScreen({super.key});

  @override
  State<ParcelManagementScreen> createState() => _ParcelManagementScreenState();
}

class _ParcelManagementScreenState extends State<ParcelManagementScreen> {
  final List<Parcel> _parcels = [
    Parcel(
      id: '1',
      name: 'Parcela Norte',
      location: 'Sector A - Campo Principal',
      cropType: 'Maíz',
      size: '2.5 hectáreas',
    ),
    Parcel(
      id: '2',
      name: 'Parcela Sur',
      location: 'Sector B - Campo Secundario',
      cropType: 'Tomate',
      size: '1.8 hectáreas',
    ),
    Parcel(
      id: '3',
      name: 'Parcela Este',
      location: 'Sector C - Campo Experimental',
      cropType: 'Lechuga',
      size: '0.5 hectáreas',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Parcelas',
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
        child: Column(
          children: [
            // Add Parcel Button
            Container(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showAddParcelDialog();
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Agregar Nueva Parcela',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            
            // Parcels List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _parcels.length,
                itemBuilder: (context, index) {
                  final parcel = _parcels[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildParcelCard(parcel),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParcelCard(Parcel parcel) {
    final isActive = AppState.activeParcel?.id == parcel.id;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isActive 
            ? Border.all(color: const Color(0xFF2E7D32), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () async { // Made async to allow for Future.delayed
          setState(() {
            AppState.setActiveParcel(parcel);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${parcel.name} seleccionada como parcela activa'),
              backgroundColor: const Color(0xFF2E7D32),
            ),
          );
          
          // Wait for 3 seconds before navigating back
          await Future.delayed(const Duration(seconds: 3));
          
          // Navigate back to the previous screen, which is likely the hometab
          if (mounted) {
            Navigator.pop(context);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.landscape,
                      color: Color(0xFF2E7D32),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              parcel.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            if (isActive) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2E7D32),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'ACTIVA',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          parcel.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showEditParcelDialog(parcel);
                      } else if (value == 'delete') {
                        _showDeleteParcelDialog(parcel);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text('Editar'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Eliminar', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(Icons.agriculture, parcel.cropType),
                  const SizedBox(width: 12),
                  _buildInfoChip(Icons.straighten, parcel.size),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF2E7D32),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddParcelDialog() {
    final nameController = TextEditingController();
    final locationController = TextEditingController();
    final sizeController = TextEditingController();
    String selectedCropType = 'Maíz';
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Agregar Nueva Parcela'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: nameController,
                  label: 'Nombre de la parcela',
                  prefixIcon: Icons.landscape,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: locationController,
                  label: 'Ubicación',
                  prefixIcon: Icons.location_on,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedCropType,
                  decoration: const InputDecoration(
                    labelText: 'Tipo de cultivo',
                    prefixIcon: Icon(Icons.agriculture),
                    border: OutlineInputBorder(),
                  ),
                  items: ['Maíz', 'Tomate', 'Lechuga', 'Zanahoria', 'Cebolla']
                      .map((crop) => DropdownMenuItem(
                            value: crop,
                            child: Text(crop),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedCropType = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: sizeController,
                  label: 'Tamaño (opcional)',
                  prefixIcon: Icons.straighten,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            LoadingButton(
              onPressed: () async {
                if (nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('El nombre es requerido')),
                  );
                  return;
                }

                setDialogState(() {
                  isLoading = true;
                });

                // Simulate API call
                await Future.delayed(const Duration(seconds: 1));

                final newParcel = Parcel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  location: locationController.text.isEmpty 
                      ? 'Ubicación no especificada' 
                      : locationController.text,
                  cropType: selectedCropType,
                  size: sizeController.text.isEmpty 
                      ? 'No especificado' 
                      : sizeController.text,
                );

                setState(() {
                  _parcels.add(newParcel);
                  // Set the newly added parcel as active and navigate
                  AppState.setActiveParcel(newParcel);
                });

                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${newParcel.name} agregada exitosamente'),
                    backgroundColor: const Color(0xFF2E7D32),
                  ),
                );

                // Wait for 3 seconds before navigating back
                await Future.delayed(const Duration(seconds: 1));
                
                // Navigate back to the previous screen, which is likely the hometab
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              isLoading: isLoading,
              text: 'Agregar',
            ),
          ],
        ),
      ),
    );
  }

  void _showEditParcelDialog(Parcel parcel) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funcionalidad de edición próximamente')),
    );
  }

  void _showDeleteParcelDialog(Parcel parcel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Parcela'),
        content: Text('¿Estás seguro de que quieres eliminar "${parcel.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _parcels.removeWhere((p) => p.id == parcel.id);
                if (AppState.activeParcel?.id == parcel.id) {
                  AppState.setActiveParcel(null);
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${parcel.name} eliminada'),
                  backgroundColor: const Color(0xFFF44336),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF44336),
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
