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

  signUpCustomerIndividual(String firstName, String lastName, String email, String state,
      String password, String phoneNo) async {
    String _query = """ 
    mutation {
        customersSignUp_Individual(
          firstName: "$firstName"
          lastName: "$lastName"
          emailId: "$email"
          phoneNo: "$phoneNo"
          password: "$password"
          state: "$state"
          userType: 1
          accountType: 1
        ) {
          token
          customer {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            state
            userType
            accountType
            profilePic
            isProfile_Completed
            status
          }
          isProfile_Completed
        }
      }

    """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  signUpCustomerCorporate(String firstName, String lastName, String email, String state,
      String password, String phoneNo,String orgName,String orgType) async {
    String _query = """ 
    mutation {
        customersSignUp_Corporate(
          firstName: "$firstName"
          lastName: "$lastName"
          emailId: "$email"
          phoneNo: "$phoneNo"
          org_name: "$orgName"
          org_type: "$orgType"
          password: "$password"
          state: "$state"
          userType: 1
          accountType: 2
        ) {
          token
          customer {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            state
            userType
            accountType
            profilePic
            isProfile_Completed
            status
          }
          isProfile_Completed
        }
      }

    """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  signUpCustomerGovtBodies(String firstName, String lastName, String email, String state,
      String password, String phoneNo,String orgName,String orgType) async {
    String _query = """ 
    mutation {
        customersSignUp_Corporate(
          firstName: "$firstName"
          lastName: "$lastName"
          emailId: "$email"
          phoneNo: "$phoneNo"
          org_name: "$orgName"
          org_type: "$orgType"
          password: "$password"
          state: "$state"
          userType: 1
          accountType: 2
        ) {
          token
          customer {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            state
            userType
            accountType
            profilePic
            isProfile_Completed
            status
          }
          isProfile_Completed
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

  fcmTokenUpdate(String fcmToken,String Authtoken) async {
    String _query = """
      mutation {
        fcm_token_update(fcmToken: "$fcmToken") {
          message
        }
      }
     """;
    log(_query);
    return await GqlClient.I
        .query01(_query, Authtoken, enableDebug: true, isTokenThere: true);
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

  viewProfile(String id,String token, ) async {
    String _query = """ 
    query
    {
      customerDetails(id: "$id") {
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
      String numberPlate,
      int makeId,
      int vehicleModelId,
      int engineId) async {
    String _query = """
      mutation{
    vehicleCreate
    (
    year: "$year",
    latitude: "$latitude",
    longitude: "$longitude", 
    milege: "$milege", 
    lastMaintenance: "$lastMaintenance",
    interval: "$interval",
    makeId: $makeId, 
    vehicleModelId: $vehicleModelId,
     numberPlate: "$numberPlate"
   engineId: $engineId
     ){
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
  allModel(String id, String token) async {
    String _query = """
          query{
      modelDetails(type: "$id"){
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
  getMechanicDetails(String id,String serviceId) async {
    String _query = """
         query{
      mechanicDetails(mechanicId:$id,serviceId: "$serviceId"){
        mechanicData{id,
          mechanicCode,
          mechanicName,
          emailId,
          phoneNo,
          address,
          latitude,
          longitude,
          walletId,
          verified,
          enable,
          isEmailverified,
          jobType,
          startTime,
          endTime,
          status,
          }
        serviceData{id,
        status,
          fee,
        serviceId,
        demoMechanicId,
        service{id,
    serviceName,
    icon,
    type,
    fee,
    minAmount,
    maxAmount,
    status}}
        vehicleData{id,
          status,
        make{
          id,
        makeName,
        description,
        status,
        }}
        totalAmount
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


    String _query = """
    query{
   mechanicList(page: $page, size: $size, serviceId: "$serviceId"){
    totalItems
    data
    {
    id,
    mechanicCode,
    mechanicName,
    emailId,
    phoneNo,
    address,
    latitude,
    longitude,
    walletId,
    verified,
    enable,
    isEmailverified,
    jobType,
    startTime,
    endTime,
    status,
    demoMechanicService{id,
    fee,
    status,
    serviceId,
    demoMechanicId,
    service
    {
      id,
      serviceName,
      icon,
      type,
      fee,
      minAmount,
      maxAmount,
      status
    }
    },
    demoMechanicVehicle{id,
    status,
    makeId,
    make{id
     id,
    makeName,
    description,
    status,}}}
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
                mutation{
          signIn(emailId: "$userName"
            password: "$password"){
            token
            mechanic {
              id
              mechanicCode
              mechanicName
              emailId
              phoneNo
              address
              latitude
              longitude
              walletId
              verified
              enable
              isEmailverified
              jobType
              startTime
              endTime
              currentState
              status
            }
          }
        }
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
        walletId: "$walletId", 
        password: "$password"){
          token
          mechanic {
            id
            mechanicCode
            mechanicName
            emailId
            phoneNo
            address
            latitude
            longitude
            walletId
            verified
            enable
            isEmailverified
            jobType
            startTime
            endTime
            status
          }
        }
      }
      """;

    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  mechanicSignUpWorkSelection(
      int isEmergencyEnabled,
      String serviceIdList,
      String serviceFeeList,
      String startTime,
      String endTime
      ) async {
    String _query = """
          mutation{
        skillsAdd(enable: $isEmergencyEnabled,
         serviceId: "$serviceIdList", 
         startTime: "$startTime", 
         endTime: "$endTime", 
         fee: "$serviceFeeList"){
          id
          mechanicCode
          mechanicName
          emailId
          phoneNo
          address
          latitude
          longitude
          walletId
          verified
          enable
          isEmailverified
          jobType
          startTime
          endTime
          status
        }
      }
    """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  mechanicSignUpExpertizeSelection(
      String token,
      String yearOfExperience,
      String brandIdList,
      String modelIdList,
      String jobType
      ) async {
    String _query = """
        mutation{
      vehicleAdd(experience: "$yearOfExperience", 
      makeId: "$brandIdList", 
      vehicleModelId: "$modelIdList", 
      jobType: "$jobType"){
        id
        mechanicCode
        mechanicName
        emailId
        phoneNo
        address
        latitude
        longitude
        walletId
        verified
        enable
        isEmailverified
        jobType
        startTime
        endTime
        status
      }
    }
  """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true,token: token, isTokenThere: true, variables: {});
  }

  allServiceFee(int page, int size, int enable,String token) async {
    String _query = """
           query{
        serviceList(page: $page, size: $size, enable: $enable){
          totalItems
          data {
            id
            serviceName
            description
            icon
            fee
            type
            minAmount
            maxAmount
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
      isTokenThere: true,
    );
  }

  mechanicForgotPassword(String email) async {
    String _query = """
          mutation{
      mechanicForgotPassword(emailId: "$email"){
        resetToken
      }
    }
     """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  mechanicChangePassword(String password) {}

  mechanicEditProfile() {}

  mechanicViewProfile(String id,String token, ) async {
    String _query = """ 
    """;
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: true,
    );
  }

  mechanicUpcomingServicesList(String token) async {
    String _query = """
     """;
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: true,
    );
  }

  mechanicTodaysServicesList(String token) async {
    String _query = """
     """;
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: true,
    );
  }

  mechanicCompletedServicesList(String token) async {
    String _query = """
     """;
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: true,
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
