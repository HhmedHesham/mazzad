import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../constants.dart';
import '../utils/size_config.dart';

enum Status { live, scheduled, soon }

class AuctionStatus extends StatelessWidget {
  const AuctionStatus({
    Key? key,
    required this.status,
    this.endDate,
  }) : super(key: key);
  final Status status;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: status == Status.live
            ? Colors.red.withOpacity(0.2)
            : status == Status.scheduled
                ? Colors.green.withOpacity(0.2)
                : Constants.kPrimaryColor.withOpacity(0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          status == Status.live
              ? const CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.red,
                )
              : const SizedBox(),
          status == Status.live
              ? SizedBox(
                  width: getProportionateScreenWidth(5),
                )
              : const SizedBox(),
          status == Status.scheduled
              ? CountdownTimer(
                  endTime: endDate!.millisecondsSinceEpoch + 1000 * 30,
                  widgetBuilder: (_, CurrentRemainingTime? time) {
                    if (time == null) {
                      return const Text('Game over');
                    }
                    return Text(
                      '${time.days}d ${time.hours}h ${time.min}m',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                )
              : const SizedBox(),
          status == Status.live
              ? Text(
                  'Live',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: getProportionateScreenHeight(14),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
