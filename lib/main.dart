import 'package:flutter/material.dart';

void main() {
  runApp(const SoDeMercadoApp());
}

const _brandRed = Color(0xFFD71920);
const _brandDarkRed = Color(0xFF9F1118);
const _brandLightRed = Color(0xFFFFE8E6);
const _pageBackground = Color(0xFFFFF7F5);
const _textMuted = Color(0xFF756866);

const _mockCustomer = MockCustomer(
  name: 'Mariana Costa',
  email: 'mariana.costa@email.com',
  phone: '(92) 99988-7766',
  cpf: '123.456.789-00',
  memberSince: 'Cliente desde janeiro de 2025',
);

const _mockAddress = MockAddress(
  label: 'Casa',
  cep: '69058-001',
  street: 'Avenida Djalma Batista',
  number: '1661',
  neighborhood: 'Chapada',
  city: 'Manaus',
  reference: 'Apto 804, torre Rio Negro',
);

const _mockOrders = [
  MockOrder(
    id: 'SM-482913',
    date: '12 jul 2026',
    status: 'Entregue',
    total: 126.72,
    items: 'Banana, arroz, café e leite',
  ),
  MockOrder(
    id: 'SM-471208',
    date: '05 jul 2026',
    status: 'Em rota',
    total: 83.40,
    items: 'Pão francês, suco e limpeza',
  ),
  MockOrder(
    id: 'SM-460155',
    date: '28 jun 2026',
    status: 'Entregue',
    total: 214.16,
    items: 'Compra do mês',
  ),
];

class SoDeMercadoApp extends StatelessWidget {
  const SoDeMercadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Só de Mercado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _brandRed,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: _pageBackground,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: _pageBackground,
          surfaceTintColor: Colors.transparent,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: _brandRed,
            foregroundColor: Colors.white,
          ),
        ),
        chipTheme: ChipThemeData(
          selectedColor: _brandLightRed,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700),
          side: const BorderSide(color: Color(0xFFFFC9C4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
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
      seller: 'Feira do Dia',
      tag: 'Mais vendido',
      imageUrl:
          'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?auto=format&fit=crop&w=900&q=80',
    ),
    Product(
      id: 'tomate',
      name: 'Tomate italiano',
      category: 'Hortifruti',
      price: 8.49,
      unit: 'kg',
      seller: 'Horta Fresca',
      tag: 'Fresco',
      imageUrl:
          'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?auto=format&fit=crop&w=900&q=80',
    ),
    Product(
      id: 'pao',
      name: 'Pão francês',
      category: 'Padaria',
      price: 12.9,
      oldPrice: 14.9,
      unit: 'kg',
      seller: 'Padaria Central',
      tag: 'Quentinho',
      imageUrl:
          'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=900&q=80',
    ),
    Product(
      id: 'cafe',
      name: 'Café torrado',
      category: 'Mercearia',
      price: 18.75,
      unit: '500 g',
      seller: 'Casa do Café',
      tag: 'Premium',
      imageUrl:
          'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=80',
    ),
    Product(
      id: 'leite',
      name: 'Leite integral',
      category: 'Bebidas',
      price: 4.89,
      unit: '1 L',
      seller: 'Laticínios Boa Serra',
      tag: 'Gelado',
      imageUrl:
          'https://images.unsplash.com/photo-1563636619-e9143da7973b?auto=format&fit=crop&w=900&q=80',
    ),
    Product(
      id: 'suco',
      name: 'Suco de laranja',
      category: 'Bebidas',
      price: 9.99,
      oldPrice: 11.99,
      unit: '1 L',
      seller: 'Natural Mix',
      tag: 'Oferta',
      imageUrl:
          'https://images.unsplash.com/photo-1613478223719-2ab802602423?auto=format&fit=crop&w=900&q=80',
    ),
    Product(
      id: 'arroz',
      name: 'Arroz tipo 1',
      category: 'Mercearia',
      price: 24.9,
      unit: '5 kg',
      seller: 'Cesta Básica',
      tag: 'Essencial',
      imageUrl:
          'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=900&q=80',
    ),
    Product(
      id: 'sabao',
      name: 'Sabão líquido',
      category: 'Limpeza',
      price: 17.49,
      unit: '3 L',
      seller: 'Limpa Casa',
      tag: 'Casa',
      imageUrl:
          'https://images.unsplash.com/photo-1585421514284-efb74c2b69ba?auto=format&fit=crop&w=900&q=80',
    ),
  ];

  List<Product> get _filteredProducts {
    final query = _search.trim().toLowerCase();
    return _products.where((product) {
      final matchesCategory =
          _selectedCategory == 'Todos' || product.category == _selectedCategory;
      final matchesSearch = query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query) ||
          product.seller.toLowerCase().contains(query);
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

  double get _deliveryFee => _cartTotal >= 80 ? 0 : 7.99;

  List<CartLine> get _cartLines {
    return _cart.entries.map((item) {
      final product = _products.firstWhere((product) => product.id == item.key);
      return CartLine(product: product, amount: item.value);
    }).toList(growable: false);
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
              style: TextStyle(
                color: _brandDarkRed,
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'Mercado online com entrega rápida',
              style: TextStyle(fontSize: 13, color: _textMuted),
            ),
          ],
        ),
        actions: [
          IconButton.filledTonal(
            tooltip: 'Área do cliente',
            onPressed: _openCustomerArea,
            icon: const Icon(Icons.person_outline),
          ),
          const SizedBox(width: 6),
          IconButton.filledTonal(
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
            _PromoBanner(total: _cartTotal),
            const SizedBox(height: 14),
            _SearchField(
              controller: _searchController,
              search: _search,
              onChanged: (value) => setState(() => _search = value),
              onClear: () {
                _searchController.clear();
                setState(() => _search = '');
              },
            ),
            const SizedBox(height: 14),
            _CategoryStrip(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onSelected: (category) {
                setState(() => _selectedCategory = category);
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Compre por produto',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
                  ),
                ),
                Text(
                  '${products.length} itens',
                  style: const TextStyle(color: _textMuted),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (products.isEmpty)
              const _EmptyState()
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 1000
                      ? 4
                      : constraints.maxWidth >= 680
                          ? 3
                          : 2;
                  final ratio = constraints.maxWidth >= 680 ? 0.68 : 0.57;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: ratio,
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
                      fontWeight: FontWeight.w800,
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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ProductImage(
                                url: product.imageUrl,
                                height: 54,
                                width: 54,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    '${formatCurrency(product.price)} / ${product.unit}',
                                    style: const TextStyle(color: _textMuted),
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
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Text(
                        formatCurrency(_cartTotal),
                        style: const TextStyle(
                          color: _brandDarkRed,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      final lines = _cartLines;
                      final subtotal = _cartTotal;
                      final deliveryFee = _deliveryFee;
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => CheckoutPage(
                            lines: lines,
                            subtotal: subtotal,
                            deliveryFee: deliveryFee,
                            onOrderPlaced: () {
                              setState(_cart.clear);
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Continuar para checkout'),
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

  void _openCustomerArea() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const CustomerAreaPage(),
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    final freeDelivery = total >= 80;
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 172,
        decoration: const BoxDecoration(color: _brandRed),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=1200&q=80',
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.34),
              colorBlendMode: BlendMode.darken,
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      freeDelivery ? 'Entrega grátis' : 'Oferta do dia',
                      style: const TextStyle(
                        color: _brandDarkRed,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 310),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mercado completo sem sair de casa',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          freeDelivery
                              ? 'Seu pedido já passou de R\$ 80,00.'
                              : 'Frete grátis acima de R\$ 80,00.',
                          style: const TextStyle(
                            color: Color(0xFFFFE0DD),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.search,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final String search;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Buscar produto, categoria ou loja',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: search.isEmpty
            ? null
            : IconButton(
                tooltip: 'Limpar busca',
                onPressed: onClear,
                icon: const Icon(Icons.close),
              ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _CategoryStrip extends StatelessWidget {
  const _CategoryStrip({
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          return ChoiceChip(
            label: Text(category),
            selected: category == selectedCategory,
            onSelected: (_) => onSelected(category),
          );
        },
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
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFD8D3)),
        boxShadow: [
          BoxShadow(
            color: _brandRed.withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ProductImage(url: product.imageUrl),
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0x33000000)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: _TagPill(
                    label: product.oldPrice == null ? product.tag : 'Oferta',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.seller,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _brandRed,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.unit,
                  style: const TextStyle(color: _textMuted, fontSize: 13),
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
                                color: Color(0xFF9F8E8C),
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                              ),
                            ),
                          Text(
                            formatCurrency(product.price),
                            style: const TextStyle(
                              color: _brandDarkRed,
                              fontSize: 18,
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
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    required this.url,
    this.height,
    this.width,
    super.key,
  });

  final String url;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          height: height,
          width: width,
          color: _brandLightRed,
          alignment: Alignment.center,
          child: const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (_, __, ___) {
        return Container(
          height: height,
          width: width,
          color: _brandLightRed,
          alignment: Alignment.center,
          child: const Icon(Icons.image_not_supported_outlined),
        );
      },
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: _brandRed,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
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
        color: _brandLightRed,
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
              style: const TextStyle(
                color: _brandDarkRed,
                fontWeight: FontWeight.w900,
              ),
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.search_off, size: 44, color: _textMuted),
          SizedBox(height: 12),
          Text(
            'Nenhum produto encontrado',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 4),
          Text(
            'Tente buscar por outro nome ou categoria.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _textMuted),
          ),
        ],
      ),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    required this.lines,
    required this.subtotal,
    required this.deliveryFee,
    required this.onOrderPlaced,
    super.key,
  });

  final List<CartLine> lines;
  final double subtotal;
  final double deliveryFee;
  final VoidCallback onOrderPlaced;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _accountFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cepController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _referenceController = TextEditingController();

  int _step = 0;
  bool _orderPlaced = false;
  String _deliveryWindow = 'Hoje, 18h - 20h';
  String _paymentMethod = 'Pix';
  late final String _orderId;

  double get _total => widget.subtotal + widget.deliveryFee;

  @override
  void initState() {
    super.initState();
    final suffix = DateTime.now().millisecondsSinceEpoch.toString();
    _orderId = 'SM-${suffix.substring(suffix.length - 6)}';
    _fillMockCheckoutData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cepController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_step == 3 ? 'Status do pedido' : 'Checkout'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _CheckoutProgress(currentStep: _step),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: switch (_step) {
                0 => _buildAccountStep(),
                1 => _buildAddressStep(),
                2 => _buildReviewStep(),
                _ => _buildStatusStep(),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountStep() {
    return _CheckoutSection(
      key: const ValueKey('account'),
      title: 'Crie sua conta',
      subtitle:
          'Use seus dados para acompanhar pedidos e receber atualizações.',
      icon: Icons.person_add_alt_1_outlined,
      child: Form(
        key: _accountFormKey,
        child: Column(
          children: [
            _MockDataCard(
              title: 'Conta mockada',
              subtitle: '${_mockCustomer.name} • ${_mockCustomer.email}',
              icon: Icons.auto_awesome,
              onTap: _fillMockCheckoutData,
            ),
            const SizedBox(height: 12),
            _CheckoutTextField(
              controller: _nameController,
              label: 'Nome completo',
              icon: Icons.badge_outlined,
            ),
            const SizedBox(height: 12),
            _CheckoutTextField(
              controller: _emailController,
              label: 'E-mail',
              icon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe seu e-mail';
                }
                if (!value.contains('@')) return 'Informe um e-mail válido';
                return null;
              },
            ),
            const SizedBox(height: 12),
            _CheckoutTextField(
              controller: _phoneController,
              label: 'Telefone ou WhatsApp',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: () {
                if (_accountFormKey.currentState?.validate() ?? false) {
                  setState(() => _step = 1);
                }
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Criar conta e continuar'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressStep() {
    return _CheckoutSection(
      key: const ValueKey('address'),
      title: 'Endereço de entrega',
      subtitle: 'Informe onde o mercado deve entregar suas compras.',
      icon: Icons.location_on_outlined,
      child: Form(
        key: _addressFormKey,
        child: Column(
          children: [
            _MockDataCard(
              title: 'Usar endereço salvo',
              subtitle: _mockAddress.fullLine,
              icon: Icons.home_work_outlined,
              onTap: _fillMockCheckoutData,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _CheckoutTextField(
                    controller: _cepController,
                    label: 'CEP',
                    icon: Icons.pin_drop_outlined,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: _CheckoutTextField(
                    controller: _cityController,
                    label: 'Cidade',
                    icon: Icons.location_city_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _CheckoutTextField(
              controller: _streetController,
              label: 'Rua/Avenida',
              icon: Icons.signpost_outlined,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _CheckoutTextField(
                    controller: _numberController,
                    label: 'Número',
                    icon: Icons.home_outlined,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _CheckoutTextField(
                    controller: _neighborhoodController,
                    label: 'Bairro',
                    icon: Icons.map_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _referenceController,
              minLines: 2,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Complemento ou referência',
                prefixIcon: const Icon(Icons.notes_outlined),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _DeliveryWindowPicker(
              selected: _deliveryWindow,
              onSelected: (value) => setState(() => _deliveryWindow = value),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() => _step = 0),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Voltar'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      if (_addressFormKey.currentState?.validate() ?? false) {
                        setState(() => _step = 2);
                      }
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Continuar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewStep() {
    return Column(
      key: const ValueKey('review'),
      children: [
        _CheckoutSection(
          title: 'Revise seu pedido',
          subtitle: 'Confira produtos, entrega e forma de pagamento.',
          icon: Icons.receipt_long_outlined,
          child: Column(
            children: [
              ...widget.lines.map(
                (line) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ProductImage(
                          url: line.product.imageUrl,
                          height: 52,
                          width: 52,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              line.product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '${line.amount} x ${formatCurrency(line.product.price)}',
                              style: const TextStyle(color: _textMuted),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        formatCurrency(line.total),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 22),
              _SummaryRow(
                  label: 'Produtos', value: formatCurrency(widget.subtotal)),
              _SummaryRow(
                label: 'Entrega',
                value: widget.deliveryFee == 0
                    ? 'Grátis'
                    : formatCurrency(widget.deliveryFee),
              ),
              _SummaryRow(
                label: 'Total',
                value: formatCurrency(_total),
                highlight: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _CheckoutSection(
          title: 'Pagamento',
          subtitle: 'Escolha como quer pagar na simulação do checkout.',
          icon: Icons.payments_outlined,
          child: Column(
            children: [
              _PaymentTile(
                title: 'Pix',
                subtitle: 'Código Pix gerado após confirmar',
                icon: Icons.qr_code_2,
                selected: _paymentMethod == 'Pix',
                onTap: () => setState(() => _paymentMethod = 'Pix'),
              ),
              _PaymentTile(
                title: 'Cartão na entrega',
                subtitle: 'Débito ou crédito com a maquininha',
                icon: Icons.credit_card,
                selected: _paymentMethod == 'Cartão na entrega',
                onTap: () =>
                    setState(() => _paymentMethod = 'Cartão na entrega'),
              ),
              _PaymentTile(
                title: 'Dinheiro',
                subtitle: 'Pague ao receber suas compras',
                icon: Icons.attach_money,
                selected: _paymentMethod == 'Dinheiro',
                onTap: () => setState(() => _paymentMethod = 'Dinheiro'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _CheckoutSection(
          title: 'Entrega',
          subtitle: 'Seu pedido será enviado para o endereço informado.',
          icon: Icons.delivery_dining,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_streetController.text}, ${_numberController.text}',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              Text(
                '${_neighborhoodController.text}, ${_cityController.text} - CEP ${_cepController.text}',
                style: const TextStyle(color: _textMuted),
              ),
              if (_referenceController.text.trim().isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  _referenceController.text.trim(),
                  style: const TextStyle(color: _textMuted),
                ),
              ],
              const SizedBox(height: 10),
              _InfoPill(
                icon: Icons.schedule,
                label: _deliveryWindow,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _step = 1),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Voltar'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton.icon(
                onPressed: _confirmOrder,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Confirmar pedido'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusStep() {
    return Column(
      key: const ValueKey('status'),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _brandRed,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 42),
              const SizedBox(height: 12),
              Text(
                'Pedido $_orderId confirmado',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Pagamento: $_paymentMethod • Entrega: $_deliveryWindow',
                style: const TextStyle(
                  color: Color(0xFFFFE0DD),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const _CheckoutSection(
          title: 'Acompanhe seu pedido',
          subtitle: 'Status mockado para demonstrar o fluxo completo.',
          icon: Icons.timeline_outlined,
          child: Column(
            children: [
              _StatusTile(
                title: 'Pedido recebido',
                subtitle: 'Seu pedido entrou na fila do mercado.',
                active: true,
                first: true,
              ),
              _StatusTile(
                title: 'Separando compras',
                subtitle: 'Nossa equipe está selecionando os produtos.',
                active: true,
              ),
              _StatusTile(
                title: 'Saiu para entrega',
                subtitle: 'O entregador será atribuído em instantes.',
              ),
              _StatusTile(
                title: 'Entregue',
                subtitle: 'Finalização após a chegada no endereço.',
                last: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _CheckoutSection(
          title: 'Resumo final',
          subtitle: '$_mockEtaText estimados para chegar.',
          icon: Icons.shopping_bag_outlined,
          child: Column(
            children: [
              _SummaryRow(
                  label: 'Itens', value: '${widget.lines.length} produtos'),
              _SummaryRow(
                  label: 'Total pago',
                  value: formatCurrency(_total),
                  highlight: true),
              _SummaryRow(label: 'Conta', value: _nameController.text.trim()),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.storefront),
          label: const Text('Voltar às compras'),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
          ),
        ),
      ],
    );
  }

  void _confirmOrder() {
    if (!_orderPlaced) {
      widget.onOrderPlaced();
      _orderPlaced = true;
    }
    setState(() => _step = 3);
  }

  void _fillMockCheckoutData() {
    _nameController.text = _mockCustomer.name;
    _emailController.text = _mockCustomer.email;
    _phoneController.text = _mockCustomer.phone;
    _cepController.text = _mockAddress.cep;
    _streetController.text = _mockAddress.street;
    _numberController.text = _mockAddress.number;
    _neighborhoodController.text = _mockAddress.neighborhood;
    _cityController.text = _mockAddress.city;
    _referenceController.text = _mockAddress.reference;
    _deliveryWindow = 'Hoje, 18h - 20h';
    _paymentMethod = 'Pix';
    if (mounted) setState(() {});
  }
}

const _mockEtaText = '35-50 min';

class _CheckoutProgress extends StatelessWidget {
  const _CheckoutProgress({required this.currentStep});

  final int currentStep;

  static const _labels = ['Conta', 'Entrega', 'Pagamento', 'Status'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_labels.length, (index) {
        final active = index <= currentStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == _labels.length - 1 ? 0 : 6),
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              color: active ? _brandRed : Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: active ? _brandRed : const Color(0xFFFFD8D3),
              ),
            ),
            child: Text(
              _labels[index],
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: active ? Colors.white : _textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _MockDataCard extends StatelessWidget {
  const _MockDataCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _brandLightRed,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFFFC9C4)),
        ),
        child: Row(
          children: [
            Icon(icon, color: _brandRed),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: _brandDarkRed,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _textMuted),
                  ),
                ],
              ),
            ),
            const Icon(Icons.refresh, color: _brandRed),
          ],
        ),
      ),
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  const _CheckoutSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFD8D3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: _brandLightRed,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: _brandRed),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(color: _textMuted, height: 1.25),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class CustomerAreaPage extends StatelessWidget {
  const CustomerAreaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área do cliente')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _brandRed,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Container(
                    height: 62,
                    width: 62,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: _brandRed,
                      size: 34,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _mockCustomer.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _mockCustomer.memberSince,
                          style: const TextStyle(
                            color: Color(0xFFFFE0DD),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _CheckoutSection(
              title: 'Dados da conta',
              subtitle: 'Perfil mockado para testes do fluxo de compra.',
              icon: Icons.account_circle_outlined,
              child: Column(
                children: [
                  _ProfileRow(
                    icon: Icons.mail_outline,
                    label: 'E-mail',
                    value: _mockCustomer.email,
                  ),
                  _ProfileRow(
                    icon: Icons.phone_outlined,
                    label: 'Telefone',
                    value: _mockCustomer.phone,
                  ),
                  _ProfileRow(
                    icon: Icons.badge_outlined,
                    label: 'CPF',
                    value: _mockCustomer.cpf,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const _CheckoutSection(
              title: 'Endereço salvo',
              subtitle: 'Usado automaticamente no checkout mockado.',
              icon: Icons.location_on_outlined,
              child: _SavedAddressCard(address: _mockAddress),
            ),
            const SizedBox(height: 12),
            _CheckoutSection(
              title: 'Pedidos recentes',
              subtitle: 'Histórico mockado com status de pedidos.',
              icon: Icons.receipt_long_outlined,
              child: Column(
                children: _mockOrders
                    .map(
                      (order) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _OrderHistoryCard(order: order),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            const _CheckoutSection(
              title: 'Carteira',
              subtitle: 'Métodos mockados para a tela do cliente.',
              icon: Icons.account_balance_wallet_outlined,
              child: Column(
                children: [
                  _ProfileRow(
                    icon: Icons.qr_code_2,
                    label: 'Pix favorito',
                    value: 'mariana.costa@email.com',
                  ),
                  _ProfileRow(
                    icon: Icons.credit_card,
                    label: 'Cartão salvo',
                    value: 'Final 4482 • Crédito',
                  ),
                  _ProfileRow(
                    icon: Icons.local_offer_outlined,
                    label: 'Cupom disponível',
                    value: 'MERCADO10',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: _brandRed),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: _textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedAddressCard extends StatelessWidget {
  const _SavedAddressCard({required this.address});

  final MockAddress address;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBFA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFD8D3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.home_outlined, color: _brandRed),
              const SizedBox(width: 8),
              Text(
                address.label,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(address.fullLine),
          const SizedBox(height: 4),
          Text(
            '${address.city} • CEP ${address.cep}',
            style: const TextStyle(color: _textMuted),
          ),
          const SizedBox(height: 4),
          Text(
            address.reference,
            style: const TextStyle(color: _textMuted),
          ),
        ],
      ),
    );
  }
}

class _OrderHistoryCard extends StatelessWidget {
  const _OrderHistoryCard({required this.order});

  final MockOrder order;

  @override
  Widget build(BuildContext context) {
    final isActive = order.status != 'Entregue';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? _brandLightRed : const Color(0xFFFFFBFA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFD8D3)),
      ),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.delivery_dining : Icons.check_circle_outline,
            color: _brandRed,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${order.id} • ${order.status}',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  '${order.date} • ${order.items}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _textMuted),
                ),
              ],
            ),
          ),
          Text(
            formatCurrency(order.total),
            style: const TextStyle(
              color: _brandDarkRed,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckoutTextField extends StatelessWidget {
  const _CheckoutTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Preencha este campo';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _DeliveryWindowPicker extends StatelessWidget {
  const _DeliveryWindowPicker({
    required this.selected,
    required this.onSelected,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  static const _windows = [
    'Hoje, 18h - 20h',
    'Hoje, 20h - 22h',
    'Amanhã, 09h - 11h',
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _windows.map((window) {
          return ChoiceChip(
            label: Text(window),
            selected: selected == window,
            onSelected: (_) => onSelected(window),
          );
        }).toList(),
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selected ? _brandLightRed : const Color(0xFFFFFBFA),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? _brandRed : const Color(0xFFFFD8D3),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: selected ? _brandRed : _textMuted),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(color: _textMuted),
                    ),
                  ],
                ),
              ),
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? _brandRed : _textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: highlight ? Colors.black : _textMuted,
                fontWeight: highlight ? FontWeight.w900 : FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: highlight ? _brandDarkRed : Colors.black,
              fontSize: highlight ? 18 : 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: _brandLightRed,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _brandRed, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: _brandDarkRed,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({
    required this.title,
    required this.subtitle,
    this.active = false,
    this.first = false,
    this.last = false,
  });

  final String title;
  final String subtitle;
  final bool active;
  final bool first;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: first
                        ? Colors.transparent
                        : active
                            ? _brandRed
                            : const Color(0xFFFFD8D3),
                  ),
                ),
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    color: active ? _brandRed : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: _brandRed, width: 2),
                  ),
                  child: active
                      ? const Icon(Icons.check, color: Colors.white, size: 12)
                      : null,
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: last ? Colors.transparent : const Color(0xFFFFD8D3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: active ? Colors.black : _textMuted,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(color: _textMuted),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartLine {
  const CartLine({required this.product, required this.amount});

  final Product product;
  final int amount;

  double get total => product.price * amount;
}

class MockCustomer {
  const MockCustomer({
    required this.name,
    required this.email,
    required this.phone,
    required this.cpf,
    required this.memberSince,
  });

  final String name;
  final String email;
  final String phone;
  final String cpf;
  final String memberSince;
}

class MockAddress {
  const MockAddress({
    required this.label,
    required this.cep,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.reference,
  });

  final String label;
  final String cep;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String reference;

  String get fullLine => '$street, $number - $neighborhood';
}

class MockOrder {
  const MockOrder({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
  });

  final String id;
  final String date;
  final String status;
  final double total;
  final String items;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.unit,
    required this.seller,
    required this.tag,
    required this.imageUrl,
    this.oldPrice,
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final String unit;
  final String seller;
  final String tag;
  final String imageUrl;
}

String formatCurrency(double value) {
  final fixed = value.toStringAsFixed(2).replaceAll('.', ',');
  return 'R\$ $fixed';
}
