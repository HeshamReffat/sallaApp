abstract class NewAddressStates {}
class NewAddressStateInit extends NewAddressStates{}
class NewAddressStateLoading extends NewAddressStates{}
class NewAddressStateSuccess extends NewAddressStates{}
class UpdateAddressStateLoading extends NewAddressStates{}
class UpdateAddressStateSuccess extends NewAddressStates{}
class UpdateAddressStateError extends NewAddressStates{}
class GeoLocationStateSuccess extends NewAddressStates{}
class GeoLocationStateLoading extends NewAddressStates{}
class GeoLocationStateError extends NewAddressStates{}
class NewAddressStateError extends NewAddressStates{
  var error;
  NewAddressStateError(this.error);
}