// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiService implements ApiService {
  _ApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://vcare.integration25.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginResponse> login(LoginRequestBody loginRequestBody) async {
    //_extra: بيانات إضافية للـ request (مش مستخدمة هنا)
    final _extra = <String, dynamic>{};
    //queryParameters: parameters في الـ URL (مثل ?page=1&limit=10)
    final queryParameters = <String, dynamic>{};
    //_headers: رؤوس الطلب (مثل Authorization, Content-Type)
    final _headers = <String, dynamic>{};
    //_data: البيانات اللي هنبعتها في الـ body
    final _data = <String, dynamic>{};
    //بياخد الـ LoginRequestBody ويحوله لـ Map
    //النتيجة تكون مثلاً {"email": "user@example.com", "password": "password"}
    _data.addAll(loginRequestBody.toJson());
    //_dio.fetch<Map<String, dynamic>>: بيعمل HTTP request ويرجع Map
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LoginResponse>(Options(
     //إعدادات الطلب POST
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
    //.compose(...): بيجمع كل الإعدادات مع بعض:
            .compose(
              _dio.options,  //الإعدادات العامة
              'auth/login',  //الـ endpoint
              queryParameters: queryParameters, //parameters في الـ URL
              data: _data, //البيانات اللي هنبعتها في الـ body
            )
            .copyWith(
           //_combineBaseUrls(...): دالة بتجمع الـ base URL مع الـ endpoint
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
            //LoginResponse.fromJson(...): بيحول الـ JSON لـ object من LoginResponse
            //_result.data: البيانات اللي رجعت من الـ API (JSON)
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignupResponse> signup(SignupRequestBody signupRequestBody) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(signupRequestBody.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SignupResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'auth/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SignupResponse.fromJson(_result.data!);
    return value;
  }
  // دالة مساعدة - تحديد نوع الاستجابة
  //بتحدد نوع البيانات المتوقعة من الـ API
  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {

    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
   //لو T == String: البيانات text عادي → ResponseType.plain
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
     //لو غير كده: البيانات JSON → ResponseType.json
     //فايدتها: بتخلي Dio يعرف إزاي يعالج البيانات اللي جاية
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  //دالة مساعدة - دمج الـ URLs
  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    // لو baseUrl مش موجودة أو فاضية: برجع الـ dioBaseUrl
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);
    //لو baseUrl مطلق 
    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
