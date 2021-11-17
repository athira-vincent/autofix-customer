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
  addVehicle() {}
  bookingsList() {}
  bookingDetail() {}
  allModel() {}
  allMake() {}
  allEngine() {}
  getAds() {}
  topBrands() {}
  topShops() {}


  //------------------------------- Mechanic API --------------------------------



  mechanicSignIn(String userName, String password) async {
    String _query = """  
  
    """;
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  mechanicSignUp(String firstName, String userName, String email, String state,
      String password, String phoneNo) async {
    String _query = """ 
    
    """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  mechanicForgotPassword(String email) async {
    String _query = """
      
     """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});

  }
  mechanicChangePassword(String password) {}
  mechanicEditProfile() {}
  mechanicViewProfile(String id) async {
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

  // ---------------------------- Vendor API ------------------------------------

  vendorSignIn(String userName, String password) async {
    String _query = """  
    """;
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  vendorSignUp(String firstName, String userName, String email, String state,
      String password, String phoneNo) async {
    String _query = """ 
    
    """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  vendorForgotPassword(String email) async {
    String _query = """
     
     """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});

  }

  vendorChangePassword(String password) {}
  vendorEditProfile() {}
  vendorViewProfile(String id) async {
    String _query = """ 
    
    """;
    log(_query);
    return await GqlClient.I.query(
      _query,
      enableDebug: true,
      isTokenThere: false,
    );
  }


}
