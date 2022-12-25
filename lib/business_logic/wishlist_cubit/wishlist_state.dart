abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class AddProductToWishList extends WishlistState {}

class RemoveProductFromWishList extends WishlistState {}

class WishListLoadingState extends WishlistState {}

class WishListSuccessState extends WishlistState {}

class WishListErrorState extends WishlistState {
  String error;
  WishListErrorState({required this.error});
}
