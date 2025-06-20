import '../models/product.dart';

List<Product> products = [
  Product(
    id: '1',
    name: 'Wireless Headphones',
    description: 'High-quality wireless headphones with noise cancellation',
    price: 199.99,
    imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aGVhZHBob25lc3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    stock: 50,
    rating: 4.5,
  ),
  Product(
    id: '2',
    name: 'Smartphone X',
    description: 'Latest smartphone with 128GB storage',
    price: 899.99,
    imageUrl: 'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c21hcnRwaG9uZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    stock: 30,
    rating: 4.8,
  ),
  Product(
    id: '3',
    name: 'Laptop Pro',
    description: 'Powerful laptop with 16GB RAM and 1TB SSD',
    price: 12299.99,
    imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGFwdG9wfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    stock: 20,
    rating: 4.7,
  ),
  Product(
    id: '4',
    name: 'Smart Watch',
    description: 'Fitness tracker with heart rate monitor',
    price: 1399.99,
    imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c21hcnQlMjB3YXRjaHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    stock: 45,
    rating: 4.3,
  ),
  Product(
    id: '5',
    name: 'Bluetooth Speaker',
    description: 'Portable speaker with 20h battery life',
    price: 79.99,
    imageUrl: 'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Ymx1ZXRvb3RoJTIwc3BlYWtlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    stock: 60,
    rating: 4.2,
  ),
  Product(
    id: '6',
    name: '4K TV',
    description: '55-inch 4K Ultra HD Smart TV',
    price: 19999.99,
    imageUrl: 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dHZ8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    stock: 15,
    rating: 4.6,
  ),
  Product(
    id: '7',
    name: 'Gaming Console',
    description: 'Next-gen gaming console with 1TB storage',
    price: 30099.99,
    imageUrl: 'https://images.unsplash.com/photo-1607853202273-797f1c22a38e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Z2FtaW5nJTIwY29uc29sZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    stock: 25,
    rating: 4.9,
  ),
  Product(
    id: '8',
    name: 'Digital Camera',
    description: '24MP DSLR camera with 4K video',
    price: 25009.99,
    imageUrl: 'https://images.unsplash.com/photo-1512790182412-b19e6d62bc39?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FtZXJhfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    stock: 18,
    rating: 4.4,
  ),
  Product(
    id: '9',
    name: 'Tablet',
    description: '10-inch tablet with 64GB storage',
    price: 9999.99,
    imageUrl: 'https://images.unsplash.com/photo-1546054454-aa26e2b734c7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dGFibGV0fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    stock: 35,
    rating: 4.1,
  ),
  Product(
    id: '10',
    name: 'Wireless Earbuds',
    description: 'True wireless earbuds with charging case',
    price: 1200.99,
    imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZWFyYnVkc3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    stock: 55,
    rating: 4.0,
  ),
  Product(
    id: '11',
    name: 'External SSD',
    description: '1TB portable SSD with USB-C',
    price: 3999.99,
    imageUrl: 'https://images.unsplash.com/photo-1591488320449-011701bb6704?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZXh0ZXJuYWwlMjBzc2R8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    stock: 40,
    rating: 4.7,
  ),
  Product(
    id: '12',
    name: 'Monitor',
    description: '27-inch QHD monitor with 144Hz refresh rate',
    price: 5999.99,
    imageUrl: 'https://images.unsplash.com/photo-1546538915-a9e2c8d0a8e7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bW9uaXRvcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    stock: 22,
    rating: 4.5,
  ),
];