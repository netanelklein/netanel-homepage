import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          FadeInUp(
            child: Text(
              'Get In Touch',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const SizedBox(height: 60),
          
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              return Container(
                constraints: BoxConstraints(
                  maxWidth: sizingInformation.isDesktop ? 600 : double.infinity,
                ),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            
                            const SizedBox(height: 20),
                            
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your email';
                                }
                                if (!value!.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            
                            const SizedBox(height: 20),
                            
                            TextFormField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                labelText: 'Message',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 5,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter a message';
                                }
                                return null;
                              },
                            ),
                            
                            const SizedBox(height: 30),
                            
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _submitForm,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                ),
                                child: const Text('Send Message'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Submit form to backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you! Your message has been sent.'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Clear form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}