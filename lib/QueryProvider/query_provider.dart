import 'dart:developer';

import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:intl/intl.dart';

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
      token, date, time,
      latitude, longitude,
      serviceId, mechanicId, reqType,
      totalPrice, paymentType, travelTime) async {
    String _query = """  
    mutation {
      mechanicBooking(
        bookedDate: "$date"
        bookedTime: "$time"
        latitude: ${double.parse(latitude.toString())}
        longitude: ${double.parse(longitude.toString())}
        serviceId: $serviceId
        mechanicId: $mechanicId
        reqType: $reqType
        totalPrice: $totalPrice
        paymentType: $paymentType
        travelTime:  $travelTime
          ) {
            id
        bookedDate
        bookedTime
        latitude
        longitude
        customerId
        mechanicId
        status
        isAccepted
        isCompleted
        vehicleId
        totalPrice
        tax
        commission
        serviceCharge
        totalTime
          }
        }
    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true,token: token, isTokenThere: true, variables: {});
  }

  /// =============== Mechanics List Emergency ================== ///

  postFindMechanicsListEmergencyRequest(
      token,
      page,
      size,
      latitude,
      longitude,
      serviceId,
      serviceType) async {
    String _query = """ 
      {
        mechanicList(
          page: ${int.parse(page.toString())}
          size:  ${int.parse(size.toString())}
          serviceId: "$serviceId"
          latitude: "9.2575"
          longitude: "76.4508"
        ) {
          totalItems
          data {
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
            mechanic {
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
             mechanicStatus {
                  distance
                }
            mechanicService {
                id
                fee
                service {
                  id
                  serviceName
                  description
                  icon
                  minPrice
                  maxPrice
                  categoryId
                  status
                }
                status
                userId
              }
            totalAmount
            distance
            duration
            reviewCount
             mechanicReviewsData {
                id
                transType
                rating
                feedback
                bookingId
                orderId
                status
                order {
                  id
                  oderCode
                  qty
                  totalPrice
                  commision
                  tax
                  paymentType
                  status
                  vendorId
                  customerId
                }
                bookings {
                  id
                  latitude
                  longitude
                  customerId
                  mechanicId
                  status
                  vehicleId
                  totalPrice
                  tax
                  commission
                  serviceCharge
                  totalTime
                }
                productData {
                  id
                  productCode
                  productName
                  price
                  shippingCharge
                  productImage
                  description
                  status
                  vehicleModelId
                  vendorId
                  reviewCount
                  avgRate
                  salesCount
                }
              }
            mechanicReview
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

  /// =============== Mechanics Profile Details ================== ///

  fetchMechanicProfileDetails(
      token,
      mechanicId,
      serviceId,
      latitude,
      longitude,) async {
    String _query = """
            {
              mechanicDetails(
                 mechanicId: ${int.parse(mechanicId)}
                 serviceId: "${serviceId.toString()}"
                latitude: "9.2575"
                longitude: "76.4508"
              ) {
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
                mechanic {
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
                mechanicStatus {
                  distance
                }
                mechanicService {
                  id
                  fee
                   service {
                      id
                      serviceName
                      description
                      icon
                      minPrice
                      maxPrice
                      categoryId
                      status
                    }
                  status
                  userId
                }
                totalAmount
                distance
                duration
                reviewCount
                mechanicReviewsData {
                  id
                  transType
                  rating
                  feedback
                  bookingId
                  orderId
                  status
                }
                mechanicReview
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


  postSearchServiceRequest(
      token,
      search,
      count,
      categoryId) async {
    String _query = """ 
    query
    {
        serviceListAll(search: "$search", count: null, categoryId: null) {
          id
          serviceName
          description
          icon
          minPrice
          maxPrice
          categoryId
          status
          category {
            id
            catType
            catName
            icon
            status
            service{
              serviceName
              status
              description
              id
              icon
              minPrice
              maxPrice
            }
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

  postMechanicMyWalletRequest(String token, ) async {
    String _query = """
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

//-------------------------- remove after merge on 11/04/2022-----------------------------------------
  serviceList(String token, searchText, count, categoryId ) async {
    String _query = """
    {
      serviceListAll(search: $searchText, count: $count, categoryId: $categoryId) {
        id
        serviceName
        description
        icon
        minPrice
        maxPrice
        categoryId
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

  categoryList(String token, searchText, count, categoryId ) async {
    String _query = """
    {
    category_list(catType: $categoryId) {
      id
      catType
      catName
      icon
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
//-------------------------- remove after merge on 11/04/2022-----------------------------------------

  serviceListWithCategory(String token, categoryType ) async {
    String _query = """
    {
      category_list(catType: $categoryType) {
        id
        catType
        catName
        icon
        status
        service {
          id
          serviceName
          description
          icon
          minPrice
          maxPrice
          categoryId
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
      String address,String apprentice_cert, String identification_cert, String photoUrl) async {
    String _query = """
        mutation {
      mechanic_work_selection_Individual(
        workType: "$workSelection"
        vehicle: "$vehicleSpecialization"
        address: "$address"
        apprentice_cert: "$apprentice_cert"
        identification_cert: "$identification_cert"
        profilePic: "$photoUrl"
      ) {
        id
        workType
        brands
        apprentice_cert
        profilePic
        address
        identification_cert
        numMech
        rcNumber
        yearExist
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
      String existenceYear,
      String photoUrl
      ) async {
    String _query = """ 
    mutation {
  mechanic_work_selection_Corporate(
    workType: "$serviceType"
    vehicle: "$vehicleSpecialization"
    address: "$address"
    numMech: "$mechanicNumber"
    rcNumber: "$rcNumber"
    yearExist: "$existenceYear"
    profilePic: "$photoUrl"
  ) {
    id
    workType
    brands
    apprentice_cert
    profilePic
    address
    identification_cert
    numMech
    rcNumber
    yearExist
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

  categoryListHome(String token,  categoryId ) async {
    String _query = """
      {
      category_list(catType: $categoryId) {
        id
        catType
        catName
        icon
        status
        service {
          id
          serviceName
          description
          icon
          minPrice
          maxPrice
          categoryId
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

  postMechanicOnlineOfflineRequest(
      token, String status, String mechanicId) async {
    String _query = """
    mutation {
    mechanicWorkStatusUpdate(status: $status, mechanicId: $mechanicId) {
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

  postMechanicLocationUpdateRequest(
      token,lat,lng) async {
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

  postMechanicBrandSpecializationRequest(
      token,brandName) async {
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

  postCustIndividualEditProfileRequest(
    String token, firstName,  lastName,  state, status, imageUrl) async {
    String _query = """  
      mutation {
      customer_Individual_profile_update(
        firstName: "$firstName"
        lastName: "$lastName"
        state: "$state"
        status: $status
        profilepic: "$imageUrl"
      ) {
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

  postCustCorporateEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl, orgName, orgType) async {
    String _query = """  
     mutation {
  customer_Corporate_profile_update(
      firstName: "$firstName"
      lastName: "$lastName"
      state: "$state"
      status: $status
      profilepic: "$imageUrl"
      org_name: "$orgName"
      org_type: "$orgType"
    ) {
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

  postCustGovernmentEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl, ministryName) async {
    String _query = """  
     mutation {
      customer_GovtBodies_profile_update(
        firstName: "$firstName"
        lastName: "$lastName"
        state: "$state"
        profilepic: "$imageUrl"
        status: $status
        ministry_name: "$ministryName"
      ) {
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


  postMechanicFetchProfileRequest(
      token) async {
    String _query = """ 
      query
      {
        mechanic_Details(jwtToken: "$token") {
          id
          userCode
          firstName
          lastName
          emailId
          phoneNo
          userTypeId
          accountType
          jwtToken
          status
          mechanic {
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
          mechanicService {
            id
            fee
            status
            service{
              serviceName
              description
              minPrice
              maxPrice
              categoryId
              id
              icon
            }
            userId
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

  postMechanicEditProfileIndividualRequest(token, firstName, lastName, state, profilepic,
      status, year_of_experience,) async {
    String _query = """  
      mutation {
          mechanic_signUp_Individual_Update(
           firstName: "$firstName"
            lastName: "$lastName"
            state: "$state"
            profilepic: "$profilepic"
            status: 1
            year_of_experience: "$year_of_experience"
          ) {
            message
          }
        }
 
    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true,token: token, isTokenThere: true, variables: {});
  }

  postMechanicEditProfileCorporateRequest(token, firstName, lastName, state, profilepic,
      status, year_of_experience, org_Name, org_Type,) async {
    String _query = """  
      mutation {
          mechanic_signUp_Corporate_Update(
            firstName: "$firstName"
            lastName: "$lastName"
            state: "$state"
            profilepic: "$profilepic"
            status: 1
            year_of_experience: "$year_of_experience"
            org_Name: "$org_Name"
            org_Type: "$org_Type"
          ) {
            message
          }
        }
 
    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true,token: token, isTokenThere: true, variables: {});
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


  postCatListBothRequest(
      token,type) async {
    String _query = """ 
     query
     {
        category_list(catType: $type) {
          id
          catType
          catName
          icon
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


  postserviceListAllBothRequest(
      token,type) async {
    String _query = """ 
     query
     {
        serviceListAll(search: null, count: null, categoryId: $type) {
          id
          serviceName
          description
          icon
          minPrice
          maxPrice
          categoryId
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

}
