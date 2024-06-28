import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationBlocEvent, BlocNotification?> {
  NotificationBloc() : super(null) {
    on<_SendNotificationEvent>(_handleSendNotification);
  }

  void _handleSendNotification(
      _SendNotificationEvent event, Emitter<BlocNotification?> emit) {
    final notification = switch (event) {
      SendSuccessNotificationEvent successEvent => BlocNotification(
          message: successEvent.message,
          color: Colors.greenAccent,
          leadingIcon: successEvent.leadingIcon,
        ),
      SendInfoNotificationEvent infoEvent => BlocNotification(
          message: infoEvent.message,
          color: Colors.grey,
          leadingIcon: infoEvent.leadingIcon,
        ),
      SendWarningNotificationEvent warningEvent => BlocNotification(
          message: warningEvent.message,
          color: Colors.orangeAccent,
          leadingIcon: warningEvent.leadingIcon,
        ),
      SendErrorNotificationEvent errorEvent => BlocNotification(
          message: errorEvent.message,
          color: Colors.redAccent,
          leadingIcon: errorEvent.leadingIcon,
        ),
    };

    emit(notification);
  }
}

sealed class NotificationBlocEvent {}

sealed class _SendNotificationEvent extends NotificationBlocEvent {
  final String message;
  final IconData? leadingIcon;

  _SendNotificationEvent(this.message, this.leadingIcon);
}

class SendInfoNotificationEvent extends _SendNotificationEvent {
  SendInfoNotificationEvent(String message, {IconData? leadingIcon})
      : super(message, leadingIcon);
}

class SendSuccessNotificationEvent extends _SendNotificationEvent {
  SendSuccessNotificationEvent(String message, {IconData? leadingIcon})
      : super(message, leadingIcon);
}

class SendWarningNotificationEvent extends _SendNotificationEvent {
  SendWarningNotificationEvent(String message, {IconData? leadingIcon})
      : super(message, leadingIcon);
}

class SendErrorNotificationEvent extends _SendNotificationEvent {
  SendErrorNotificationEvent(String message, {IconData? leadingIcon})
      : super(message, leadingIcon);
}

class BlocNotification {
  final String message;
  final Color color;
  final IconData? leadingIcon;

  BlocNotification({
    required this.message,
    required this.color,
    required this.leadingIcon,
  });
}
