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

  forgotPassword(String email) async {
    String _query = """
      mutation{
        customerForgotPassword(emailId: "$email"){
          resetToken
          }
       }
     """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  changePassword(String password) {}
  editProfile() {}
  viewProfile(String id) async {
    String _query = """ 
    query{
    customerDetails(id: $id){
      id
      firstName
      lastName
      address
      emailId
      phoneNo
      status
      }
    }
    """;
    log(_query);
    return await GqlClient.I.query(
      _query,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  searchResult() {}
  selectCar() {}
  viewVehicle() {}
  deleteVehicle() {}
  vehicleDetails() {}
  addVehicle(
      String year,
      String latitude,
      String longitude,
      String milege,
      String lastMaintenance,
      String interval,
      int makeId,
      int vehicleModelId,
      int engineId) async {
    String _query = """
      mutation{
    vehicleCreate(year: "$year", latitude: "$latitude", longitude: "$longitude", milege: "$milege", lastMaintenance: "$lastMaintenance", interval: "$interval", makeId: $makeId, vehicleModelId: $vehicleModelId, engineId: $engineId){
      id
      year
      latitude
      longitude
      milege
      lastMaintenance
      interval
      customerId
      makeId
      vehicleModelId
      engineId
      status
    }
  }
     """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  bookingsList() {}
  bookingDetail() {}
  allModel() {}
  allMake() {}
  allEngine() {}
  getAds() {}
  topBrands() {}
  topShops() {}
}
