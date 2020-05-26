
/*
Error
{
    "error": true,
    "data": null,
    "errors": [
        {
            "code": 1029,
            "message": "User not found!."
        }
    ]
}
 */

import 'base_response.dart';

class ErrorResponse extends BaseResponse {
  ErrorResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  Map<String, dynamic> toJson() {
    return {
      ... super.toJson()
    };
  }

  @override
  Map<String, dynamic> dataToJson(data) {
    return null;
  }

  @override
  jsonToData(Map<String, dynamic> fullJson) {
    return null;
  }

  // How to use
  // if (error is DioError && error.type == DioErrorType.RESPONSE) {
  //    final res = error.response;
  //    final errorObject = ErrorResponse(res.data);
  //    mainBloc.showAlertDialog(
  //          errorObject.getFirstErrorMessage().message);
  // } else {
  //    mainBloc.showAlertDialog(error.toString());
  // }
  BaseError getFirstErrorMessage() {
    if(error) {
      if(errors.length == 0) {
        return BaseError(code: -1, message: "Has error but empty message");
      } else {
        return errors[0];
      }
    }
    return BaseError(code: -1, message: "Error not found");
  }
}
