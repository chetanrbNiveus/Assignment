import 'dart:async';

import 'package:assignment/presentation/utils/custom_print.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../core/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((connectivityResult) {
          if(connectivityResult == ConnectivityResult.wifi){
            customPrint.myCustomPrint('WiFi connected');
            emitInternetConnected(ConnectionType.wifi, 'wifi', Icons.wifi);
          }
          else if(connectivityResult == ConnectivityResult.mobile){
            customPrint.myCustomPrint('Mobile internet connected');
            emitInternetConnected(ConnectionType.mobile, 'mobile', Icons.signal_cellular_alt);
          }
          else if(connectivityResult == ConnectivityResult.none){
            customPrint.myCustomPrint('Internet disconnected');
            emitInternetDisconnected('none', Icons.signal_wifi_bad);
          }
        });
  }

  void firstCheck() async{
    final connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.wifi){
      customPrint.myCustomPrint('WiFi connected');
      emitInternetConnected(ConnectionType.wifi, 'wifi', Icons.wifi);
    }
    else if(connectivityResult == ConnectivityResult.mobile){
      customPrint.myCustomPrint('Mobile internet connected');
      emitInternetConnected(ConnectionType.mobile, 'mobile', Icons.signal_cellular_alt);
    }
    else if(connectivityResult == ConnectivityResult.none){
      customPrint.myCustomPrint('Internet disconnected');
      emitInternetDisconnected('none', Icons.signal_wifi_bad);
    }
  }


  void emitInternetConnected(ConnectionType _connectionType, String _connectionStatus, IconData _connectionStatusIcon) {
    emit(InternetConnected(connectionType: _connectionType, connectionState: _connectionStatus, connectionStateIcon: _connectionStatusIcon));
  }

  void emitInternetDisconnected(String _connectionStatus, IconData _connectionStatusIcon) {
    emit(InternetDisconnected(connectionState: _connectionStatus, connectionStateIcon: _connectionStatusIcon));
  }

  @override
  Future<void> close() {
    // TODO: implement close
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
