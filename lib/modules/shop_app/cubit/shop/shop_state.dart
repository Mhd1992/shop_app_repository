abstract class ShopState {}

class ShopInitialState extends ShopState{}
class ShopLoadingState extends ShopState{}
class ShopSuccessState extends ShopState{}
class ChangeBottomNavState extends ShopState{}
class ChangeLoadingHomeState extends ShopState{}
class ShopErrorState extends ShopState{}
//-------categories  state
class ShopCategoriesSuccessState extends ShopState{}
class ShopErrorCategoriesState extends ShopState{}
//------- Favorite state
class ShopChangeFavoriteSuccessState extends ShopState{}
class ShopChangeFavoriteLoadingState extends ShopState{}
class ShopErrorChangeFavoriteState extends ShopState{

  String message;

  ShopErrorChangeFavoriteState({required this.message});
}

//-----------Get Favorites
class ShopGetFavoriteSuccessState extends ShopState{}
class ShopErrorGetFavoriteState extends ShopState{}