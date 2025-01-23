import 'package:flutter/material.dart';
import 'package:ni_flutter_sdk/ni_flutter_sdk.dart';

import '../models/product_model.dart';
import 'widget/add_product_dialog.dart';
import 'widget/home_bottom_bar.dart';
import 'widget/product_item.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  NiSdk niSDK = NiSdk();

  bool showAddProductDialog = false;
  List<ProductModel> products = [];
  double total = 0;
  List<ProductModel> selectedProducts = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    ProductModel.getProducts().then((value) {
      setState(() {
        products = [
          ...[
            ProductModel(
              name: "🐊",
              amount: 1.0,
            ),
            ProductModel(
              name: "🦏",
              amount: 450.0,
            ),
            ProductModel(
              name: "🐋",
              amount: 450.12,
            ),
            ProductModel(
              name: "🦠",
              amount: 700.0,
            ),
            ProductModel(
              name: "🐙",
              amount: 1500.0,
            ),
            ProductModel(
              name: "🐡",
              amount: 2200.0,
            ),
            ProductModel(
              name: "🐶",
              amount: 3000.0,
            ),
            ProductModel(
              name: "🦊",
              amount: 3000.12,
            ),
          ],
          ...value,
        ];
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // widget.onRefresh();
    }
  }

  void addProduct(ProductModel product) async {
    List<ProductModel> products = await ProductModel.getProducts();
    products.add(product);
    ProductModel.saveProducts(products);
    setState(() {
      products = products;
    });
  }

  void deleteProduct(ProductModel product) async {
    List<ProductModel> products = await ProductModel.getProducts();
    products.remove(product);
    ProductModel.saveProducts(products);
    setState(() {
      products = products;
    });
  }

  void toggleProductSelection(ProductModel product) {
    setState(() {
      if (selectedProducts.contains(product)) {
        selectedProducts.remove(product);
      } else {
        selectedProducts.add(product);
      }
      total = selectedProducts.fold(0, (sum, item) => sum + item.amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Store"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
            // onPressed: widget.onClickEnvironment,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                showAddProductDialog = true;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (showAddProductDialog)
              AddProductDialog(
                onCancel: () {
                  setState(() {
                    showAddProductDialog = false;
                  });
                },
                onAddProduct: (product) {
                  addProduct(product);
                  setState(() {
                    showAddProductDialog = false;
                  });
                },
              ),
            Expanded(
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: products.map((product) {
                  return ProductItem(
                    product: product,
                    isSelected: selectedProducts.contains(product),
                    currency: "INR",
                    onClick: () => toggleProductSelection(product),
                    // onClick: () => addProduct(product),
                    onDeleteProduct: () => deleteProduct(product),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            if (total != 0.00)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: HomeBottomBar(
                  total: total,
                  isSamsungPayAvailable: true,
                  currency: "INR",
                  onClickPayByCard: niSDK.makeCardPayment,
                  onClickSamsungPay: niSDK.makeSamsungPay,
                  // savedCard: widget.savedCard,
                  // savedCards: widget.savedCards,
                  // onSelectCard: widget.onSelectSavedCard,
                  // onDeleteSavedCard: widget.onDeleteSavedCard,
                  // onPaySavedCard: widget.onPaySavedCard,
                ),
              ),
            // if (widget.state != MainViewModelStateType.INIT) _buildStateWidget(),
          ],
        ),
      ),
    );
  }

  // Widget _buildStateWidget() {
  //   switch (widget.state) {
  //     case MainViewModelStateType.LOADING:
  //       return CircularProgressIndicator();
  //     case MainViewModelStateType.PAYMENT_SUCCESS:
  //     case MainViewModelStateType.ERROR:
  //     case MainViewModelStateType.PAYMENT_POST_AUTH_REVIEW:
  //     case MainViewModelStateType.PAYMENT_FAILED:
  //     case MainViewModelStateType.PAYMENT_PARTIAL_AUTH_DECLINED:
  //     case MainViewModelStateType.PAYMENT_PARTIAL_AUTH_DECLINE_FAILED:
  //     case MainViewModelStateType.PAYMENT_CANCELLED:
  //     case MainViewModelStateType.PAYMENT_PARTIALLY_AUTHORISED:
  //     case MainViewModelStateType.AUTHORIZED:
  //       final alertMessage = getAlertMessage(widget.state, widget.message);
  //       return AlertDialog(
  //         title: Text(alertMessage.title),
  //         content: Text(alertMessage.message),
  //         actions: [
  //           TextButton(
  //             onPressed: widget.closeDialog,
  //             child: const Text("OK"),
  //           ),
  //         ],
  //       );
  //     case MainViewModelStateType.PAYMENT_PROCESSING:
  //       return const SizedBox.shrink();
  //     default:
  //       return const SizedBox.shrink();
  //   }
  // }
}
