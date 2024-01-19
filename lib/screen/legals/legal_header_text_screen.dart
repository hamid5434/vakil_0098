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

class LegalHeaderTextScreen extends StatefulWidget {
  LegalHeaderTextScreen(
      {super.key, required this.headerModel, required this.legalsModel});

  final LegalHeaderModel headerModel;
  final LegalsModel legalsModel;

  @override
  State<LegalHeaderTextScreen> createState() => _LegalHeaderTextScreenState();
}

class _LegalHeaderTextScreenState extends State<LegalHeaderTextScreen> {
  late final LegalHeaderBloc bloc;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                        child: Text(
                            widget.legalsModel.content!),
                      ),
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
    );
  }

}
