import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shab/src/core/widgets/switch_button.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/snack_widget.dart';
import '../../../core/widgets/tab_widget.dart';
import '../../../core/widgets/txt_field.dart';
import '../../internet/bloc/internet_bloc.dart';
import '../../internet/widgets/no_internet.dart';
import '../../settings/screens/settings_screen.dart';
import '../widgets/home_appbar.dart';
import '../widgets/nav_bar.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routePath = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showPaywall = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppbar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 62 + MediaQuery.of(context).viewPadding.bottom,
            ),
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                logger(state.runtimeType);
              },
              buildWhen: (previous, current) {
                return previous.runtimeType != current.runtimeType;
              },
              builder: (context, state) {
                int index = state is HomeInitial ? 0 : 1;

                return IndexedStack(
                  index: index,
                  children: const [
                    _Home(),
                    SettingsScreen(),
                  ],
                );
              },
            ),
          ),
          const NavBar(),
        ],
      ),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home();

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  final controller = TextEditingController();

  bool isActive = false;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabWidget(
      titles: const ['Aaa', 'Bbb'],
      pages: [
        BlocBuilder<InternetBloc, bool>(
          builder: (context, hasConnection) {
            return hasConnection
                ? ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      TxtField(
                        controller: controller,
                        hintText: 'Xyz',
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 16),
                      MainButton(
                        title: 'Show Dialog',
                        active: controller.text.isNotEmpty,
                        onPressed: () {
                          DialogWidget.show(
                            context,
                            title: controller.text,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      MainButton(
                        title: 'Show Snackbar',
                        active: controller.text.isNotEmpty,
                        onPressed: () {
                          SnackWidget.show(
                            context,
                            message: 'Snack title',
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      SwitchButton(
                        isActive: isActive,
                        onPressed: () {
                          setState(() {
                            isActive = !isActive;
                          });
                        },
                      ),
                    ],
                  )
                : const NoInternet();
          },
        ),
        const Center(
          child: Text('2'),
        ),
      ],
    );
  }
}
