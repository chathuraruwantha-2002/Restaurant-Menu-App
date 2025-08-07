import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantMenuApp());
}

class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Menu',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Data Models
class FoodItem {
  final String id;
  final String name;
  final String image;
  final double price;
  final double rating;
  final String description;
  final String category;

  const FoodItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.description,
    required this.category,
  });
}

class Category {
  final String id;
  final String name;
  final IconData icon;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
  });
}

// Sample Data
class SampleData {
  static const List<Category> categories = [
    Category(id: '1', name: 'All', icon: Icons.restaurant_menu),
    Category(id: '2', name: 'Pizza', icon: Icons.local_pizza),
    Category(id: '3', name: 'Burgers', icon: Icons.lunch_dining),
    Category(id: '4', name: 'Desserts', icon: Icons.cake),
    Category(id: '5', name: 'Drinks', icon: Icons.local_cafe),
  ];

  static const List<FoodItem> foodItems = [
    FoodItem(
      id: '1',
      name: 'Margherita Pizza',
      image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=300',
      price: 12.99,
      rating: 4.5,
      description: 'Classic Italian pizza with fresh tomatoes, mozzarella cheese, and basil leaves on a crispy thin crust.',
      category: 'Pizza',
    ),
    FoodItem(
      id: '2',
      name: 'Beef Burger',
      image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300',
      price: 15.99,
      rating: 4.7,
      description: 'Juicy beef patty with lettuce, tomato, onion, pickles, and our special sauce on a sesame seed bun.',
      category: 'Burgers',
    ),
    FoodItem(
      id: '3',
      name: 'Chocolate Cake',
      image: 'https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?w=300',
      price: 8.99,
      rating: 4.8,
      description: 'Rich and moist chocolate cake with layers of chocolate ganache and fresh berries.',
      category: 'Desserts',
    ),
    FoodItem(
      id: '4',
      name: 'Cappuccino',
      image: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=300',
      price: 4.99,
      rating: 4.3,
      description: 'Perfect blend of espresso, steamed milk, and milk foam with a sprinkle of cocoa powder.',
      category: 'Drinks',
    ),
    FoodItem(
      id: '5',
      name: 'Pepperoni Pizza',
      image: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=300',
      price: 14.99,
      rating: 4.6,
      description: 'Classic pepperoni pizza with mozzarella cheese and savory pepperoni slices.',
      category: 'Pizza',
    ),
    FoodItem(
      id: '6',
      name: 'Chicken Burger',
      image: 'https://images.unsplash.com/photo-1551615593-ef5fe247e8f7?w=300',
      price: 13.99,
      rating: 4.4,
      description: 'Grilled chicken breast with crispy lettuce, tomato, and mayo on a toasted bun.',
      category: 'Burgers',
    ),
  ];
}

// Custom Widgets

/// Rating Stars Widget - Displays star ratings

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;

  const RatingStars({
    Key? key,
    required this.rating,
    this.size = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: size,
        );
      }),
    );
  }
}

/// Category Card Widget - Horizontal scrolling category items
class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              category.name,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Food Card Widget - Grid item displaying food details
class FoodCard extends StatelessWidget {
  final FoodItem foodItem;
  final VoidCallback onTap;

  const FoodCard({
    Key? key,
    required this.foodItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  image: DecorationImage(
                    image: NetworkImage(foodItem.image),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {
                      // Handle image loading error
                    },
                  ),
                ),
                child: foodItem.image.startsWith('http') 
                  ? null 
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
              ),
            ),
            // Food Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Food Name
                    Text(
                      foodItem.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Rating
                    RatingStars(rating: foodItem.rating, size: 14),
                    // Price
                    Text(
                      '\$${foodItem.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Screens

/// Home Screen - Main screen with categories and food grid
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  
  List<FoodItem> get filteredFoodItems {
    if (selectedCategory == 'All') {
      return SampleData.foodItems;
    }
    return SampleData.foodItems
        .where((item) => item.category == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Restaurant Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories Section
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: SampleData.categories.length,
              itemBuilder: (context, index) {
                final category = SampleData.categories[index];
                return CategoryCard(
                  category: category,
                  isSelected: selectedCategory == category.name,
                  onTap: () {
                    setState(() {
                      selectedCategory = category.name;
                    });
                  },
                );
              },
            ),
          ),
          
          // Food Grid Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: OrientationBuilder(
                builder: (context, orientation) {
                  // Responsive grid - more columns in landscape
                  int crossAxisCount = orientation == Orientation.portrait ? 2 : 3;
                  
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: filteredFoodItems.length,
                    itemBuilder: (context, index) {
                      final foodItem = filteredFoodItems[index];
                      return FoodCard(
                        foodItem: foodItem,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodDetailScreen(foodItem: foodItem),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Food Detail Screen - Detailed view of selected food item
class FoodDetailScreen extends StatelessWidget {
  final FoodItem foodItem;

  const FoodDetailScreen({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Hero(
              tag: foodItem.id,
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(foodItem.image),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {
                      // Handle image loading error
                    },
                  ),
                ),
                child: foodItem.image.startsWith('http')
                  ? null
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.restaurant,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
              ),
            ),
            
            // Food Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Name
                  Text(
                    foodItem.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Rating and Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RatingStars(rating: foodItem.rating, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '(${foodItem.rating})',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '\$${foodItem.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    foodItem.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Order Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${foodItem.name} added to cart!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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