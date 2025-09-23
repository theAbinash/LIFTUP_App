import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_log/core/errors/error_cubit.dart';
import 'package:gym_log/core/widgets/error_banner.dart';

class AppScaffold extends StatelessWidget {

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar, 
    this.resizeToAvoidBottomInset = false, 
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Column(
        children: [
          BlocBuilder<ErrorCubit, String?>(
            buildWhen: (prev, next) => prev != next,
            builder: (context, errorMessage){
              if(errorMessage != null){
                return ErrorBanner(
                  message: errorMessage,
                  onDismiss: () => context.read<ErrorCubit>().clearError(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(child: body),
        ],
      ),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

}