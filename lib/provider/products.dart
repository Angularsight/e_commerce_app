
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/cupertino.dart';

class Products with ChangeNotifier {
  List<Product> _firebaseProducts = [];

  List<Product> _products = [
    Product(
        id: 'Samsung1',
        title: 'Samsung Galaxy S9',
        description:
            'Samsung Galaxy S9 G960U 64GB Unlocked GSM 4G LTE Phone w/ 12MP Camera - Midnight Black',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Phones',
        quantity: 65,
        isPopular: false),
    Product(
        id: 'Samsung Galaxy A10s',
        title: 'Samsung Galaxy A10s',
        description:
            'Samsung Galaxy A10s A107M - 32GB, 6.2" HD+ Infinity-V Display, 13MP+2MP Dual Rear +8MP Front Cameras, GSM Unlocked Smartphone - Blue.',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51ME-ADMjRL._AC_SL1000_.jpg',
        brand: 'Samsung ',
        productCategoryName: 'Phones',
        quantity: 1002,
        isPopular: false),
    Product(
        id: 'Samsung Galaxy A51',
        title: 'Samsung Galaxy A51',
        description:
            'Samsung Galaxy A51 (128GB, 4GB) 6.5", 48MP Quad Camera, Dual SIM GSM Unlocked A515F/DS- Global 4G LTE International Model - Prism Crush Blue.',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61HFJwSDQ4L._AC_SL1000_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Phones',
        quantity: 6423,
        isPopular: true),
    Product(
        id: 'Huawei P40 Pro',
        title: 'Huawei P40 Pro',
        description:
            'Huawei P40 Pro (5G) ELS-NX9 Dual/Hybrid-SIM 256GB (GSM Only | No CDMA) Factory Unlocked Smartphone (Silver Frost) - International Version',
        price: 900.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/6186cnZIdoL._AC_SL1000_.jpg',
        brand: 'Huawei',
        productCategoryName: 'Phones',
        quantity: 3,
        isPopular: true),
    Product(
        id: 'iPhone 12 Pro',
        title: 'iPhone 12 Pro',
        description:
            'New Apple iPhone 12 Pro (512GB, Gold) [Locked] + Carrier Subscription',
        price: 1100,
        imageUrl: 'https://m.media-amazon.com/images/I/71cSV-RTBSL.jpg',
        brand: 'Apple',
        productCategoryName: 'Phones',
        quantity: 3,
        isPopular: true),
    Product(
        id: 'iPhone 12 Pro Max ',
        title: 'iPhone 12 Pro Max ',
        description:
            'New Apple iPhone 12 Pro Max (128GB, Graphite) [Locked] + Carrier Subscription',
        price: 50.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71XXJC7V8tL._FMwebp__.jpg',
        brand: 'Apple',
        productCategoryName: 'Phones',
        quantity: 2654,
        isPopular: false),
    Product(
        id: 'Hanes Mens ',
        title: 'Long Sleeve Beefy Henley Shirt',
        description: 'Hanes Men\'s Long Sleeve Beefy Henley Shirt ',
        price: 22.30,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
        brand: 'No brand',
        productCategoryName: 'Clothes',
        quantity: 58466,
        isPopular: true),
    Product(
        id: 'Weave Jogger',
        title: 'Weave Jogger',
        description: 'Champion Mens Reverse Weave Jogger',
        price: 58.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71g7tHQt-sL._AC_UL320_.jpg',
        brand: 'H&M',
        productCategoryName: 'Clothes',
        quantity: 84894,
        isPopular: false),
    Product(
        id: 'Adeliber Dresses for Womens',
        title: 'Adeliber Dresses for Womens',
        description:
            'Adeliber Dresses for Womens, Sexy Solid Sequined Stitching Shining Club Sheath Long Sleeved Mini Dress',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/7177o9jITiL._AC_UX466_.jpg',
        brand: 'H&M',
        productCategoryName: 'Clothes',
        quantity: 49847,
        isPopular: true),
    Product(
        id: 'Tanjun Sneakers',
        title: 'Tanjun Sneakers',
        description:
            'NIKE Men\'s Tanjun Sneakers, Breathable Textile Uppers and Comfortable Lightweight Cushioning ',
        price: 191.89,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71KVPm5KJdL._AC_UX500_.jpg',
        brand: 'Nike',
        productCategoryName: 'Shoes',
        quantity: 65489,
        isPopular: false),
    Product(
        id: 'High Spirit ',
        title: 'PARADISE IS REAL BACKPACK',
        description: 'This all-over Palm tree print backpack has a lot of room with a big inner pocket, a separate section for a 15 inch laptop, a front pocket, and a hidden pocket at the back for smaller valuables. The bag is made of a water-resistant material. The soft, padded mesh material on the back and the handles make it perfect for daily use or sporting activities.',
        price: 75.00,
        imageUrl:
        'https://images.squarespace-cdn.com/content/v1/548ec3bee4b068057bfb6db7/1555524365342-FSB67T1LCR7M776FHNTB/palm+trees+bag.jpg?format=1000w',
        brand: 'High Spirit',
        productCategoryName: 'Bags',
        quantity: 4550,
        isPopular: true),
    Product(
        id: 'Satan Shoes',
        title: 'Lil Nas X Satan Shoes',
        description: 'Behold, I have given you authority to tread on serpents and scorpions, and over all the power of the enemy, and nothing shall hurt you.',
        price: 1018,
        imageUrl:
        'https://c.files.bbci.co.uk/44CF/production/_117751671_satan-shoes1.jpg',
        brand: 'Nike',
        productCategoryName: 'Shoes',
        quantity: 20,
        isPopular: true),
    Product(
        id: 'Silver Stud Earrings Metal Drops & Danglers for Womens',
        title: 'Silver Stud Earrings Metal Drops & Danglers',
        description:
        'Beautiful High Quality Gold Plated Earrings,Designer and Trendy Earrings, perfect for all occasions.The Product is made from Non Allergic Metal thus making it safe to wear.Occasion will add luster when worn for a wedding, engagement, party, prom and any special occasion.Occasion will add luster when worn for a wedding, engagement, party, prom and any special occasion.',
        price: 10,
        imageUrl:
        'https://5.imimg.com/data5/IU/JV/MY-22625489/german-silver-stone-studs-500x500.jpg',
        brand: 'AnEk Goods',
        productCategoryName: 'Jewellery',
        quantity: 49847,
        isPopular: true),
    Product(
        id: 'Stag TT table',
        title: 'Stag Table Tennis Table International Deluxe',
        description:
        'Stag Table Tennis Table International Deluxe 1000dx 25mm Top, 100mm Wheels ',
        price: 550,
        imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Table_Tennis_Table_Blue.svg/440px-Table_Tennis_Table_Blue.svg.png',
        brand: 'Stag',
        productCategoryName: 'Sports',
        quantity: 65489,
        isPopular: true)
  ];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get discountProducts{
    return _products.where((element) => element.isPopular).toList();
  }


  //This is for the search Bar query
  List<Product> searchedProducts(String searchQuery){

    List<Product> wantedProducts = _products.where((element) => element.title!.toLowerCase().contains(searchQuery)).toList();
    return wantedProducts;

  }

  List<Product> _carouselProducts = [
    Product(
        id: 'High Spirit ',
        title: 'PARADISE IS REAL BACKPACK',
        description: 'This all-over Palm tree print backpack has a lot of room with a big inner pocket, a separate section for a 15 inch laptop, a front pocket, and a hidden pocket at the back for smaller valuables. The bag is made of a water-resistant material. The soft, padded mesh material on the back and the handles make it perfect for daily use or sporting activities.',
        price: 75.00,
        imageUrl:
        'https://images.squarespace-cdn.com/content/v1/548ec3bee4b068057bfb6db7/1555524365342-FSB67T1LCR7M776FHNTB/palm+trees+bag.jpg?format=1000w',
        brand: 'High Spirit',
        productCategoryName: 'Bags',
        quantity: 4550,
        isPopular: true),
    Product(
        id: 'Satan Shoes',
        title: 'Lil Nas X Satan Shoes',
        description: 'Behold, I have given you authority to tread on serpents and scorpions, and over all the power of the enemy, and nothing shall hurt you.',
        price: 1018,
        imageUrl:
        'https://c.files.bbci.co.uk/44CF/production/_117751671_satan-shoes1.jpg',
        brand: 'Nike',
        productCategoryName: 'Shoes',
        quantity: 20,
        isPopular: true),
    Product(
        id: 'Silver Stud Earrings Metal Drops & Danglers for Womens',
        title: 'Silver Stud Earrings Metal Drops & Danglers',
        description:
        'Beautiful High Quality Gold Plated Earrings,Designer and Trendy Earrings, perfect for all occasions.The Product is made from Non Allergic Metal thus making it safe to wear.Occasion will add luster when worn for a wedding, engagement, party, prom and any special occasion.Occasion will add luster when worn for a wedding, engagement, party, prom and any special occasion.',
        price: 10,
        imageUrl:
        'https://5.imimg.com/data5/IU/JV/MY-22625489/german-silver-stone-studs-500x500.jpg',
        brand: 'AnEk Goods',
        productCategoryName: 'Jewellery',
        quantity: 49847,
        isPopular: true),
    Product(
        id: 'Stag TT table',
        title: 'Stag Table Tennis Table International Deluxe',
        description:
        'Stag Table Tennis Table International Deluxe 1000dx 25mm Top, 100mm Wheels ',
        price: 550,
        imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Table_Tennis_Table_Blue.svg/440px-Table_Tennis_Table_Blue.svg.png',
        brand: 'Stag',
        productCategoryName: 'Sports',
        quantity: 65489,
        isPopular: true)
  ];

  List<Product> get carouselProducts {
    return [..._carouselProducts];
  }


}
