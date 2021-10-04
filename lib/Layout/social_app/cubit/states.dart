
abstract  class SocialStates{}

class SocialInitialState extends SocialStates{}



class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  late String error;
  SocialGetUserErrorState (this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}






