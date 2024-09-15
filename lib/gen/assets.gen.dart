/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  static const AssetGenImage cover = AssetGenImage('assets/cover.png');
  static const AssetGenImage emptyPuzzle =
      AssetGenImage('assets/empty_puzzle.png');
  static const AssetGenImage puzzleImg1 =
      AssetGenImage('assets/puzzle_img_1.jpg');
  static const AssetGenImage puzzleImg2 =
      AssetGenImage('assets/puzzle_img_2.jpg');
  static const AssetGenImage puzzleImg3 =
      AssetGenImage('assets/puzzle_img_3.jpg');
  static const AssetGenImage puzzleImg4 =
      AssetGenImage('assets/puzzle_img_4.jpg');
  static const AssetGenImage puzzleImg5 =
      AssetGenImage('assets/puzzle_img_5.jpg');
  static const AssetGenImage puzzleImg6 =
      AssetGenImage('assets/puzzle_img_6.jpg');
  static const AssetGenImage puzzleImg7 =
      AssetGenImage('assets/puzzle_img_7.jpg');
  static const AssetGenImage puzzleImg8 =
      AssetGenImage('assets/puzzle_img_8.jpg');
  static const AssetGenImage puzzleImg9 =
      AssetGenImage('assets/puzzle_img_9.jpg');

  /// List of all assets
  static List<AssetGenImage> get values => [
        cover,
        emptyPuzzle,
        puzzleImg1,
        puzzleImg2,
        puzzleImg3,
        puzzleImg4,
        puzzleImg5,
        puzzleImg6,
        puzzleImg7,
        puzzleImg8,
        puzzleImg9
      ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
