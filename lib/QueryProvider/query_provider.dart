import 'dart:developer';

import 'package:auto_fix/Constants/grapgh_ql_client.dart';

class QueryProvider {
  signIn(String userName, String password) async {
    String _query = """  
  mutation{
  customerSignIn(emailId: "$userName", password: "$password"){
    token
    customer {
      id
      firstName
      lastName
      address
      emailId
      phoneNo
      status
    }
  }
}
    """;
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  signUp(String firstName, String userName, String email, String state,
      String password, String phoneNo) async {
    String _query = """ 
    mutation{
    customersSignUp(firstName: "$firstName", lastName: "$userName", address: "$state", emailId: "$email", phoneNo: "$phoneNo", password: "$password"){
      token
      customer {
        id
        firstName
        lastName
        address
        emailId
        phoneNo
        status
      }
    }
  }
    """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  forgotPassword(String email) {}
  changePassword(String password) {}
  editProfile() {}
  viewProfile() {}
  searchResult() {}
  selectCar() {}
  viewVehicle() {}
  deleteVehicle() {}
  vehicleDetails() {}
  addVehicle() {}
  bookingsList() {}
  bookingDetail() {}
  allModel() {}
  allMake() {}
  allEngine() {}
  getAds() {}
  topBrands() {}
  topShops() {}
}
