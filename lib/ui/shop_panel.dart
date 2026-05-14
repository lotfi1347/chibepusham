import 'package:flutter/material.dart';

import '../data/shop_catalog.dart';
import '../state/shop_state.dart';
import '../services/payment_service.dart';

class ShopPanel extends StatelessWidget {
  final ShopState shopState;

  const ShopPanel({
    super.key,
    required this.shopState,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shopItems.length,
      itemBuilder: (context, index) {
        final item = shopItems[index];

        final isOwned = shopState.isOwned(item.id);

        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset(
              item.asset,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),

            title: Text(item.name),

            subtitle: Text(
              item.isPremium
                  ? "💰 Premium Item"
                  : "🆓 Free Item",
            ),

            trailing: isOwned
                ? const Text(
                    "OWNED",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      final payment = PaymentService();

                      try {
                        await payment.payForItem(
                          itemId: item.id,
                          price: item.price,
                        );

                        shopState.unlock(item.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Purchase successful! 🎉"),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Payment failed: $e"),
                          ),
                        );
                      }
                    },
                    child: Text(
                      item.price == 0
                          ? "FREE"
                          : "BUY ${item.price}",
                    ),
                  ),
          ),
        );
      },
    );
  }
}