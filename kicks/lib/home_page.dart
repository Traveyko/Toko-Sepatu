import 'package:flutter/material.dart';
import 'detail.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Map<String, String>> cart = [];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      KatalogSepatuPage(addToCart: (product) {
        setState(() {
          cart.add(product);
        });
      }),
      KeranjangPage(cart: cart, removeFromCart: (int ) {  },),
      ProfilePage(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
class KeranjangPage extends StatelessWidget {
  final List<Map<String, String>> cart;
  final Function(int) removeFromCart;

  KeranjangPage({required this.cart, required this.removeFromCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
        backgroundColor: Colors.blue,
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                'Keranjang Anda kosong',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return ListTile(
                  leading: Image.network(
                    product['image']!,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product['name']!),
                  subtitle: Text(product['price']!),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      removeFromCart(index);                    
                      cart.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product['name']} dihapus dari keranjang!'),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}


class KatalogSepatuPage extends StatefulWidget {
  final Function(Map<String, String>) addToCart;

  KatalogSepatuPage({required this.addToCart});

  @override
  _KatalogSepatuPageState createState() => _KatalogSepatuPageState();
}


class _KatalogSepatuPageState extends State<KatalogSepatuPage> {
  final List<Map<String, String>> products = [
    {'name': 'Nike Air Max', 'image': 'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/a47b2ef9-8239-4e82-99fd-e6159c0df489/NIKE+AIR+MAX+97.png', 'price': 'Rp 2.000.000'},
    {'name': 'Adidas Ultraboost', 'image': 'https://d5ibtax54de3q.cloudfront.net/eyJidWNrZXQiOiJraWNrYXZlbnVlLWFzc2V0cyIsImtleSI6InByb2R1Y3RzLzc2NTI3LzlmYjY0MjIzOWY4MzY0ZTQ5NWI3ZGMzNDZjNzIyNjI0LnBuZyIsImVkaXRzIjp7InJlc2l6ZSI6eyJ3aWR0aCI6NDAwfSwid2VicCI6eyJxdWFsaXR5Ijo1MH19fQ==', 'price': 'Rp 2.500.000'},
    {'name': 'Puma RS-X', 'image': 'https://via.placeholder.com/150', 'price': 'Rp 1.800.000'},
    {'name': 'Reebok Classic', 'image': 'https://via.placeholder.com/150', 'price': 'Rp 1.500.000'},
  ];

  final List<Map<String, String>> cart = [];

  void addToCart(Map<String, String> product) {
    setState(() {
      cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} telah masuk ke keranjang!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'KICKS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade800, Colors.lightBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            floating: true,
            pinned: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(10.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    shadowColor: Colors.black26,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: Hero(
                              tag: product['name']!,
                              child: Image.network(
                                product['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                product['price']!,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                 onPressed: () => widget.addToCart(product),
                                  child: Text('Beli'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                     ),
                                      ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

