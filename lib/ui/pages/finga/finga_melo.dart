import 'package:flutter/material.dart';

class FingaMeloPage extends StatefulWidget {
  const FingaMeloPage({Key? key}) : super(key: key);

  @override
  State<FingaMeloPage> createState() => _FingaMeloPageState();
}

class _FingaMeloPageState extends State<FingaMeloPage> {
  String? _category;
  String? _productName;
  String? _productDescription;
  String? _productPrice;
  String? _productImage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Aquí podrías enviar los datos del producto a tu base de datos
      // o a un servidor para que se publique en tu aplicación.

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Producto agregado con éxito!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar producto'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nombre del producto',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productName = value;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Descripción del producto',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Descripción'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una descripción para el producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productDescription = value;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Precio del producto',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el precio del producto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, ingresa un valor numérico para el precio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productPrice = value;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Categoría del producto',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(hintText: 'Categoría'),
                value: _category,
                items: [
                  'Electrónica',
                  'Hogar',
                  'Ropa',
                  'Comida',
                  'Bebidas',
                  'Herramientas',
                  'Muebles',
                  'Juguetes',
                  'Deportes',
                  'Otro'
                ].map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecciona la categoría del producto';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                onSaved: (value) {
                  _category = value;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Imagen del producto',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'URL de la imagen'),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la URL de la imagen del producto';
                  }
                  if (!Uri.parse(value).isAbsolute) {
                    return 'Por favor, ingresa una URL válida';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productImage = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


