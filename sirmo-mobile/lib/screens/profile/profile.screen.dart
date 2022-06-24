import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/screens/auth/register/update-profile-image.screen.dart';
import 'package:sirmo/utils/app-util.dart';

import '../../models/user.dart';
import '../../services/user.service.dart';
import '../../utils/app-date.dart';
import '../../utils/color-const.dart';
import '../../utils/network-info.dart';
import 'reset_password.screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserService>().user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        elevation: 0.0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back,
        ),
      ),
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(color: ColorConst.primary),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ClipOval(
                            child: Container(
                              color: Colors.white,
                              child: CachedNetworkImage(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.height * 0.2,
                                fit: BoxFit.cover,
                                httpHeaders: {
                                  "Authorization":
                                      "Bearer ${NetworkInfo.token}",
                                },
                                errorWidget: (context, url, error) {
                                  return Image.asset("assets/logos/logo.png");
                                },
                                imageUrl:
                                    "${NetworkInfo.baseUrl}users/profile/image",
                                placeholder: (context, value) =>
                                    CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.14,
                        left: MediaQuery.of(context).size.width * 0.55,
                        child: buildEditButton(
                          onPressed: () => AppUtil.goToScreen(
                              context, UpdateProfileImageScreen()),
                        )),
                  ],
                ),
              )),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.width * 0.6,
            ),
            child: SizedBox(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: ,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: ColorConst.primary,
                      ),
                      title: Text(
                        user?.prenom ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: ColorConst.primary,
                      ),
                      title: Text(
                        user?.nom ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: ColorConst.primary,
                      ),
                      title: Text(
                        user?.email ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.date_range,
                        color: ColorConst.primary,
                      ),
                      title: Text(
                        user?.date_naiss == null
                            ? "Non précisée"
                            : AppDate.dateFormat.format(user!.date_naiss!),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.call,
                        color: ColorConst.primary,
                      ),
                      title: Text(
                        user?.phone ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        AppUtil.goToScreen(context, ResetPasswordScreen());
                      },
                      leading: const Icon(
                        Icons.lock,
                        color: ColorConst.primary,
                      ),
                      title: const Text(
                        "Mot de passe",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: ColorConst.primary,
                          ),
                          onPressed: () {
                            AppUtil.goToScreen(context, ResetPasswordScreen());
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: buildEditButton(onPressed: () {
                        AppUtil.goToScreen(context, ResetPasswordScreen());
                      }),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildEditButton({required void Function()? onPressed}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConst.primary,
          border: Border.all(color: Colors.white, width: 1.5)),
      child: IconButton(
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
