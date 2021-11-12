import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/Shops/top_shops_mdl.dart';
import 'package:rxdart/rxdart.dart';

class TopShopsBloc {
  final Repository repository = Repository();
  final postTopShops = PublishSubject<TopShopsMdl>();
  Stream<TopShopsMdl> get topShopsResponse => postTopShops.stream;
  dispose() {
    postTopShops.close();
  }

  postTopShopsRequest() async {
    TopShopsMdl _topShopsMdl = await repository.getTopShops();
    postTopShops.sink.add(_topShopsMdl);
  }
}
