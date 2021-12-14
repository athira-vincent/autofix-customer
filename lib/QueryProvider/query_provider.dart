import 'dart:developer';

import 'package:auto_fix/Constants/grapgh_ql_client.dart';

class QueryProvider {
  signIn(String userName, String password) async {
    String _query = """  
  mutation{
  customerSignIn(userName: "$userName", password: "$password") {
    token
    customer {
      id
      firstName
      lastName
      address
      emailId
      phoneNo
      profilePic
      isProfileCompleted
      state
      userName
      status
    }
    isProfileCompleted
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
          customersSignUp(firstName: "$firstName", lastName: "", address: "", emailId: "$email", phoneNo: "$phoneNo", password: "$password",state:"$state",userName:"$userName") {
            token
            customer {
              id
              firstName
              lastName
              address
              emailId
              phoneNo
              profilePic
              isProfileCompleted
              state
              userName
              status
            }
            isProfileCompleted
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

  getToken(String userId, int type) async {
    String _query = """
      mutation{
      generateAuthorization(userId: $userId, type: $type){
        token
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

  searchResult(
      int page, int size, String searchText, String token, String type) async {
    String _query = """
      query{
        serviceListAll(page: $page, size: $size, search: "$searchText",type:"$type"){
          totalItems
          data {
            id
            serviceName
            description
            icon
            fee
            type
            status
          }
          totalPages
          currentPage
        }
      }
     """;
    log(_query);
    print("ddddd $token");
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  selectCar() {}

  viewVehicle(String token) async {
    String _query = """
      query{
  vehicleDetails{
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
    make {
      id
      makeName
      description
      status
    }
    vehiclemodel {
      id
      modelName
      description
      makeId
      status
    }
    engine {
      id
      engineName
      description
      vehicleModelId
      status
    }
    defaultVehicle
  }
}""";
    log(_query);

    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: false,
    );

  }

  deleteVehicle() {}

  vehicleDetails(String token) async {
    String _query = """
      query{
  vehicleDetails {
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
          make {
            id
            makeName
            description
            status
          }
          vehiclemodel {
            id
            modelName
            description
            makeId
            status
          }
          engine {
            id
            engineName
            description
            vehicleModelId
            status
          }
        } 
      }
     """;
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  addVehicle(
      String token,
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
    return await GqlClient.I
        .query01(_query, token, enableDebug: true, isTokenThere: true);
  }

  bookingsList() {}
  bookingDetail() {}
  allModel(int id, String token) async {
    String _query = """
      query{
  modelDetails(id: $id) {
    id
    modelName
    description
    makeId
    status
    make {
      id
      makeName
      description
      status
    }
  }
}
     """;
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: true,
    );
  }

  allMake(String token) async {
    String _query = """
    query{
  makeDetails{
    id
    makeName
    description
    status
  }
}
""";
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: true,
    );
  }

  allEngine(int id, String token) async {
    String _query = """
      query{
  engineDetails(id: $id) {
    id
    engineName
    description
    vehicleModelId
    status
    vehicleModel {
      id
      modelName
      description
      makeId
      status
    }
   }
  }
     """;
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: true,
    );
  }

  getAds() {}
  topBrands() {}
  topShops() {}
  getMechanicDetails(String id) async {
    String _query = """
      query{
  mechanicDetails(mechanicId: $id) {
    mechanicData {
      id
      displayName
      userName
      password
      firstName
      lastName
      emailId
      phoneNo
      address
      startTime
      endTime
      city
      licenseNo
      state
      licenseDate
      latitude
      longitude
      serviceId
      profilePic
      licenseProof
      status
    }
    serviceData {
      id
      status
      serviceId
      mechanicId
      service {
        id
        serviceName
        description
        icon
        fee
        type
        status
      }
    }
    vehicleData {
      id
      status
      makeId
      mechanicId
      make {
        id
        makeName
        description
        status
      }
    }
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

  getAllMechanicList(String token, int page, int size, String serviceId) async {
    /*String _query = """
    query{
  mechanicList(page: $page, size: $size){
    totalItems
    data {
      id
      displayName
      userName
      password
      firstName
      lastName
      emailId
      phoneNo
      address
      startTime
      endTime
      city
      licenseNo
      state
      licenseDate
      latitude
      longitude
      serviceId
      profilePic
      licenseProof
      status
      serviceData {
        id
        status
        serviceId
        mechanicId
        service {
          id
          serviceName
          description
          icon
          fee
          type
          status
        }
      }
      vehicleData {
        id
        status
        makeId
        mechanicId
        make {
          id
          makeName
          description
          status
        }
      }
    }
    totalPages
    currentPage
  }
}
    """;*/
   /* String _query = """
    query{
  mechanicList(page: $page, size: $size, serviceId:"$serviceId"){
    totalItems
    data {
      id
      displayName
      userName
      password
      firstName
      lastName
      emailId
      phoneNo
      address
      startTime
      endTime
      city
      licenseNo
      state
      licenseDate
      latitude
      longitude
      serviceId
      profilePic
      licenseProof
      status
    }
    totalPages
    currentPage
  }
}
    """;*/

    String _query = """
    query{
  mechanicList(page: $page, size: $size, serviceId: "$serviceId") {
    totalItems
    data {
      id
      displayName
      userName
      password
      firstName
      lastName
      emailId
      phoneNo
      address
      startTime
      endTime
      city
      licenseNo
      state
      licenseDate
      latitude
      longitude
      serviceId
      profilePic
      licenseProof
      status
      mechanicService {
        service {
          id
          serviceName
          description
          icon
          fee
          type
          status
        }
      }
      mechanicVehicle {
        make {
          id
          makeName
          description
          status
        }
      }
    }
    totalPages
    currentPage
  } 
}""";

    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: true,
    );
  }

  getRegularServices(int page, int size, String token) async {
    String _query = """
      query{
          emergencyList(page: $page, size: $size, id: "2"){
                  totalItems
                  data {
                    id
                    serviceName
                    description
                    icon
                    fee
                    type
                    status
                  }
                  totalPages
                  currentPage
                }
      }
     """;
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  getEmeregencyServices(int page, int size, String token) async {
    String _query = """
      query{
          emergencyList(page: $page, size: $size, id: "1"){
                  totalItems
                  data {
                    id
                    serviceName
                    description
                    icon
                    fee
                    type
                    status
                  }
                  totalPages
                  currentPage
                }
      }
     """;
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  //------------------------------- Mechanic API --------------------------------

  mechanicSignIn(String userName, String password) async {
    String _query = """  
  
    """;
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  mechanicSignUp(String name,
      String email,
      String phoneNo,
      String address,
      double lat,
      double lng ,
      String walletId,
      String password ) async {
    String _query = """ 
    mutation{
  signUp(
  mechanicName: "$name", 
  emailId: "$email", 
  phoneNo: "$phoneNo", 
  address: "$address", 
  latitude: $lat, 
  longitude: $lng, 
  walletId:"$walletId", 
  password: "$password")
  {
    token
    mechanic{id}
  }
}
    """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  mechanicSignUpWorkSelection(
      String yearOfExperience,
      bool isEmergencyEnabled,
      String serviceIdList
      ) async {
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
