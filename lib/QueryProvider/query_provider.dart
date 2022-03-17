import 'dart:developer';

import 'package:auto_fix/Constants/grapgh_ql_client.dart';

class QueryProvider {

  signIn(String userName, String password) async {
    String _query = """  
 mutation {
  customerSignIn(emailId: "$userName", password: "$password") {
    token
    customer {
      id
      userCode
      firstName
      lastName
      emailId
      phoneNo
      state
      resetToken
      userType
      accountType
      profilePic
      isProfile_Completed
      otp_verified
      status
    }
    isProfile_Completed
  }
}
    """;
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  socialLogin(String email, String phoneNumber) async {
    String _query;
    if(email=="")
      {
        _query = """  
          mutation {
            customerSocialLogin(emailId: "$email") {
              token
              customer {
                id
                userCode
                firstName
                lastName
                emailId
                phoneNo
                state
                resetToken
                userType
                accountType
                profilePic
                isProfile_Completed
                otp_verified
                status
              }
            }
          }
    """;
      }
    else
      {
        _query = """  
            mutation {
             customerSocialLogin(phoneNo: "$phoneNumber") {
              token
              customer {
                id
                userCode
                firstName
                lastName
                emailId
                phoneNo
                state
                resetToken
                userType
                accountType
                profilePic
                isProfile_Completed
                otp_verified
                status
              }
            }
          }
    """;
      }

    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  signUpCustomerIndividual(String firstName, String lastName, String email, String state,
      String password, String phoneNo, String profilepic) async {
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
          profilepic:"$profilepic"
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
            resetToken
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
      String password, String phoneNo,String orgName,String orgType, String profilepic) async {
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
          profilepic:"$profilepic"
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
            resetToken
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
      String password, String phoneNo,String govt_agency,String govt_type, String profilepic) async {
    String _query = """ 
    mutation {
         customersSignUp_govtBodies(
          firstName: "$firstName"
          lastName:"$lastName"
          emailId: "$email"
          phoneNo: "$phoneNo"
          govt_type: "$govt_type"
          govt_agency: "Food Corporation of india"
          ministry_name: "Labour And Environment"
          head_of_dept: "Athira"
          password: "$password"
          state: "$state"
          userType: 1
          accountType: 3
          profilepic:"$profilepic"
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
            resetToken
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

  signUpMechanicIndividual(String firstName, String lastName, String email, String state,
      String password, String phoneNo, String latitude, String longitude,
      String year_of_experience, String profilepic) async {
    String _query = """ 
    mutation {
        mechanic_signUp_Individual(
          firstName: "$firstName"
          lastName: "$lastName"
          emailId: "$email"
          phoneNo: "$phoneNo"
          state: "$state"
          latitude: ${double.parse(latitude.toString())}
          longitude: ${double.parse(longitude.toString())}
          password: "$password"
          confirm_password: "$password"
          userType: 2
          accountType: 1
          year_of_experience: "$year_of_experience"
          profilepic:"$profilepic"
        ) {
          token
          mechanic {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            state
            latitude
            longitude
            userType
            resetToken
            accountType
            status
          }
          genMechanic {
            id
            org_name
            org_type
            year_exp
            userId
            status
          }
        }
      }

    """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }


  signUpMechanicCorporate(String firstName, String lastName, String email, String state,
      String password, String phoneNo, String latitude, String longitude,
      String year_of_experience,String orgName,String orgType, String profilepic) async {
    String _query = """ 
    mutation {
        mechanic_signUp_Corporate(
          firstName:  "$firstName"
          lastName:  "$lastName"
          emailId:  "$email"
          phoneNo:  "$phoneNo"
          state:  "$state"
          latitude:  ${double.parse(latitude.toString())}
          longitude: ${double.parse(longitude.toString())}
          password:  "$password"
          confirm_password: "$password"
          userType: 2
          accountType: 2
          year_of_experience:"$year_of_experience"
          org_Name: "$orgName"
          org_Type:"$orgType"
          profilepic:"$profilepic"
        ) {
          token
          mechanic {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            state
            latitude
            longitude
            userType
            resetToken
            accountType
            status
          }
          genMechanic {
            id
            org_name
            org_type
            year_exp
            userId
            status
          }
        }
      }

    """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  postAddCarRequest(
      token,
      year,
      plateNo,
      engineName,
      lastMaintenance,
      milege,
      makeId,
      vehicleModelId,
      vehiclePic) async {
    String _query = """ 
    mutation {
        vehicleCreate(
          year: "$year"
          plateNo: "$plateNo"
          engineName: "$engineName"
          lastMaintenance: "$lastMaintenance"
          milege: "$milege"
          makeId:  ${int.parse(makeId.toString())}
          vehicleModelId: ${int.parse(vehicleModelId.toString())}
          vehiclePic: "$vehiclePic"
        ) {
          id
          year
          plateNo
          engineName
          milege
          lastMaintenance
          defaultVehicle
          userId
          makeId
          vehicleModelId
          status
        }
      }
    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true,token: token, isTokenThere: true, variables: {});
  }

  postMakeBrandRequest(
      token,) async {
    String _query = """ 
    query
    {
      makeDetails {
        id
        makeName
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

  postModelDetailRequest(
      token,type) async {
    String _query = """ 
    query
    {
      modelDetails(type: "$type") {
        id
        modelName
        engineName
        years
        makeId
        status
        make {
          id
          makeName
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

  postOtpVerificationRequest(
      token,
      otp,) async {
    String _query = """ 
    mutation {
      otp_Verification(otpCode: "$otp") {
        message
      }
    }

    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true,token: token, isTokenThere: true, variables: {});
  }

  postMechanicsBookingIDRequest(
      token,
      date,
      time,
      latitude,
      longitude,
      serviceId) async {
    String _query = """ 
     mutation {
      mechanics_Booking(
        date: "$date"
        time: "$time"
        latitude: ${double.parse(latitude.toString())}
        longitude: ${double.parse(longitude.toString())}
        serviceId: $serviceId
      ) {
        id
        date
        time
        latitude
        longitude
        paymentMethod
        userId
        status
        isAccepted
        vehicleId
        serviceId
      }
    }
    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true,token: token, isTokenThere: true, variables: {});
  }


  postFindMechanicsListEmergencyRequest(
      token,
      bookMechanicId,
      serviceId,
      serviceType) async {
    String _query = """ 
     query
    {
      mechaniclist_for_services(
        bookMechanicId: $bookMechanicId
        serviceId: $serviceId
        serviceType: "$serviceType"
      ) {
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
        mechanicService {
          id
          fee
          serviceId
          status
          userId
        }
        mechanicVehicle {
          id
          status
          makeId
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
    );;
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


  serviceList(String token, String type) async {
    String _query = """
   {
  emeregency_or_regular_serviceList(id: $type) {
    id
    serviceName
    icon
    minAmount
    maxAmount
    categoryId
    type
    status
  }
}
     """;
    log(_query);
    print("Token >>>>>>> $token");
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  completeProfileMechIndividual(String token,
      String workSelection,
      String vehicleSpecialization,
      String address,String apprentice_cert, String identification_cert) async {
    String _query = """
    mutation {
  mechanic_work_selection_Individual(
    service_type: "$workSelection"
    vehicle: "$vehicleSpecialization"
    address: "$address"
    apprentice_cert: "$apprentice_cert"
    identification_cert: "$identification_cert"
  ) {
    id
    service_type
    apprentice_cert
    address
    identification_cert
    no_mechanics
    rc_number
    year_existence
    status
    userId
  }
}

    """;
    log(_query);
    print(">>>> Token $token");
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  completeProfileMechCorporate(String token,) async {
    String _query = """ 
    mutation {
  mechanic_work_selection_Corporate(
    service_type: "1,2"
    vehicle: "1"
    address: "string"
    no_mechanics: "string"
    rc_number: "string"
    year_existence: "string"
  ) {
    id
    service_type
    apprentice_cert
    address
    identification_cert
    no_mechanics
    rc_number
    year_existence
    status
    userId
  }
}
    """;
    log(_query);
    print(">>>> Token $token");
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

  mechanicAddServiceList(String token,String serviceList, String costList, String timeList) async {
    String _query = """ 
    mutation {
  mechanic_service_add(services: "$serviceList", fee: $costList, time: $timeList) {
    message
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


}
