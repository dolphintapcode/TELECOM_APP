// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Vector1.svg
  String get vector1 => 'assets/icons/Vector1.svg';

  /// File path: assets/icons/appstore.png
  AssetGenImage get appstore =>
      const AssetGenImage('assets/icons/appstore.png');

  /// File path: assets/icons/capcut.png
  AssetGenImage get capcut => const AssetGenImage('assets/icons/capcut.png');

  /// File path: assets/icons/chplay.png
  AssetGenImage get chplay => const AssetGenImage('assets/icons/chplay.png');

  /// File path: assets/icons/danh bạ.svg
  String get danhB => 'assets/icons/danh bạ.svg';

  /// File path: assets/icons/dataon_logo.png
  AssetGenImage get dataonLogo =>
      const AssetGenImage('assets/icons/dataon_logo.png');

  /// File path: assets/icons/duolingo.png
  AssetGenImage get duolingo =>
      const AssetGenImage('assets/icons/duolingo.png');

  /// File path: assets/icons/face1.png
  AssetGenImage get face1 => const AssetGenImage('assets/icons/face1.png');

  /// File path: assets/icons/game.png
  AssetGenImage get game => const AssetGenImage('assets/icons/game.png');

  /// File path: assets/icons/ggdrive.png
  AssetGenImage get ggdrive => const AssetGenImage('assets/icons/ggdrive.png');

  /// File path: assets/icons/grab.png
  AssetGenImage get grab => const AssetGenImage('assets/icons/grab.png');

  /// File path: assets/icons/instar.png
  AssetGenImage get instar => const AssetGenImage('assets/icons/instar.png');

  /// File path: assets/icons/luugiu.png
  AssetGenImage get luugiu => const AssetGenImage('assets/icons/luugiu.png');

  /// File path: assets/icons/mxh.png
  AssetGenImage get mxh => const AssetGenImage('assets/icons/mxh.png');

  /// File path: assets/icons/sao.png
  AssetGenImage get sao => const AssetGenImage('assets/icons/sao.png');

  /// File path: assets/icons/shoppy.png
  AssetGenImage get shoppy => const AssetGenImage('assets/icons/shoppy.png');

  /// File path: assets/icons/tiktok.png
  AssetGenImage get tiktok => const AssetGenImage('assets/icons/tiktok.png');

  /// File path: assets/icons/vector.svg
  String get vector => 'assets/icons/vector.svg';

  /// File path: assets/icons/vn.png
  AssetGenImage get vn => const AssetGenImage('assets/icons/vn.png');

  /// File path: assets/icons/youtube1.png
  AssetGenImage get youtube1 =>
      const AssetGenImage('assets/icons/youtube1.png');

  /// File path: assets/icons/zalo.png
  AssetGenImage get zalo => const AssetGenImage('assets/icons/zalo.png');

  /// File path: assets/icons/zoom.png
  AssetGenImage get zoom => const AssetGenImage('assets/icons/zoom.png');

  /// List of all assets
  List<dynamic> get values => [
    vector1,
    appstore,
    capcut,
    chplay,
    danhB,
    dataonLogo,
    duolingo,
    face1,
    game,
    ggdrive,
    grab,
    instar,
    luugiu,
    mxh,
    sao,
    shoppy,
    tiktok,
    vector,
    vn,
    youtube1,
    zalo,
    zoom,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/amico.svg
  String get amico => 'assets/images/amico.svg';

  /// File path: assets/images/banner1.png
  AssetGenImage get banner1 => const AssetGenImage('assets/images/banner1.png');

  /// File path: assets/images/banner2.png
  AssetGenImage get banner2 => const AssetGenImage('assets/images/banner2.png');

  /// File path: assets/images/banner3.png
  AssetGenImage get banner3 => const AssetGenImage('assets/images/banner3.png');

  /// File path: assets/images/facebook.png
  AssetGenImage get facebook =>
      const AssetGenImage('assets/images/facebook.png');

  /// File path: assets/images/gift.svg
  String get gift => 'assets/images/gift.svg';

  /// File path: assets/images/home.png
  AssetGenImage get home => const AssetGenImage('assets/images/home.png');

  /// File path: assets/images/notification.svg
  String get notification => 'assets/images/notification.svg';

  /// File path: assets/images/youtube.png
  AssetGenImage get youtube => const AssetGenImage('assets/images/youtube.png');

  /// List of all assets
  List<dynamic> get values => [
    amico,
    banner1,
    banner2,
    banner3,
    facebook,
    gift,
    home,
    notification,
    youtube,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
