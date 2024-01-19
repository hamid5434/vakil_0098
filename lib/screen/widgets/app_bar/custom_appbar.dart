import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/token/Token.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
      required this.title,
      this.subtitle,
      this.btnIcon1,
      this.btnIcon2,
      this.btnCallback1,
      this.btnCallback2,
      this.backIcon = CupertinoIcons.back,
      this.backgroundColor = Colors.transparent,
      this.position,
      this.backBtnCallback})
      : super(key: key);
  final String title;
  final String? subtitle;
  final IconData? btnIcon1;
  final IconData? btnIcon2;
  final GestureTapCallback? btnCallback1;
  final GestureTapCallback? btnCallback2;
  final GestureTapCallback? backBtnCallback;

  IconData? backIcon;
  final bool? position;

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: .5),
      height: 62,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                onTap: backBtnCallback ??
                    () {
                      Navigator.of(context).pop();
                    },
                borderRadius: BorderRadius.circular(25),
                child: Center(
                  child: Icon(
                    backIcon,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                color: backgroundColor,
                child: Column(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 14),
                    ),
                    subtitle == null
                        ? Text(
                            '${Token.appAuthModel!.user![0].firstName!}-'
                            '${Token.appAuthModel!.user![0].lastName!}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 12,
                                    ),
                          )
                        : Text(
                            subtitle!,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 12,
                                    ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          btnIcon2 == null
              ? Container()
              : Container(
                  width: 37,
                  height: 37,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    child: InkWell(
                      onTap: btnCallback2,
                      borderRadius: BorderRadius.circular(25),
                      child: Center(
                        child: Icon(
                          btnIcon2,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
          const SizedBox(width: 8),
          btnIcon1 == null
              ? Container()
              : Container(
                  width: 37,
                  height: 37,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    child: InkWell(
                      onTap: btnCallback1,
                      borderRadius: BorderRadius.circular(25),
                      child: Center(
                        child: Icon(
                          btnIcon1,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0);
}
