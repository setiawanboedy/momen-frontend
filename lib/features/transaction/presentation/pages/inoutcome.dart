import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:momen/features/transaction/domain/usecase/update_transaction.dart';
import 'package:momen/features/transaction/presentation/updatecubit/transaction_update_cubit.dart';
import 'package:momen/utils/currency_format.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../resources/dimens.dart';
import '../../../../resources/palette.dart';
import '../../../../routes/app_route.dart';
import '../../../../utils/ext/context.dart';
import '../../../../widgets/parent.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecase/post_transaction.dart';
import '../postcubit/transaction_cubit.dart';
import '../updatecubit/transaction_update_state.dart';

class InOutCome extends StatefulWidget {
  const InOutCome({Key? key}) : super(key: key);

  @override
  State<InOutCome> createState() => _InOutComeState();
}

class _InOutComeState extends State<InOutCome> {
  final _keyForm = GlobalKey<FormState>();
  final _categories = [
    "Pemasukan",
    "Transportasi",
    "Makanan dan Minuman",
    "Pulsa",
    "Kuota",
    "Hutang",
    "Listrik",
    "Belanja",
  ];
  String _category = "Pemasukan";

  // ignore: unused_field
  String _amount = "";
  String _description = "";

  TextEditingController? _controlDesc;
  TextEditingController? _controlAmount;

  Transaction? trans;

  @override
  Widget build(BuildContext context) {
    trans = context.argsData() as Transaction?;
    _amount = "${trans?.data?.amount?.abs()}";
    _description = "${trans?.data?.description}";
    _controlDesc = trans?.data?.description != null
        ? TextEditingController(text: _description)
        : TextEditingController();
    _controlAmount = trans?.data?.description != null
        ? TextEditingController(
            text: CurrencyFormat.convertToIdr(trans?.data?.amount?.abs(), 0),
          )
        : TextEditingController();

    return Parent(
      backgroundColor: Palette.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            context.goToReplace(AppRoute.mainScreen);
          },
          child: const Icon(Icons.arrow_back),
        ),
        actions: [
          BlocListener<TransactionUpdateCubit, TransactionUpdateState>(
            listener: (context, update) {
              if (update.status == TransUpdateStatus.success) {
                context.goTo(AppRoute.mainScreen);
              }
            },
            child: BlocListener<TransactionCubit, TransactionState>(
              listener: (context, create) {
                if (create.status == TransStatus.success) {
                  context.goTo(AppRoute.mainScreen);
                }
              },
              child: InkWell(
                borderRadius: BorderRadius.circular(Dimens.space16),
                onTap: () {
                  if (_keyForm.currentState?.validate() ?? false) {
                    if (trans?.data?.id == null) {
                      context.read<TransactionCubit>().createTransaction(
                            TransactionParams(
                              description: _controlDesc?.text ?? "",
                              category: _category,
                              amount: (_category != "Pemasukan" &&
                                      _category != "Hutang")
                                  ? int.tryParse("-${_controlAmount?.text}") ??
                                      0
                                  : int.tryParse(_controlAmount?.text ?? "") ??
                                      0,
                            ),
                          );
                    } else {
                      context
                          .read<TransactionUpdateCubit>()
                          .updateTransactionID(
                            TransactionUpdateParams(
                              transID: trans?.data?.id,
                              description: _controlDesc?.text ?? "",
                              category: _category,
                              amount: (_category != "Pemasukan" &&
                                      _category != "Hutang")
                                  ? int.tryParse("-${_controlAmount?.text}") ??
                                      0
                                  : int.tryParse(_controlAmount?.text ?? "") ??
                                      0,
                            ),
                          );
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(Dimens.space16),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Center(
          child: Text(
            "Tambah Transaksi",
            style: TextStyle(
              color: Palette.greenText,
            ),
          ),
        ),
        backgroundColor: Palette.bgColor,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Dimens.space16),
        child: Form(
          key: _keyForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),

              const Text(
                "Kategori",
                style: TextStyle(
                  color: Palette.greenText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    isEmpty: _category == "",
                    child: DropdownWidget(
                      items: _categories,
                      itemCallBack: (String item) {
                        _category = item;
                      },
                      currentItem: trans?.data?.category ?? "Pemasukan",
                    ),
                  );
                },
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // const Text(
              //   "Tanggal",
              //   style: TextStyle(
              //     color: Palette.greenText,
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // const TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "Hari/Bulan/Tahun",
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Jumlah",
                style: TextStyle(
                  color: Palette.greenText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _controlAmount,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Rp",
                ),
                inputFormatters: [
                  ThousandsFormatter(formatter: NumberFormat.decimalPattern("id"))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Catatan",
                style: TextStyle(
                  color: Palette.greenText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: TextField(
                  controller: _controlDesc,
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Keterangan",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownWidget extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> itemCallBack;
  final String currentItem;

  const DropdownWidget({
    Key? key,
    required this.items,
    required this.itemCallBack,
    required this.currentItem,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _DropdownState(currentItem);
}

class _DropdownState extends State<DropdownWidget> {
  List<DropdownMenuItem<String>> dropDownItems = [];
  String currentItem;

  _DropdownState(this.currentItem);

  @override
  void initState() {
    super.initState();
    for (String item in widget.items) {
      dropDownItems.add(DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ));
    }
  }

  @override
  void didUpdateWidget(DropdownWidget oldWidget) {
    if (currentItem != widget.currentItem) {
      setState(() {
        currentItem = widget.currentItem;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: currentItem,
        isExpanded: true,
        items: dropDownItems,
        onChanged: (String? selectedItem) => setState(() {
          currentItem = selectedItem ?? "";
          widget.itemCallBack(currentItem);
        }),
      ),
    );
  }
}
