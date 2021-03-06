import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momen/core/usecase/usecase.dart';
import 'package:momen/di/di.dart';
import 'package:momen/features/auth/data/datasources/local/auth_pref_manager.dart';
import 'package:momen/features/transaction/presentation/getcubit/transaction_list_cubit.dart';
import 'package:momen/routes/app_route.dart';
import 'package:momen/utils/common.dart';
import 'package:momen/utils/ext/context.dart';
import 'package:momen/widgets/parent.dart';

class LoadFromApi extends StatefulWidget {
  const LoadFromApi({Key? key}) : super(key: key);

  @override
  State<LoadFromApi> createState() => _LoadFromApiState();
}

class _LoadFromApiState extends State<LoadFromApi> {
  @override
  void initState() {
    _loadFromApi();
    super.initState();
  }

  _loadFromApi() {
    context.read<TransactionListCubit>().loadFromAPI(NoParams());

    log.e("load data init");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionListCubit, TransactionListState>(
      listener: (context, state) {
        if(state.status == TransListStatus.success){
          context.goTo(AppRoute.mainScreen);
        sl<AuthPrefManager>().loadTrans = true;
        }
      },
      child: const Parent(
        child: Center(
            child: Text(
                "Load data dari server \n pastikan anda terkoneksi internet...")),
      ),
    );
  }
}
