import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle/authentication/domain/authentication_repository.dart';
import 'package:puzzle/authentication/presentation/login/bloc/authentication_cubit.dart';
import 'package:puzzle/gen/assets.gen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/view/puzzle_list_page.dart';


class UserLoginPage extends StatelessWidget {
  static String route = "/";

  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (context) => AuthenticationCubit(
        context.read<AuthenticationRepository>(),
      ),
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacementNamed(PuzzleListPage.route);
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.cover.image(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                ),
                const SizedBox(height: 16),
                Builder(builder: (context) {
                  return MaterialButton(
                    minWidth: MediaQuery.sizeOf(context).width * 0.5,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    onPressed: () async {
                      await context.read<AuthenticationCubit>().login();
                    },
                    child: Text(AppLocalizations.of(context)!.guest_sign_in),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
