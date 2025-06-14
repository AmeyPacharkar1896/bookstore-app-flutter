// import 'package:flutter/material.dart';

// class ReviewCard extends StatelessWidget {
//   const ReviewCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// Widget _buildReviewCard(
//     BuildContext context, {
//     required String reviewer,
//     required String comment,
//     required int rating,
//   }) {
//     final textTheme = Theme.of(context).textTheme;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppTheme.lightMistGrey,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(reviewer, style: textTheme.titleMedium),
//           const SizedBox(height: 4),
//           Row(
//             children: List.generate(
//               rating,
//               (index) => const Icon(Icons.star, size: 16, color: Colors.amber),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(comment, style: textTheme.bodyLarge),
//         ],
//       ),
//     );
//   }
// }
