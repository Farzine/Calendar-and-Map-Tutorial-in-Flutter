import 'package:flutter/material.dart';
import '../widgets/Button.dart'; // Import our Button widget

class ButtonExampleScreen extends StatefulWidget {
  const ButtonExampleScreen({super.key});

  @override
  State<ButtonExampleScreen> createState() => _ButtonExampleScreenState();
}

class _ButtonExampleScreenState extends State<ButtonExampleScreen> {
  bool _isLoading = false;
  
  // Simulate loading state
  void _simulateLoading() {
    setState(() {
      _isLoading = true;
    });
    
    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Examples'),
        backgroundColor: Colors.grey[200],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Example 1: Default Button
                const Text(
                  'Default Button',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Button(
                  text: 'Sign In',
                  routeName: '/home',
                ),
                
                const SizedBox(height: 40),
                
                // Example 2: Button with Custom Colors
                const Text(
                  'Custom Colors',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Button(
                  text: 'Continue',
                  routeName: '/next',
                  backgroundColor: Color(0xFF2196F3), // Blue
                  textColor: Color(0xFFFFFFFF), // White
                ),
                
                const SizedBox(height: 40),
                
                // Example 3: Button with Icon
                const Text(
                  'Button with Icon',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Button(
                  text: 'Share',
                  routeName: '/share',
                  icon: Icons.share,
                ),
                
                const SizedBox(height: 40),
                
                // Example 4: Loading Button
                Text(
                  'Loading Button (Press to see loading state)',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Button(
                  text: 'Get Started one two',
                  routeName: '/submit',
                  isLoading: _isLoading,
                  onPressed: _simulateLoading,
                ),
                
                const SizedBox(height: 40),
                
                // Example 5: Combination of Features
                const Text(
                  'Combining Multiple Features',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Button(
                  text: 'Save',
                  routeName: '/save',
                  icon: Icons.save,
                  backgroundColor: const Color(0xFF4CAF50), // Green
                  textColor: Colors.white,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Changes saved successfully!')),
                    );
                  },
                ),
                
                const SizedBox(height: 40),
                
                // Example 6: Different Use Case - Destructive Action
                const Text(
                  'Destructive Action',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Button(
                  text: 'Delete',
                  routeName: '/delete',
                  icon: Icons.delete_outline,
                    backgroundColor: Color.fromRGBO(255, 68, 5, 1), 
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}