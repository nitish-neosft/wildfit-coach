import 'package:flutter/material.dart';
import '../../../workout/presentation/screens/workouts_overview_screen.dart';
import '../../../nutrition/presentation/screens/nutrition_overview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Nutrition',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const WorkoutsOverviewScreen();
      case 1:
        return const NutritionOverviewScreen();
      default:
        return const WorkoutsOverviewScreen();
    }
  }
}

class WorkoutsOverviewScreen extends StatelessWidget {
  const WorkoutsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implementation of WorkoutsOverviewScreen
    return Container();
  }
}

class NutritionOverviewScreen extends StatelessWidget {
  const NutritionOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implementation of NutritionOverviewScreen
    return Container();
  }
}
