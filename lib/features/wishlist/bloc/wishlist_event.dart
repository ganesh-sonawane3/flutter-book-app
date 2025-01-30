part of 'wishlist_bloc.dart';

abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistRemoveFromWishlistEvent extends WishlistEvent {
  final ProductDataModel productDataModel;
  WishlistRemoveFromWishlistEvent({
    required this.productDataModel,
  });
}
