import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/Brands/top_brands_mdl.dart';
import 'package:rxdart/rxdart.dart';

class TopBrandsBloc {
  final Repository repository = Repository();
  final postTopBrands = PublishSubject<TopBrandsMdl>();
  Stream<TopBrandsMdl> get topBrandsResponse => postTopBrands.stream;
  dispose() {
    postTopBrands.close();
  }

  postTopBrandsRequest() async {
    TopBrandsMdl _topBrandsMdl = await repository.getTopBrands();
    postTopBrands.sink.add(_topBrandsMdl);
  }
}
