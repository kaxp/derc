import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

mixin AppImages {
  static const String _IMAGES_FOLDER_PATH = 'assets/images/';

  static const String _icBlog = _IMAGES_FOLDER_PATH + 'il_activity_blog.svg';
  static const String _icSomethingWentWrong =
      _IMAGES_FOLDER_PATH + 'il_activity_something_wrong.svg';
  static const String _icDataSearch = _IMAGES_FOLDER_PATH + 'il_data_find.svg';
  static const String _icSuccess =
      _IMAGES_FOLDER_PATH + 'il_message_success.svg';
  static const String _icDataNotFound =
      _IMAGES_FOLDER_PATH + 'il_pfa_activity_data_bank_not_found.svg';
  static const String _icRocket = _IMAGES_FOLDER_PATH + 'il_rocket_point.svg';

  static const _appLogo = 'assets/images/logo.png';
  static const _errorPlaceholder = 'assets/images/error.png';

  static Image icErrorPlaceholder(
          {required double height, required double widget}) =>
      Image(
        height: height,
        width: widget,
        fit: BoxFit.cover,
        image: const AssetImage(
          _errorPlaceholder,
        ),
      );

  static Image icAppLogo({required double height, required double widget}) =>
      Image(
        width: widget,
        height: height,
        image: const AssetImage(
          _appLogo,
        ),
      );

  static SvgPicture icBlog() => SvgPicture.asset(_icBlog);
  static SvgPicture icSomethingWentWrong() =>
      SvgPicture.asset(_icSomethingWentWrong);

  static SvgPicture icDataSearch({required double height}) => SvgPicture.asset(
        _icDataSearch,
        height: height,
      );

  static SvgPicture icSuccess() => SvgPicture.asset(_icSuccess);

  static SvgPicture icDataNotFound() => SvgPicture.asset(_icDataNotFound);

  static SvgPicture icRocket() => SvgPicture.asset(_icRocket);
}
