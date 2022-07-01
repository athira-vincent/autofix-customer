import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_corporate_edit_profile_mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_government_edit_profile_mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_individual_edit_profile_mdl.dart';

import 'package:rxdart/rxdart.dart';

class CustomerEditProfileBloc {
  final Repository repository = Repository();

  final postCustomerIndividualEditProfile = PublishSubject<CustomerIndividualEditProfileMdl>();
  Stream<CustomerIndividualEditProfileMdl> get customerIndividualEditProfileResponse =>
      postCustomerIndividualEditProfile.stream;

  postCustomerIndividualEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl
      ) async {
    CustomerIndividualEditProfileMdl _customerIndividualEditProfileMdl =
    await repository.postCustIndividualEditProfileRequest( token, firstName,  lastName,  state, status, imageUrl);
    postCustomerIndividualEditProfile.sink.add(_customerIndividualEditProfileMdl);
  }

  final postCustomerCorporateEditProfile = PublishSubject<CustomerCorporateEditProfileMdl>();
  Stream<CustomerCorporateEditProfileMdl> get customerCorporateEditProfileResponse =>
      postCustomerCorporateEditProfile.stream;

  postCustomerCorporateEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl, orgName, orgType
      ) async {
    CustomerCorporateEditProfileMdl _customerCorporateEditProfileMdl =
    await repository.postCustCorporateEditProfileRequest( token, firstName,  lastName,  state, status, imageUrl,orgName, orgType);
    postCustomerCorporateEditProfile.sink.add(_customerCorporateEditProfileMdl);
  }

  final postCustomerGovernmentEditProfile = PublishSubject<CustomerGovernmentEditProfileMdl>();
  Stream<CustomerGovernmentEditProfileMdl> get customerGovernmentEditProfileResponse =>
      postCustomerGovernmentEditProfile.stream;

  postCustomerGovernmentEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl, ministryName
      ) async {
    CustomerGovernmentEditProfileMdl _customerGovernmentEditProfileMdl =
    await repository.postCustGovernmentEditProfileRequest( token, firstName,  lastName,  state, status, imageUrl, ministryName);
    postCustomerGovernmentEditProfile.sink.add(_customerGovernmentEditProfileMdl);
  }


  dispose() {
    postCustomerIndividualEditProfile.close();
    postCustomerCorporateEditProfile.close();
    postCustomerGovernmentEditProfile.close();
  }
}
