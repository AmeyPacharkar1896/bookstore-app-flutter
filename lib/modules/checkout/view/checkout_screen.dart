import 'package:bookstore_app/modules/cart/controler/cart_controller.dart';
import 'package:bookstore_app/modules/cart/model/cart_item_model.dart';
import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItemModel> items;

  const CheckoutScreen({super.key, required this.items});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _submitCheckout() {
    if (_formKey.currentState?.validate() ?? false) {
      final controller = CartController(context);

      final address = {
        'address_line': _addressController.text,
        'city': _cityController.text,
        'zip_code': _zipController.text,
      };

      controller.checkoutWithAddress(widget.items, address);

      context.go('/order-success'); // ✅ Navigate to success page
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select<AuthBloc, String?>(
      (bloc) =>
          (bloc.state is AuthStateAuthenticated)
              ? (bloc.state as AuthStateAuthenticated).user.name
              : null,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/cart'),
        ),
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (user != null)
                Text(
                  'Shipping for: $user',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address Line'),
                validator:
                    (value) => value!.isEmpty ? 'Enter your address' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) => value!.isEmpty ? 'Enter your city' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _zipController,
                decoration: const InputDecoration(labelText: 'Zip Code'),
                validator:
                    (value) => value!.isEmpty ? 'Enter your zip code' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitCheckout,
                icon: const Icon(Icons.check_circle),
                label: const Text('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
