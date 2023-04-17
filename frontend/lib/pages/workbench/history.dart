import 'package:flutter/material.dart';

import '/third_party/third_party.dart';
import '/store/store.dart';

class History extends HookConsumerWidget {
  const History({super.key});

  static const double _sidePadding = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);

    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: _sidePadding),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search',
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: _sidePadding),
                    height: 64,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              imageUrl: history[index].thumbnailUrl,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            ),
                          ),
                          const SizedBox(width: _sidePadding),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    history[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: _sidePadding),
                                  Text(
                                    history[index].url,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
