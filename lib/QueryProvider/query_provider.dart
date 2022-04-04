import 'dart:developer';

import 'package:auto_fix/Constants/grapgh_ql_client.dart';

class QueryProvider {

  signIn(String userName, String password) async {
    String _query = """
      mutation {
    SignIn(emailId: "$userName", password: "$password", platformId: 1) {
      token
      user {
        id
        userCode
        firstName
        lastName
        emailId
        phoneNo
        status
        userTypeId
        jwtToken
        fcmToken
        otpCode
        isProfile
        otpVerified
      }
      vendor {
        id
        userCode
        firstName
        lastName
        emailId
        phoneNo
        userTypeId
        status
        jwtToken
        fcmToken
        otpCode
        isProfile
        otpVerified
      }
      admin {
        id
        userCode
        firstName
        lastName
        emailId
        phoneNo
        userTypeId
        status
        jwtToken
        fcmToken
        otpCode
        isProfile
        otpVerified
      }
    }
  }
    """;
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  socialLogin( email,  phoneNumber) async {
    String _query;
    if(email!="")
      {
        _query = """  
        mutation {
      socialLogin(emailId: "$email") {
        token
        user {
          id
          userCode
          firstName
          lastName
          emailId
          phoneNo
          status
          userTypeId
          jwtToken
          fcmToken
          otpCode
          isProfile
          otpVerified
        }
      }
    }      
     """;
      }
    else
      {
        _query = """  
             mutation {
      socialLogin(emailId: "$phoneNumber") {
        token
        user {
          id
          userCode
          firstName
          lastName
          emailId
          phoneNo
          status
          userTypeId
          jwtToken
          fcmToken
          otpCode
          isProfile
          otpVerified
        }
      }
    } 
    """;
      }

    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  phoneLogin(  phoneNumber) async {
    String _query = """
    mutation {
      signIn_phoneNo(phoneNo: "$phoneNumber", platformId: 1) {
        otp
        phoneNo
        id
        userTypeId
        jwtToken
      }
    }
    """;

    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  signUp( type, firstName, lastName, emailId, phoneNo, password, state,
  fcmToken, userTypeId, userType, profilepic, orgName, orgType,
  ministryName, hod, latitude, longitude, yearExp, shopName,) async
  {
    String _query = """ 
    mutation {
        signUp(
          type: ${int.parse(type.toString())}
          firstName: "$firstName"
          lastName: "$lastName"
          emailId: "$emailId"
          phoneNo: "$phoneNo"
          password: "$password"
          state: "$state"
          fcmToken:"$fcmToken"
          userTypeId: ${int.parse(userTypeId.toString())}
          userType: ${int.parse(userType.toString())}
          profilepic: "$profilepic"
          orgName: "$orgName"
          orgType:"$orgType"
          ministryName: "$ministryName"
          hod: "$hod"
          latitude: ${double.parse(latitude.toString())}
          longitude: ${double.parse(longitude.toString())}
          yearExp:"$yearExp"
          shopName: "$shopName"
        ) {
          token
          customer {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            userTypeId
            status
            jwtToken
            fcmToken
            otpCode
            isProfile
            otpVerified
          }
          mechanic {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            userTypeId
            jwtToken
            fcmToken
            otpCode
            isProfile
            otpVerified
            status
          }
          vendor {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            userTypeId
            status
            jwtToken
            fcmToken
            otpCode
            isProfile
            otpVerified
          }
          generalCustomer {
            id
            custType
            orgName
            orgType
            userId
            profilePic
            state
            ministryName
            hod
            status
          }
          genMechanic {
            id
            orgName
            orgType
            yearExp
            mechType
            userId
            profilePic
            state
            status
          }
          genVendor {
            id
            userId
            profilePic
            state
            shopName
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
      token, brand, model, engine, year,
      plateNo, lastMaintenance, milege,
      vehiclePic, latitude, longitude,
      ) async {
          String _query = """ 
         mutation {
            vehicleCreate(
              brand: "$brand"
              model: "$model"
              engine: "$engine"
              year: "$year"
              plateNo: "$plateNo"
              lastMaintenance: "$lastMaintenance"
              milege: "$milege"
              vehiclePic: "$vehiclePic"
              latitude: ${double.parse(latitude.toString())}
              longitude: ${double.parse(longitude.toString())}
            ) {
              id
              brand
              model
              engine
              year
              plateNo
              lastMaintenance
              milege
              vehiclePic
              latitude
              longitude
              defaultVehicle
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
    {
      brandDetails {
        id
        brandName
        status
        brandicon
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
   {
      modelDetails(id: null) {
        id
        modelName
        engineName
        years
        brandName
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


  postPhoneLoginOtpVerificationRequest(
      token,
      otp,
      userTypeId) async {
      String _query = """ 
         mutation {
            signIn_Otp(otp: "$otp", userTypeId: ${int.parse(userTypeId.toString())}) {
              token
              user {
                id
                userCode
                firstName
                lastName
                emailId
                phoneNo
                status
                userTypeId
                jwtToken
                fcmToken
                otpCode
                isProfile
                otpVerified
              }
            }
          }
      """;
      log(_query);
      return await GqlClient.I.mutation11(_query,
          enableDebug: true,token: token, isTokenThere: true, variables: {});
  }

  postOtpVerificationRequest(
      token,
      otp,
      userTypeId) async {
    String _query = """ 
       mutation {
          otp_Verification(otpCode: "$otp", userTypeId: ${int.parse(userTypeId.toString())}) {
            verified
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
          status
          userId
        }
        mechanicVehicle {
          id
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


  postSearchServiceRequest(
      token,
      search,
      count,
      categoryId) async {
    String _query = """ 
     query
      {
        serviceListAll(search: "$search",count: null, categoryId: null) {
          id
          serviceName
          description
          icon
          minAmount
          maxAmount
          type
          status
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
    description
    icon
    minAmount
    maxAmount
    type
    status
    categoryId
    category {
      id
      categoryName
      icon
      status
    }
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

  selectCar() {}

  completeProfileMechanicIndividual(String token,
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

  completeProfileMechanicCorporate(
      String token,
      String serviceType,
      String vehicleSpecialization,
      String address,
      String mechanicNumber,
      String rcNumber,
      String existenceYear
      ) async {
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

  forgotPassword(String email) async {
    String _query = """
          mutation {
      ForgotPassword(emailId: "$email", platformId: 1) {
        otpCode
        userId
        userTypeId
        phoneNo
      }
    }
     """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  createPassword(String otp,String newPswd, String confirmPswd ) async {
    String _query = """
        mutation {
      ResetPassword(
        otp: "$otp"
        newPassword: "$newPswd"
        confirmPassword: "$confirmPswd"
      ) {
        status
        code
        message
      }
    }
     """;
    log(_query);
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  changePassword(String token, String email,String oldPswd, String newPswd, String confirmPswd ) async {
    String _query = """
      mutation {
    ChangePassword(
      emailId: "$email"
      password: "$oldPswd"
      newPassword: "$newPswd"
      confirmPassword: "$confirmPswd"
    ) {
      status
      code
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

  postCustFetchProfileRequest(
      token) async {
    String _query = """ 
     query
     {
        customer_Details(jwtToken: "$token") {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            accountType
            status
            jwtToken
            fcmToke
            otpCode
            customer 
                    {
                    id
                    custType
                    orgName
                    orgType
                    userId
                    profilePic
                    state
                    ministryName
                    hod
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

  postCustVehicleListRequest(
      token) async {
    String _query = """ 
     query
     {
        Cust_vehicle_list {
          id
          year
          brand
          model
          engine
          plateNo
          milege
          lastMaintenance
          latitude
          longitude
          vehiclePic
          userId
          status
          defaultVehicle
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
