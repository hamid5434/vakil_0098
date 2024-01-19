import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakil_0098/data/services/local_service.dart';
import 'package:vakil_0098/screen/widgets/error/app_error_widget.dart';

import '../../common/common.dart';
import '../../data/repositoreis/legal/legal_repository.dart';
import '../../data/sources/legal/legal_data_source.dart';
import '../../model/legal/legal_child_model.dart';
import '../../model/legal/legal_header_model.dart';
import '../../model/legal/legal_madeh_model.dart';
import '../../model/legal/legal_model.dart';
import '../widgets/app_bar/custom_appbar.dart';
import '../widgets/back_ground/background_img.dart';
import 'bloc/legal_header_bloc.dart';
import 'legal_header_text_screen.dart';

class LegalChildScreen extends StatefulWidget {
  LegalChildScreen(
      {super.key, required this.headerModel, required this.legalsModel});

  final LegalHeaderModel headerModel;
  final LegalsModel legalsModel;

  @override
  State<LegalChildScreen> createState() => _LegalChildScreenState();
}

class _LegalChildScreenState extends State<LegalChildScreen> {
  late final LegalHeaderBloc bloc;

  ValueNotifier<LegalChildModel?> selectedChildNotifier = ValueNotifier(null);
  ValueNotifier<LegalMadehModel?> selectedMadehNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => LegalRepository(
        dataSource: LegalDataSource(
          service: LocalService(),
        ),
      ),
      child: BlocProvider<LegalHeaderBloc>(
        create: (context) {
          bloc = LegalHeaderBloc(repository: context.read<LegalRepository>())
            ..add(
                LegalChildsGetEvent(legalId: widget.legalsModel.id.toString()));
          return bloc;
        },
        child: BlocListener<LegalHeaderBloc, LegalHeaderState>(
          listener: (context, state) {
            if (state is LegalChildGetFailed) {
              Common.showToast(
                  msg: state.exception.message,
                  context: context,
                  type: 'error');
            } else if (state is LegalChildGetSuccess) {
              // Common.showToast(msg: 'ok', context: context);
              if (state.listLegalChild.isEmpty) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LegalHeaderTextScreen(
                      legalsModel: widget.legalsModel,
                      headerModel: widget.headerModel,
                    ),
                  ),
                );
              } else {
                bloc.add(LegalMadehGetEvent(legalnumber: state.id.toString()));
                if(selectedChildNotifier.value == null){
                  bloc.add(LegalChildSelectedEvent(id: state.id));
                  selectedChildNotifier.value = state.listLegalChild[0];
                }
              }
            }
            else if(state is LegalMadehGetSuccess){
              if( selectedMadehNotifier.value == null){
                bloc.add(LegalMadehSelectedEvent(id: state.id));
                selectedMadehNotifier.value = state.listMadeh[0];
              }

            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  const BackgroundImg(),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.pink,
                                    ),
                                    Text(
                                      widget.headerModel.title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.pink,
                                    ),
                                    Text(
                                      widget.legalsModel.title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(),
                                    ),
                                  ],
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: selectedChildNotifier,
                                builder: (context, value, child) {
                                  if (selectedChildNotifier.value != null) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                            color: Colors.pink,
                                          ),
                                          Text(
                                            selectedChildNotifier.value!.title!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: selectedMadehNotifier,
                                builder: (context, value, child) {
                                  if (selectedMadehNotifier.value != null) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                            color: Colors.pink,
                                          ),
                                          Text(
                                            'ماده ${selectedMadehNotifier.value!.legalID!}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        legalChild(),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          width: MediaQuery.of(context).size.width,
                          height: .8,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        legalMadeh(),
                        Expanded(
                          child: ValueListenableBuilder(
                            valueListenable: selectedMadehNotifier,
                            builder: (context, value, child) {
                              if (selectedMadehNotifier.value == null) {
                                return const SizedBox();
                              }
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: Text(
                                    selectedMadehNotifier.value!.legalContent!),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomAppBar(
                      title: 'مجموع قوانین',
                      btnIcon1: CupertinoIcons.search,
                      btnCallback1: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget legalChild() {
    return SizedBox(
      height: 45,
      // color: Colors.amber,
      child: BlocBuilder<LegalHeaderBloc, LegalHeaderState>(
        buildWhen: (previous, current) {
          return current is LegalChildGetLoading ||
              current is LegalChildGetSuccess ||
              current is LegalChildGetFailed;
        },
        builder: (context, state) {
          if (state is LegalChildGetLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LegalChildGetSuccess) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.listLegalChild.length,
              itemBuilder: (context, index) {
                LegalChildModel item = state.listLegalChild[index];
                return Container(
                  //width: 120,
                  height: 45,
                  constraints: const BoxConstraints(minWidth: 80),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                  decoration: BoxDecoration(
                    color: item.selected
                        ? Colors.pink.shade600
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: .5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      bloc.add(LegalChildSelectedEvent(id: item.id));
                      selectedChildNotifier.value = item;
                      selectedMadehNotifier.value = null;
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          item.title!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: item.selected
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is LegalChildGetFailed) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.exception.message,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      bloc.add(LegalChildsGetEvent(
                          legalId: widget.legalsModel.id.toString()));
                    },
                    child: const Text('بروز خطا'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget legalMadeh() {
    return SizedBox(
      height: 45,
      // color: Colors.amber,
      child: BlocBuilder<LegalHeaderBloc, LegalHeaderState>(
        buildWhen: (previous, current) {
          return current is LegalMadehGetLoading ||
              current is LegalMadehGetSuccess ||
              current is LegalMadehGetFailed;
        },
        builder: (context, state) {
          if (state is LegalMadehGetLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LegalMadehGetSuccess) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.listMadeh.length,
              itemBuilder: (context, index) {
                LegalMadehModel item = state.listMadeh[index];
                return Container(
                  //width: 120,
                  height: 45,
                  constraints: const BoxConstraints(minWidth: 80),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                  decoration: BoxDecoration(
                    color: item.selected
                        ? Colors.pink.shade600
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: .5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      bloc.add(LegalMadehSelectedEvent(id: item.id));
                      selectedMadehNotifier.value = item;
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'ماده ${item.legalID!}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: item.selected
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is LegalMadehGetFailed) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.exception.message,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      bloc.add(LegalChildsGetEvent(
                          legalId: widget.legalsModel.id.toString()));
                    },
                    child: const Text('بروز خطا'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
