import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_mdl.dart';

import 'package:rxdart/rxdart.dart';

class CustomerProfileBloc {
  final Repository repository = Repository();
  final postCustomerProfile = PublishSubject<CustomerProfileMdl>();
  Stream<CustomerProfileMdl> get customerProfileResponse =>
      postCustomerProfile.stream;
  dispose() {
    postCustomerProfile.close();
  }

  postCustomerProfileRequest(
      String token,id,
      ) async {
    CustomerProfileMdl _customerProfileMdl =
    await repository.postCustFetchProfileRequest(token,id);
    postCustomerProfile.sink.add(_customerProfileMdl);
  }
}
