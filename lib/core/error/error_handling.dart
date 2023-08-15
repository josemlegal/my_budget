// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as f;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

const ERROR_NETWORK = 'network-request-failed';
const ERROR_UNKNOWN = 'ERROR_UNKNOWN';
const ERROR_OBJECT_NOT_FOUND = 'object-not-found';
const ERROR_BUCKET_NOT_FOUND = 'bucket-not-found';
const ERROR_PROJECT_NOT_FOUND = 'project-not-found';
const ERROR_QUOTA_EXCEEDED = 'quota_exceeded';
const ERROR_NOT_AUTHENTICATED = 'not-authenticated';
const ERROR_NOT_AUTHORIZED = 'not-authorized';
const ERROR_RETRY_LIMIT_EXCEEDED = 'retry-limit-exceeded';
const ERROR_INVALID_CHECKSUM = 'invalid-checksum';
const ERROR_CANCELED = 'canceled';
const CLAIMS_TOO_LARGE = 'claims-too-large';
const ErrorCodeNetworkError = 'network-error';
const ErrorCodeUserTokenExpired = 'user-token-expired';
const ErrorCodeInvalidAPIKey = 'invalid-api-key';
const ErrorCodeAppNotAuthorized = 'app-not-authorized';
const ErrorCodeKeychainError = 'keychain-error';
const ErrorCodeInternalError = 'internal-error';
const ErrorCodeInvalidCredential = 'invalid-credential';
const ErrorCodeWeakPassword = 'weak-password';
const ERROR_INVALID_EMAIL = 'invalid-email';
const ERROR_WRONG_PASSWORD = 'wrong-password';
const ERROR_USER_NOT_FOUND = 'user-not-found';
const ERROR_USER_DISABLED = 'user-disabled';
const ERROR_TOO_MANY_REQUESTS = 'too-many-requests';
const ERROR_OPERATION_NOT_ALLOWED = 'operation-not-allowed';
const ERROR_EMAIL_ALREADY_IN_USE = 'email-already-in-use';
const CANCELLED_PURCHASED_ERROR_TYPE = 'payment-cancelled';
const BARCODE_NOT_FOUND = 'barcode-not-found';

class CustomErrorHandler {
  static CustomError fromGenericError({
    stack,
    String? devMessage,
    String message = "Ha ocurrido un error, intentelo mas tarde.",
    required String errorCode,
    required String errorType,
  }) {
    return CustomError(
      message: message,
      errorCode: errorCode,
      errorType: errorType,
      stackTrace: stack,
      devMessage: devMessage,
    );
  }

  static CustomError fromDioError(DioException error) {
    String errorMessage;
    switch (error.type) {
      case DioExceptionType.cancel:
        errorMessage = 'Cancelaste la operacion';
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Tiempo de conexion agotado';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'Ocurrio un error, intente mas tarde';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Tiempo de recepcion agotado';
        break;
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            errorMessage = 'Error en la peticion';
            break;
          case 401:
            errorMessage = 'No estas autorizado para realizar esta accion';
            break;
          case 403:
            errorMessage = 'No tienes permiso para realizar esta accion';
            break;
          case 404:
            errorMessage = 'No se encontro el recurso';
            break;
          case 405:
            errorMessage = 'Metodo no permitido';
            break;
          case 500:
            errorMessage = 'Ocurrio un error en el servidor';
            break;
          case 502:
            errorMessage = 'Ocurrio un error en el servidor';
            break;
          case 503:
            errorMessage = 'Ocurrio un error en el servidor';
            break;
          case 504:
            errorMessage = 'Ocurrio un error en el servidor';
            break;
          default:
            errorMessage = 'Ocurrio un error, intente mas tarde';
            break;
        }
        break;

      default:
        errorMessage = 'Ocurrio un error, intente mas tarde';
        break;
    }
    return CustomError(
      errorCode: error.type.name,
      devMessage: 'HTTP ERROR',
      errorType: error.type.name,
      message: errorMessage,
    );
  }

  static CustomError fromFirebaseException(
      f.FirebaseException firestoreException,
      {stack,
      String? devMessage}) {
    String errorMessage;
    switch (firestoreException.code) {
      // --
      case ERROR_OBJECT_NOT_FOUND:
        errorMessage = 'No se ha encontrado ningun registro';
        break;
      // --
      case ERROR_BUCKET_NOT_FOUND:
      case ERROR_PROJECT_NOT_FOUND:
      case ERROR_QUOTA_EXCEEDED:
        errorMessage =
            'Ocurrio un error, por favor reinicie la aplicacion o contacte a soporte';
        break;
      // --
      case ERROR_NOT_AUTHENTICATED:
        errorMessage = 'Debes iniciar sesion para continuar';
        break;
      // --
      case ERROR_NOT_AUTHORIZED:
        errorMessage = '';
        break;
      // --
      case ERROR_RETRY_LIMIT_EXCEEDED:
        errorMessage =
            'No se ha podido cargar los resultados, asegurese de tener una conexion a red o reintentelo mas tarde';
        break;
      // --
      case ERROR_CANCELED:
        errorMessage = 'Has cancelado la operacion';
        break;
      // --
      case ErrorCodeNetworkError:
      case ERROR_NETWORK:
        errorMessage =
            'Ocurrio un error con el servidor, asegurese de tener una conexion a internet estable y reintentelo mas tarde';
        break;
      // --
      case ERROR_USER_NOT_FOUND:
        errorMessage = 'Cuenta no encontrada';
        break;
      // --
      case ErrorCodeUserTokenExpired:
        errorMessage = 'Debes volver a iniciar secion para realizar esa accion';
        break;
      // --
      case ERROR_TOO_MANY_REQUESTS:
        errorMessage =
            'Has realizado demasiados intentos. Vuelve a intentarlo más tarde';
        break;
      // --
      case ErrorCodeInvalidAPIKey:
      case ErrorCodeAppNotAuthorized:
        errorMessage =
            'La aplicacion que tienes instalada es ilegal. Por favor instale la original desde la Playstore o Appstore';
        break;
      // --
      case ERROR_INVALID_EMAIL:
        errorMessage = 'El correo electronico que has introducido es invalido';
        break;
      // --
      case ERROR_USER_DISABLED:
        errorMessage =
            'La cuenta con la que has intentando iniciar sesion esta bloqueada';
        break;
      // --
      case ERROR_WRONG_PASSWORD:
        errorMessage = 'La contraseña que has introducido es incorrecta';
        break;
      // --
      case ErrorCodeInvalidCredential:
        errorMessage = 'Credencial Invalida';
        break;
      // --
      case ERROR_EMAIL_ALREADY_IN_USE:
        errorMessage = 'El correo introducido ya esta en uso';
        break;
      // --
      case ErrorCodeWeakPassword:
        errorMessage = 'La contraseña debe ser de al menos 6 o mas caracteres';
        break;
      // --
      case ERROR_OPERATION_NOT_ALLOWED:
        errorMessage = 'Accion no permitida';
        break;
      // --
      default:
        errorMessage = 'Ocurrio un error, por favor reintentalo mas tarde';
        break;
    }

    final error = CustomError(
        message: errorMessage,
        longMessage: firestoreException.message,
        errorCode: firestoreException.code,
        errorType: firestoreException.plugin,
        stackTrace: stack,
        devMessage: devMessage);
    return error;
  }
}

@immutable
class CustomError extends Equatable {
  //
  final String message;
  final String errorType;
  final String errorCode;
  final String? longMessage;
  final dynamic stackTrace;
  final String? devMessage;
  final dynamic status;

  const CustomError({
    required this.message,
    required this.errorCode,
    required this.errorType,
    this.stackTrace,
    this.longMessage,
    this.devMessage,
    this.status,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        message,
        longMessage,
        errorType,
        errorCode,
        stackTrace,
        devMessage,
        status,
      ];
}
