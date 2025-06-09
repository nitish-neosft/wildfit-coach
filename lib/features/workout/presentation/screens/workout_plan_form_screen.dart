import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/entities/exercise.dart';
import '../bloc/workout_bloc.dart';
import '../widgets/exercise_form.dart';

class WorkoutPlanFormScreen extends StatefulWidget {
  final String memberId;
  final WorkoutPlan? workoutPlan;

  const WorkoutPlanFormScreen({
    Key? key,
    required this.memberId,
    this.workoutPlan,
  }) : super(key: key);

  @override
  State<WorkoutPlanFormScreen> createState() => _WorkoutPlanFormScreenState();
}

class _WorkoutPlanFormScreenState extends State<WorkoutPlanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late int _sessionsPerWeek;
  late WorkoutPlanType _type;
  late List<Exercise> _exercises;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.workoutPlan?.name);
    _descriptionController =
        TextEditingController(text: widget.workoutPlan?.description);
    _sessionsPerWeek = widget.workoutPlan?.sessionsPerWeek ?? 3;
    _type = widget.workoutPlan?.type ?? WorkoutPlanType.strength;
    _exercises = List.from(widget.workoutPlan?.exercises ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutPlan == null
            ? 'Create Workout Plan'
            : 'Edit Workout Plan'),
      ),
      body: BlocListener<WorkoutBloc, WorkoutState>(
        listener: (context, state) {
          if (state is WorkoutPlanCreated || state is WorkoutPlanUpdated) {
            context.pop();
            context
                .read<WorkoutBloc>()
                .add(LoadMemberWorkoutPlans(widget.memberId));
          } else if (state is WorkoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Plan Name',
                  hintText: 'Enter workout plan name',
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
                  hintText: 'Enter workout plan description',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<WorkoutPlanType>(
                value: _type,
                decoration: const InputDecoration(
                  labelText: 'Plan Type',
                ),
                items: WorkoutPlanType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _type = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Sessions per Week: $_sessionsPerWeek',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _sessionsPerWeek > 1
                        ? () => setState(() => _sessionsPerWeek--)
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _sessionsPerWeek < 7
                        ? () => setState(() => _sessionsPerWeek++)
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Exercises',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton.icon(
                    onPressed: _addExercise,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Exercise'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ..._buildExercisesList(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  widget.workoutPlan == null ? 'Create Plan' : 'Update Plan',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExercisesList() {
    return _exercises.asMap().entries.map((entry) {
      final index = entry.key;
      final exercise = entry.value;
      return Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          title: Text(exercise.name),
          subtitle: Text(
            '${exercise.sets} sets × ${exercise.reps} reps',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => _exercises.removeAt(index)),
          ),
          onTap: () => _editExercise(index),
        ),
      );
    }).toList();
  }

  Future<void> _addExercise() async {
    final exercise = await showModalBottomSheet<Exercise>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => SingleChildScrollView(
          controller: controller,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const ExerciseForm(),
          ),
        ),
      ),
    );

    if (exercise != null) {
      setState(() => _exercises.add(exercise));
    }
  }

  Future<void> _editExercise(int index) async {
    final exercise = await showModalBottomSheet<Exercise>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => SingleChildScrollView(
          controller: controller,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: ExerciseForm(exercise: _exercises[index]),
          ),
        ),
      ),
    );

    if (exercise != null) {
      setState(() => _exercises[index] = exercise);
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_exercises.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add at least one exercise'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      final workoutPlan = WorkoutPlan(
        id: widget.workoutPlan?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        memberId: widget.memberId,
        createdBy: 'current_user', // Replace with actual user ID
        type: _type,
        exercises: _exercises,
        sessionsPerWeek: _sessionsPerWeek,
        createdAt: widget.workoutPlan?.createdAt ?? DateTime.now(),
        startDate: widget.workoutPlan?.startDate ?? DateTime.now(),
        endDate: widget.workoutPlan?.endDate ?? DateTime.now(),
        isActive: widget.workoutPlan?.isActive ?? true,
        progress: widget.workoutPlan?.progress ?? 0.0,
        metadata: widget.workoutPlan?.metadata ?? {},
      );

      if (widget.workoutPlan == null) {
        context.read<WorkoutBloc>().add(CreateNewWorkoutPlan(workoutPlan));
      } else {
        context.read<WorkoutBloc>().add(UpdateExistingWorkoutPlan(workoutPlan));
      }
    }
  }
}
