import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakil_0098/data/services/local_service.dart';
import 'package:vakil_0098/screen/widgets/error/app_error_widget.dart';

import '../../common/common.dart';
import '../../data/repositoreis/legal/legal_repository.dart';
import '../../data/sources/legal/legal_data_source.dart';
import '../../model/legal/legal_header_model.dart';
import '../../model/legal/legal_model.dart';
import '../widgets/app_bar/custom_appbar.dart';
import '../widgets/back_ground/background_img.dart';
import 'bloc/legal_header_bloc.dart';
import 'legal_child_screen.dart';

class LegalHeaderScreen extends StatefulWidget {
  LegalHeaderScreen({super.key});

  @override
  State<LegalHeaderScreen> createState() => _LegalHeaderScreenState();
}

class _LegalHeaderScreenState extends State<LegalHeaderScreen> {
  late final LegalHeaderBloc bloc;

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
            ..add(LegalHeaderGetEvent());
          return bloc;
        },
        child: BlocListener<LegalHeaderBloc, LegalHeaderState>(
          listener: (context, state) {
            if (state is LegalHeaderGetFailed) {
              Common.showToast(
                  msg: state.exception.message,
                  context: context,
                  type: 'error');
            } else if (state is LegalHeaderGetSuccess) {
              // Common.showToast(msg: 'ok', context: context);
              bloc.add(LegalsGetEvent(headerId: state.id.toString()));
            } else if (state is LegalsGetFailed) {
              Common.showToast(
                  msg: state.exception.message,
                  context: context,
                  type: 'error');
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  const BackgroundImg(),
                  Padding(
                    padding: const EdgeInsets.only(top: 55),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       legalHeader(),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          width: MediaQuery.of(context).size.width,
                          height: .8,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        legals(),
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
                      btnCallback1: () {

                      },
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

  Widget legalHeader() {
    return SizedBox(
      height: 45,
      // color: Colors.amber,
      child: BlocBuilder<LegalHeaderBloc, LegalHeaderState>(
        buildWhen: (previous, current) {
          return current is LegalHeaderGetLoading ||
              current is LegalHeaderGetFailed ||
              current is LegalHeaderGetSuccess;
        },
        builder: (context, state) {
          if (state is LegalHeaderGetLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LegalHeaderGetSuccess) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.listHeader.length,
              itemBuilder: (context, index) {
                LegalHeaderModel item =
                state.listHeader[index];
                return Container(
                  //width: 120,
                  height: 45,
                  constraints:
                  const BoxConstraints(minWidth: 80),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 2, vertical: 3),
                  decoration: BoxDecoration(
                    color: item.selected
                        ? Colors.pink.shade600
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: .5,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      bloc.add(LegalHeaderSelectedEvent(
                          id: item.id));
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10),
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
                                : Theme.of(context)
                                .colorScheme
                                .onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is LegalHeaderGetFailed) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.exception.message,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),
                  const SizedBox(width: 16,),
                  OutlinedButton(
                    onPressed: () {
                      bloc.add(LegalHeaderGetEvent());
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

  Widget legals() {
    return Expanded(
      child: BlocBuilder<LegalHeaderBloc, LegalHeaderState>(
        buildWhen: (previous, current) {
          return current is LegalsGetLoading ||
              current is LegalsGetSuccess ||
              current is LegalsGetFailed;
        },
        builder: (context, state) {
          if (state is LegalsGetLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LegalsGetSuccess) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.listLegals.length,
              itemBuilder: (context, index) {
                LegalsModel item =
                state.listLegals[index];
                return Container(
                  //width: 120,
                  height: 40,
                  constraints:
                  const BoxConstraints(minWidth: 80),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 3, vertical: 0),
                  decoration: BoxDecoration(
                    color: item.selected
                        ? Colors.pink.shade600
                        : Colors.transparent,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: .2,
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LegalChildScreen(
                            headerModel: bloc.selectedHeader!,
                            legalsModel: item,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                color: item.selected
                                    ? Colors.white
                                    : Theme.of(context)
                                    .colorScheme
                                    .onSurface,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.onSurface,
                          size: 19,),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is LegalsGetFailed) {
            return Center(
              child: AppErrorWidget(
                exception: state.exception,
                onTab: () {},
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
