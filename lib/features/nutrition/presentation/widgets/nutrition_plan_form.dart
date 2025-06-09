import 'package:flutter/material.dart';
import '../../domain/entities/nutrition_plan.dart';

class NutritionPlanForm extends StatefulWidget {
  final NutritionPlan? nutritionPlan;
  final String memberId;
  final void Function(NutritionPlan plan) onSubmit;

  const NutritionPlanForm({
    Key? key,
    this.nutritionPlan,
    required this.memberId,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<NutritionPlanForm> createState() => _NutritionPlanFormState();
}

class _NutritionPlanFormState extends State<NutritionPlanForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _caloriesController;
  late TextEditingController _proteinController;
  late TextEditingController _carbsController;
  late TextEditingController _fatsController;
  late DateTime _startDate;
  DateTime? _endDate;
  late NutritionPlanType _selectedType;
  late bool _isActive;
  final List<String> _dietaryRestrictions = [];
  final List<String> _allowedFoods = [];
  final List<String> _excludedFoods = [];
  final TextEditingController _restrictionController = TextEditingController();
  final TextEditingController _allowedFoodController = TextEditingController();
  final TextEditingController _excludedFoodController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final plan = widget.nutritionPlan;
    _nameController = TextEditingController(text: plan?.name ?? '');
    _descriptionController =
        TextEditingController(text: plan?.description ?? '');
    _caloriesController = TextEditingController(
        text: plan?.dailyCalorieTarget.toString() ?? '2000');
    _proteinController = TextEditingController(
        text: plan?.macroTargets['protein']?.toString() ?? '150');
    _carbsController = TextEditingController(
        text: plan?.macroTargets['carbs']?.toString() ?? '250');
    _fatsController = TextEditingController(
        text: plan?.macroTargets['fats']?.toString() ?? '70');
    _startDate = plan?.startDate ?? DateTime.now();
    _endDate = plan?.endDate;
    _selectedType = plan?.type ?? NutritionPlanType.weightLoss;
    _isActive = plan?.isActive ?? true;
    if (plan != null) {
      _dietaryRestrictions.addAll(plan.dietaryRestrictions);
      _allowedFoods.addAll(plan.allowedFoods);
      _excludedFoods.addAll(plan.excludedFoods);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatsController.dispose();
    _restrictionController.dispose();
    _allowedFoodController.dispose();
    _excludedFoodController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final nutritionPlan = NutritionPlan(
        id: widget.nutritionPlan?.id ?? DateTime.now().toString(),
        memberId: widget.memberId,
        name: _nameController.text,
        description: _descriptionController.text,
        type: _selectedType,
        isActive: _isActive,
        startDate: _startDate,
        endDate: _endDate,
        dailyCalorieTarget: int.parse(_caloriesController.text),
        macroTargets: {
          'protein': double.parse(_proteinController.text),
          'carbs': double.parse(_carbsController.text),
          'fats': double.parse(_fatsController.text),
        },
        dietaryRestrictions: List<String>.from(_dietaryRestrictions),
        allowedFoods: List<String>.from(_allowedFoods),
        excludedFoods: List<String>.from(_excludedFoods),
      );

      widget.onSubmit(nutritionPlan);
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? _startDate
          : _endDate ?? _startDate.add(const Duration(days: 1)),
      firstDate: isStartDate ? DateTime.now() : _startDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate)) {
            _endDate = _startDate.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _addItem(String value, List<String> list) {
    if (value.isNotEmpty) {
      setState(() {
        list.add(value);
      });
    }
  }

  void _removeItem(int index, List<String> list) {
    setState(() {
      list.removeAt(index);
    });
  }

  Widget _buildChipList(String title, List<String> items,
      TextEditingController controller, void Function(String) onAdd) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Add $title',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      onAdd(controller.text);
                      controller.clear();
                    },
                  ),
                ),
                onSubmitted: (value) {
                  onAdd(value);
                  controller.clear();
                },
              ),
            ),
          ],
        ),
        if (items.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.asMap().entries.map((entry) {
              return Chip(
                label: Text(entry.value),
                onDeleted: () => _removeItem(entry.key, items),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.nutritionPlan == null
                    ? 'Create Nutrition Plan'
                    : 'Edit Nutrition Plan',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Plan Name',
                  hintText: 'Enter plan name',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter plan description',
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<NutritionPlanType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Plan Type',
                  prefixIcon: Icon(Icons.category),
                ),
                items: NutritionPlanType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedType = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => _selectDate(context, true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                    '${_startDate.day}/${_startDate.month}/${_startDate.year}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => _selectDate(context, false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 8),
                                Text(_endDate != null
                                    ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                                    : 'Not set'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(
                  labelText: 'Target Calories',
                  prefixIcon: Icon(Icons.local_fire_department),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final calories = int.tryParse(value);
                  if (calories == null || calories < 1) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Macronutrients (g)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _proteinController,
                      decoration: const InputDecoration(
                        labelText: 'Protein',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final protein = double.tryParse(value);
                        if (protein == null || protein < 0) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _carbsController,
                      decoration: const InputDecoration(
                        labelText: 'Carbs',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final carbs = double.tryParse(value);
                        if (carbs == null || carbs < 0) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _fatsController,
                      decoration: const InputDecoration(
                        labelText: 'Fats',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final fats = double.tryParse(value);
                        if (fats == null || fats < 0) {
                          return 'Invalid';
                        }

                        // Validate total macros
                        final protein =
                            double.tryParse(_proteinController.text) ?? 0;
                        final carbs =
                            double.tryParse(_carbsController.text) ?? 0;
                        final total = protein + carbs + fats;
                        final calories =
                            int.tryParse(_caloriesController.text) ?? 0;
                        final expectedTotal = calories / 4.0; // Rough estimate

                        if (total < expectedTotal * 0.9 ||
                            total > expectedTotal * 1.1) {
                          return 'Total macros should roughly match calories';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildChipList(
                'Dietary Restrictions',
                _dietaryRestrictions,
                _restrictionController,
                (value) => _addItem(value, _dietaryRestrictions),
              ),
              const SizedBox(height: 24),
              _buildChipList(
                'Allowed Foods',
                _allowedFoods,
                _allowedFoodController,
                (value) => _addItem(value, _allowedFoods),
              ),
              const SizedBox(height: 24),
              _buildChipList(
                'Excluded Foods',
                _excludedFoods,
                _excludedFoodController,
                (value) => _addItem(value, _excludedFoods),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        widget.nutritionPlan == null
                            ? 'Create Plan'
                            : 'Save Changes',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
