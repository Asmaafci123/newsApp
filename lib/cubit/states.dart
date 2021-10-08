abstract class NewsStates
{

}
class NewsInitialState extends NewsStates{}
class NewsBottomNavigationState extends NewsStates{}
class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessFailedState extends NewsStates{
  final String error;
  NewsGetBusinessFailedState(this.error);
}
class NewsLoadingState extends NewsStates{}


class NewsGetSportsSuccessState extends NewsStates{}
class NewsGetSportsFailedState extends NewsStates{
  final String error;
  NewsGetSportsFailedState(this.error);
}

class NewsGetScienceSuccessState extends NewsStates{}
class NewsGetScienceFailedState extends NewsStates{
  final String error;
  NewsGetScienceFailedState(this.error);
}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchFailedState extends NewsStates{
  final String error;
  NewsGetSearchFailedState(this.error);
}

class NewsChangeModeState extends NewsStates{}