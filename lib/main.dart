import 'package:flutter/material.dart';

void main() {
  runApp(const SoDeMercadoApp());
}

class SoDeMercadoApp extends StatelessWidget {
  const SoDeMercadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Só de Mercado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1D7A54),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F7F3),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Color(0xFFF6F7F3),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const MarketHomePage(),
    );
  }
}

class MarketHomePage extends StatefulWidget {
  const MarketHomePage({super.key});

  @override
  State<MarketHomePage> createState() => _MarketHomePageState();
}

class _MarketHomePageState extends State<MarketHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final Map<String, int> _cart = {};
  String _selectedCategory = 'Todos';
  String _search = '';

  static const List<String> _categories = [
    'Todos',
    'Hortifruti',
    'Padaria',
    'Bebidas',
    'Limpeza',
    'Mercearia',
  ];

  final List<Product> _products = const [
    Product(
      id: 'banana',
      name: 'Banana prata',
      category: 'Hortifruti',
      price: 5.99,
      oldPrice: 7.49,
      unit: 'kg',
      icon: Icons.eco,
      color: Color(0xFFF5C451),
    ),
    Product(
      id: 'tomate',
      name: 'Tomate italiano',
      category: 'Hortifruti',
      price: 8.49,
      unit: 'kg',
      icon: Icons.local_florist,
      color: Color(0xFFE55442),
    ),
    Product(
      id: 'pao',
      name: 'Pão francês',
      category: 'Padaria',
      price: 12.9,
      oldPrice: 14.9,
      unit: 'kg',
      icon: Icons.bakery_dining,
      color: Color(0xFFD28B45),
    ),
    Product(
      id: 'cafe',
      name: 'Café torrado',
      category: 'Mercearia',
      price: 18.75,
      unit: '500 g',
      icon: Icons.coffee,
      color: Color(0xFF6B4B3E),
    ),
    Product(
      id: 'leite',
      name: 'Leite integral',
      category: 'Bebidas',
      price: 4.89,
      unit: '1 L',
      icon: Icons.water_drop,
      color: Color(0xFF6EB6DE),
    ),
    Product(
      id: 'suco',
      name: 'Suco de laranja',
      category: 'Bebidas',
      price: 9.99,
      oldPrice: 11.99,
      unit: '1 L',
      icon: Icons.local_drink,
      color: Color(0xFFF08A24),
    ),
    Product(
      id: 'arroz',
      name: 'Arroz tipo 1',
      category: 'Mercearia',
      price: 24.9,
      unit: '5 kg',
      icon: Icons.rice_bowl,
      color: Color(0xFFB9A985),
    ),
    Product(
      id: 'sabao',
      name: 'Sabão líquido',
      category: 'Limpeza',
      price: 17.49,
      unit: '3 L',
      icon: Icons.cleaning_services,
      color: Color(0xFF5D83C4),
    ),
  ];

  List<Product> get _filteredProducts {
    final query = _search.trim().toLowerCase();
    return _products.where((product) {
      final matchesCategory =
          _selectedCategory == 'Todos' || product.category == _selectedCategory;
      final matchesSearch = query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  int get _cartCount => _cart.values.fold(0, (total, amount) => total + amount);

  double get _cartTotal {
    return _cart.entries.fold(0, (total, item) {
      final product = _products.firstWhere((product) => product.id == item.key);
      return total + product.price * item.value;
    });
  }

  void _addToCart(Product product) {
    setState(() => _cart[product.id] = (_cart[product.id] ?? 0) + 1);
  }

  void _removeFromCart(Product product) {
    final currentAmount = _cart[product.id] ?? 0;
    if (currentAmount <= 1) {
      setState(() => _cart.remove(product.id));
      return;
    }
    setState(() => _cart[product.id] = currentAmount - 1);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Só de Mercado',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
            ),
            Text(
              'Compras rápidas para sua casa',
              style: TextStyle(fontSize: 13, color: Color(0xFF657065)),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Carrinho',
            onPressed: _cartCount == 0 ? null : _showCart,
            icon: Badge.count(
              count: _cartCount,
              isLabelVisible: _cartCount > 0,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            _DeliveryCard(total: _cartTotal),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _search = value),
              decoration: InputDecoration(
                hintText: 'Buscar produtos',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Limpar busca',
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _search = '');
                        },
                        icon: const Icon(Icons.close),
                      ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return ChoiceChip(
                    label: Text(category),
                    selected: category == _selectedCategory,
                    onSelected: (_) {
                      setState(() => _selectedCategory = category);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Produtos em destaque',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  '${products.length} itens',
                  style: const TextStyle(color: Color(0xFF657065)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (products.isEmpty)
              const _EmptyState()
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 720;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWide ? 3 : 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: isWide ? 0.92 : 0.74,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        amount: _cart[product.id] ?? 0,
                        onAdd: () => _addToCart(product),
                        onRemove: () => _removeFromCart(product),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: _cartCount == 0
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: FilledButton.icon(
                  onPressed: _showCart,
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: Text(
                    'Ver carrinho - $_cartCount itens - ${formatCurrency(_cartTotal)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void _showCart() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final cartProducts = _products
                .where((product) => (_cart[product.id] ?? 0) > 0)
                .toList(growable: false);

            void updateCart(VoidCallback action) {
              setState(action);
              setSheetState(() {});
            }

            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                8,
                20,
                MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seu carrinho',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: cartProducts.length,
                      separatorBuilder: (_, __) => const Divider(height: 20),
                      itemBuilder: (context, index) {
                        final product = cartProducts[index];
                        final amount = _cart[product.id] ?? 0;
                        return Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  product.color.withValues(alpha: 0.18),
                              child: Icon(product.icon, color: product.color),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '${formatCurrency(product.price)} / ${product.unit}',
                                    style: const TextStyle(
                                      color: Color(0xFF657065),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _QuantityStepper(
                              amount: amount,
                              onAdd: () => updateCart(() {
                                _cart[product.id] = amount + 1;
                              }),
                              onRemove: () {
                                updateCart(() {
                                  if (amount <= 1) {
                                    _cart.remove(product.id);
                                  } else {
                                    _cart[product.id] = amount - 1;
                                  }
                                });
                                if (_cart.isEmpty) Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        formatCurrency(_cartTotal),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pedido finalizado com sucesso!'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Finalizar pedido'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    final freeDelivery = total >= 80;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF164B3B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.delivery_dining,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  freeDelivery ? 'Entrega grátis liberada' : 'Entrega hoje',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  freeDelivery
                      ? 'Seu pedido já passou de R\$ 80,00.'
                      : 'Frete grátis em compras acima de R\$ 80,00.',
                  style: const TextStyle(color: Color(0xFFD5E9DE)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.amount,
    required this.onAdd,
    required this.onRemove,
    super.key,
  });

  final Product product;
  final int amount;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: product.color.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      product.icon,
                      color: product.color,
                      size: 56,
                    ),
                  ),
                ),
                if (product.oldPrice != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEC5944),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'Oferta',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            product.unit,
            style: const TextStyle(color: Color(0xFF657065), fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.oldPrice != null)
                      Text(
                        formatCurrency(product.oldPrice!),
                        style: const TextStyle(
                          color: Color(0xFF98A096),
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                        ),
                      ),
                    Text(
                      formatCurrency(product.price),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              amount == 0
                  ? IconButton.filled(
                      tooltip: 'Adicionar',
                      onPressed: onAdd,
                      icon: const Icon(Icons.add),
                    )
                  : _QuantityStepper(
                      amount: amount,
                      onAdd: onAdd,
                      onRemove: onRemove,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.amount,
    required this.onAdd,
    required this.onRemove,
  });

  final int amount;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2EC),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Remover',
            constraints: const BoxConstraints.tightFor(width: 34, height: 34),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            onPressed: onRemove,
            icon: const Icon(Icons.remove, size: 18),
          ),
          SizedBox(
            width: 22,
            child: Text(
              '$amount',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          IconButton(
            tooltip: 'Adicionar',
            constraints: const BoxConstraints.tightFor(width: 34, height: 34),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            onPressed: onAdd,
            icon: const Icon(Icons.add, size: 18),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        children: [
          Icon(Icons.search_off, size: 44, color: Color(0xFF657065)),
          SizedBox(height: 12),
          Text(
            'Nenhum produto encontrado',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 4),
          Text(
            'Tente buscar por outro nome ou categoria.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF657065)),
          ),
        ],
      ),
    );
  }
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.unit,
    required this.icon,
    required this.color,
    this.oldPrice,
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final String unit;
  final IconData icon;
  final Color color;
}

String formatCurrency(double value) {
  final fixed = value.toStringAsFixed(2).replaceAll('.', ',');
  return 'R\$ $fixed';
}
