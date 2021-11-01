import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Home/Ads/ads_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AdsBloc {
  final Repository repository = Repository();
  final postAds = PublishSubject<AdsMdl>();
  Stream<AdsMdl> get adsResponse => postAds.stream;
  dispose() {
    postAds.close();
  }

  postAdsRequest() async {
    AdsMdl _adsMdl = await repository.getAds();
    postAds.sink.add(_adsMdl);
  }
}
