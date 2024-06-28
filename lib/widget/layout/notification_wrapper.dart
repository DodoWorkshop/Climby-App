import 'package:climby/bloc/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationWrapper extends StatelessWidget {
  final Widget child;

  const NotificationWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, BlocNotification?>(
      listener: (context, notification) => {
        if (notification != null)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    notification.leadingIcon != null
                        ? Icon(notification.leadingIcon!)
                        : Container(),
                    notification.leadingIcon != null
                        ? Container(width: 10)
                        : Container(),
                    Expanded(
                        child: Text(
                      notification.message,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                  ],
                ),
                backgroundColor: notification.color,
              ),
            )
          }
      },
      child: child,
    );
  }
}
