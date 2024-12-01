import 'package:flutter/material.dart';
import 'package:myapp/src/mixins/validation_mixin.dart';
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1954747464.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  createState() {
    return LoginScreenState(); // Creates the state for the screen
  }
}

// The state class for the LoginScreen
class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey =
      GlobalKey<FormState>(); // Unique key to manage the form's state
  bool _isObscure = true; // Boolean to toggle password visibility
  String? savedEmail; // Variable to temporarily save the entered email
  String? savedPassword; // Variable to temporarily save the entered password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background decoration with a gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffe0f7fa),
              Color(0xff81d4fa)
            ], // Light cyan to blue
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20), // Padding around the form container
        child: Form(
          key: formKey, // Connects this form with the GlobalKey for validation
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers the form vertically
            children: [
              emailFilled(), // Widget for the email input field
              const SizedBox(height: 20), // Adds vertical space
              passwordFilled(), // Widget for the password input field
              const SizedBox(height: 20), // Adds vertical space
              submitButton(), // Widget for the submit button
              const SizedBox(height: 20), // Adds vertical space
              displaySavedData(), // Widget to display saved data
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the email input field
  Widget emailFilled() {
    return TextFormField(
      keyboardType:
          TextInputType.emailAddress, // Suggests an email-friendly keyboard
      decoration: const InputDecoration(
        labelText: 'Email', // Field label
        labelStyle: TextStyle(color: Colors.black), // Style for the label
        hintText: 'you@gmail.com', // Example placeholder text
        hintStyle: TextStyle(color: Colors.grey), // Style for the hint text
        border: OutlineInputBorder(
          // Adds a visible border
          borderSide: BorderSide(color: Colors.grey), // Border color
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.blue, width: 2.0), // Border when focused
        ),
        prefixIcon: Icon(Icons.email, color: Colors.blue), // Adds an email icon
      ),
      validator: validateEmail,
      onSaved: (value) {
        // Saves the email input to the variable
        savedEmail = value;
      },
    );
  }

  // Widget for the password input field
  Widget passwordFilled() {
    return TextFormField(
      obscureText: _isObscure, // Toggles password visibility
      decoration: InputDecoration(
        labelText: 'Password', // Field label
        labelStyle: const TextStyle(color: Colors.black), // Style for the label
        border: OutlineInputBorder(
          // Adds a visible border
          borderRadius: BorderRadius.circular(8), // Rounded corners
          borderSide: const BorderSide(color: Colors.grey), // Border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
          borderSide: const BorderSide(
              color: Colors.blue, width: 2.0), // Border when focused
        ),
        suffixIcon: IconButton(
          // Icon button to toggle password visibility
          icon: Icon(
            _isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.blue, // Icon color
          ),
          onPressed: () {
            setState(
              () {
                // Toggles the _isObscure state to show/hide password
                _isObscure = !_isObscure;
              },
            );
          },
        ),
      ),
      validator: validatePassword,
      onSaved: (value) {
        // Saves the password input to the variable
        savedPassword = value;
      },
    );
  }

  // Widget for the submit button
  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        // Called when the button is pressed
        if (formKey.currentState!.validate()) {
          // Checks if the form is valid
          formKey.currentState!.save(); // Triggers the onSaved callbacks

          ScaffoldMessenger.of(context).showSnackBar(
            // Shows a success message
            const SnackBar(content: Text('Form is valid and data saved!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            // Shows an error message
            const SnackBar(content: Text('Please fix errors in the form')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal, // Button background color
        foregroundColor: Colors.white, // Button text color
        shadowColor: Colors.black, // Button shadow color
        elevation: 8, // Shadow depth
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min, // Makes the button wrap its content
        children: [
          Icon(Icons.login), // Login icon
          SizedBox(width: 8), // Adds space between the icon and text
          Text("Login"), // Button text
        ],
      ),
    );
  }

  // Widget to display saved form data
  Widget displaySavedData() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Aligns content to the start
      children: [
        if (savedEmail != null && savedPassword != null) ...[
          // Only display data if it's saved
          const Text(
            'Saved Data:',
            style: TextStyle(fontWeight: FontWeight.bold), // Bold heading
          ),
          Text('Email: $savedEmail'), // Displays saved email
          Text('Password: $savedPassword'), // Displays saved password
        ]
      ],
    );
  }
}