import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/services_fee_list/service_fee_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AllServiceFeeBloc {
  final Repository repository = Repository();
  final postAllServiceFee = PublishSubject<AllServiceFeeMdl>();
  Stream<AllServiceFeeMdl> get allServiceFeeResponse => postAllServiceFee.stream;

  final postServiceData = PublishSubject<List<AllServiceFeeData>>();
  Stream<List<AllServiceFeeData>> get allServiceDetails => postServiceData.stream;
  List<AllServiceFeeData> _serviceDataList = [];

  dispose() {
    postAllServiceFee.close();
    postServiceData.close();
  }

 /* postAllServiceRequest(int page, int size, String enable,String token) async {
    AllServiceFeeMdl _allServiceFeeMdl = await repository.getAllServiceFee(page,size,enable, token);
    postAllServiceFee.sink.add(_allServiceFeeMdl);
  }*/

  postAllServiceDataRequest(int page, int size, int enable,String token) async{
    AllServiceFeeMdl _allServiceMdl = await repository.getAllServiceFee(page,size,enable, token);
    _serviceDataList.clear();
    _serviceDataList.addAll(_allServiceMdl.data!.serviceList!.allServiceFeeData!);
    postAllServiceFee.sink.add(_allServiceMdl);
    postServiceData.sink.add(_allServiceMdl.data!.serviceList!.allServiceFeeData!);
  }


  void searchMake(String searchText) {
    List<AllServiceFeeData> _searchList = [];
    _searchList.clear();
    if (searchText != '' || searchText != ' ') {
      _serviceDataList.forEach((element) {
        if(element.serviceName!.toLowerCase().startsWith(searchText.toLowerCase())){
          _searchList.add(element);
        }
      });
      postServiceData.sink.add(_searchList);
    } else {
      postServiceData.sink.add(_serviceDataList);
    }
  }
}
