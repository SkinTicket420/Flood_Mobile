import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Components/torrent_tile.dart';
import 'package:flood_mobile/Constants/AppColor.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TorrentScreen extends StatefulWidget {
  @override
  _TorrentScreenState createState() => _TorrentScreenState();
}

class _TorrentScreenState extends State<TorrentScreen> {
  TextEditingController searchTextEditingController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
    return Consumer<HomeProvider>(
      builder: (context, model, child) {
        return KeyboardDismissOnTap(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColor.primaryColor,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: wp * 0.15,
                      left: wp * 0.15,
                      top: hp * 0.01,
                      bottom: hp * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_upward_rounded,
                            color: AppColor.greenAccentColor,
                            size: wp * 0.07,
                          ),
                          Text(
                            model.upSpeed,
                            style: TextStyle(
                              color: AppColor.greenAccentColor,
                              fontSize: wp * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_downward_rounded,
                            color: AppColor.blueAccentColor,
                            size: wp * 0.07,
                          ),
                          Text(
                            model.downSpeed,
                            style: TextStyle(
                              color: AppColor.blueAccentColor,
                              fontSize: wp * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: wp * 0.05,
                      right: wp * 0.05,
                      top: hp * 0.01,
                      bottom: hp * 0.02),
                  child: TextField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Search Torrent',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: TorrentApi.getAllTorrents(context: context),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<TorrentModel>> snapshot) {
                      return (snapshot.hasData && snapshot.data.length != 0)
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data[index].name.contains(
                                    searchTextEditingController.text)) {
                                  return TorrentTile(
                                      model: snapshot.data[index]);
                                }
                                return Container();
                              },
                            )
                          : Center(
                              child: SvgPicture.asset(
                                'assets/images/empty_dark.svg',
                                width: 120,
                                height: 120,
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}