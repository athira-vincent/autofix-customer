import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_edit_profile_mdl.dart';

import 'package:rxdart/rxdart.dart';

class CustomerEditProfileBloc {
  final Repository repository = Repository();
  final postCustomerEditProfile = PublishSubject<CustomerEditProfileMdl>();
  Stream<CustomerEditProfileMdl> get customerEditProfileResponse =>
      postCustomerEditProfile.stream;
  dispose() {
    postCustomerEditProfile.close();
  }

  postCustomerEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl
      ) async {
    CustomerEditProfileMdl _customerEditProfileMdl =
    await repository.postCustEditProfileRequest( token, firstName,  lastName,  state, status, imageUrl);
    postCustomerEditProfile.sink.add(_customerEditProfileMdl);
  }
}
