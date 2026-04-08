// Định nghĩa danh sách 10 app "quốc dân" để dùng chung
import 'package:telecom_app/gen/assets.gen.dart';
import 'package:telecom_app/views/home/package_model.dart';

final List<AppItemModel> fullAppCombo = [
  AppItemModel(name: "Zalo", developer: "Zalo Group", icon: Assets.icons.zalo),
  AppItemModel(name: "Instagram", developer: "Meta", icon: Assets.icons.instar),
  AppItemModel(
    name: "Google Drive",
    developer: "Google",
    icon: Assets.icons.ggdrive,
  ),
  AppItemModel(
    name: "Google Play",
    developer: "Google",
    icon: Assets.icons.chplay,
  ),
  AppItemModel(name: "Grab", developer: "Grab.com", icon: Assets.icons.grab),
  AppItemModel(
    name: "Shopee",
    developer: "Shopee Company Limited",
    icon: Assets.icons.shoppy,
  ),
  AppItemModel(
    name: "Zoom",
    developer: "Zoom Video Communication,Inc.",
    icon: Assets.icons.chplay,
  ),
  AppItemModel(
    name: "App Store",
    developer: "Apple",
    icon: Assets.icons.appstore,
  ),
  AppItemModel(
    name: "Capcut",
    developer: "Bytedance Pre.Ltd,",
    icon: Assets.icons.capcut,
  ),
  AppItemModel(
    name: "Duolingo",
    developer: "Duolingo",
    icon: Assets.icons.duolingo,
  ),
];
