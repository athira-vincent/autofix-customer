import 'dart:developer';

import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      customer{
        id
        
      }
      mechanic{
        id
      }
      vendor{
        id
      }
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
      workType
      numMech
      rcNumber
      address
      apprentice_cert
      identification_cert
      yearExist
      rate
      reviewCount
      adminApprove
      userId
      profilePic
      state
      status
      brands
    }
    genVendor {
      id
      userId
      profilePic
      state
      shopName
      productCount
      orderCount
      totalEarning
      status
    }
  }
}
    """;
    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  socialLogin(email, phoneNumber) async {
    String _query;
    if (email != "") {
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
          customer{
            id
          }
          mechanic{
            id
          }
          vendor{
            id
          }
        }
        genCustomer {
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
          workType
          numMech
          rcNumber
          address
          apprentice_cert
          identification_cert
          yearExist
          rate
          reviewCount
          adminApprove
          userId
          profilePic
          state
          status
          brands
        }
        genVendor {
          id
          userId
          profilePic
          state
          shopName
          productCount
          orderCount
          totalEarning
          status
        }
      }
    }      
     """;
    } else {
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
          customer{
            id
          }
          mechanic{
            id
          }
          vendor{
            id
          }
        }
        genCustomer {
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
          workType
          numMech
          rcNumber
          address
          apprentice_cert
          identification_cert
          yearExist
          rate
          reviewCount
          adminApprove
          userId
          profilePic
          state
          status
          brands
        }
        genVendor {
          id
          userId
          profilePic
          state
          shopName
          productCount
          orderCount
          totalEarning
          status
        }
      }
    } 
    """;
    }

    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  phoneLogin(phoneNumber) async {
    String _query = """
        mutation {
          signIn_phoneNo(phoneNo: "$phoneNumber", platformId: 1) {
            otp
            phoneNo
            id
            lastName
            fcmToken
            firstName
            emailId
            status
            userTypeId
            jwtToken
          }
        }

    """;

    return await GqlClient.I.mutation(_query,
        enableDebug: true, isTokenThere: false, variables: {});
  }

  signUp(
    type,
    firstName,
    lastName,
    emailId,
    phoneNo,
    password,
    state,
    fcmToken,
    userTypeId,
    userType,
    profilepic,
    orgName,
    orgType,
    ministryName,
    hod,
    latitude,
    longitude,
    yearExp,
    shopName,
  ) async {
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

  postBrandDetailsRequest(token, search) async {
    String _query = """ 
       {
        brandList(page: 0, size: 300, search: "$search") {
          totalItems
          data {
            id
            brandName
            icon
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

  postAddCarRequest(
    token,
    brand,
    model,
    engine,
    year,
    plateNo,
    lastMaintenance,
    milege,
    vehiclePic,
    color,
    latitude,
    longitude,
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
              color: "$color"
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
              color
              latitude
              longitude
              defaultVehicle
              status
              userId
            }
          }
  
          """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true, token: token, isTokenThere: true, variables: {});
  }

  postUpdateDefaultVehicle(token, vehicleId, customerId) async {
    String _query = """ 
        mutation {
          updateDefaultVehicle(vehicleId: ${int.parse(vehicleId.toString())}, customerId: ${int.parse(customerId.toString())}) {
            message
          }
        }
          """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true, token: token, isTokenThere: true, variables: {});
  }

  postMakeBrandRequest(
    token,
  ) async {
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

  postModelDetailRequest(token, type) async {
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

  postPhoneLoginOtpVerificationRequest(token, otp, userTypeId) async {
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
        enableDebug: true, token: token, isTokenThere: true, variables: {});
  }

  postOtpVerificationRequest(token, otp, userTypeId) async {
    String _query = """ 
       mutation {
          otp_Verification(otpCode: "$otp", userTypeId: ${int.parse(userTypeId.toString())}) {
            verified
          }
        }

    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true, token: token, isTokenThere: true, variables: {});
  }

  /// =============== Mechanics List Emergency ================== latitude: "9.2575"  longitude: "76.4508"///

  postFindMechanicsListEmergencyRequest(
      token, page, size, latitude, longitude, serviceId, serviceType) async {
    String _query = """ 
          {
            mechanicList(
                    page: ${int.parse(page.toString())}
                    size:  ${int.parse(size.toString())}
                    serviceId: "$serviceId"
                     latitude: "$latitude"
                    longitude: "$longitude"
                    
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
                      usersId
                      yearExp
                      profilePic
                      mechType
                      workType
                      noMech
                      state
                      rcNumber
                      brands
                      address
                      certificate1
                      certificate2
                      status
                      rate
                      reviewCount
                    }
                mechanicStatus {
                    distance
                    latitude
                    longitude
                    workStatus
                  }
                  mechanicService {
                      id
                      fee
                      time
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
                    bookingCode
                    reqType
                    bookStatus
                    totalPrice
                    tax
                    commission
                    serviceCharge
                    totalTime
                    serviceTime
                    latitude
                    longitude
                    extend
                    totalExt
                    extendTime
                    bookedDate
                    isRated
                    status
                    customerId
                    mechanicId
                    vehicleId
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
                bookingsCount
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
    longitude,
  ) async {
    String _query = """
                {
                  mechanicDetails(
                     mechanicId: ${int.parse(mechanicId)}
                     serviceId: "${serviceId.toString()}"
                     latitude: "$latitude"
                     longitude: "$longitude"
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
                        usersId
                        yearExp
                        profilePic
                        mechType
                        workType
                        noMech
                        state
                        rcNumber
                        brands
                        address
                        certificate1
                        certificate2
                        status
                        rate
                        reviewCount
                      }
                      mechanicStatus {
                        distance
                        latitude
                        longitude
                        workStatus
                      }
                      mechanicService {
                        id
                        fee
                        time
                        service{
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
                        serviceId
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
                        order{
                          id
                          oderCode
                        }
                        orderId
                        status
                        bookings{
                          id
                          bookingCode
                          customer{
                            fcmToken
                            firstName
                            phoneNo
                            lastName
                            customer{
                              profilePic
                            }
                          }
                        }
                        productData{
                          id
                          productCode
                          productName
                        }
                      }
                      mechanicReview
                      bookingsCount
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

  /// =============== Mechanics Regular Service Booking Id  ================== ///

  postMechanicsRegularServiceBookingIDRequest(
      token,
      date,
      time,
      latitude,
      longitude,
      serviceId,
      mechanicId,
      reqType,
      regularServiceType,
      totalPrice,
      paymentType,
      travelTime) async {
    String _query = """  
    mutation {
        mechanicBooking(
            bookedDate: "$date"
            bookedTime: "$time"
            latitude: ${double.parse(latitude.toString())}
            longitude: ${double.parse(longitude.toString())}
            serviceId: $serviceId
            mechanicId: ${int.parse(mechanicId.toString())}
            reqType: ${int.parse(reqType.toString())}
            regularType: ${int.parse(regularServiceType.toString())}
            paymentType: 1
            travelTime: "" )
            {
            id
            bookingCode
            reqType
            bookStatus
            totalPrice
            tax
            commission
            serviceCharge
            totalTime
            serviceTime
            latitude
            longitude
            mechLatitude
            mechLongitude
            extend
            totalExt
            extendTime
            bookedDate
            bookedTime
            isRated
            status
            customerId
            mechanicId
            vehicleId
            regularType
            mechanic {
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
              customer{
                id
              }
              mechanic{
                id
              }
              vendor{
                id
              }
            }
            customer {
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
              customer{
                id
              }
              mechanic{
                id
              }
              vendor{
                id
              }
            }
            vehicle {
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
              userId
            }
            bookService {
              id
              mechanicId
              customerId
              status
              serviceId
              bookMechanicId
              service{
                id
              }
            }
          }
        }
    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true, token: token, isTokenThere: true, variables: {});
  }

  /// =============== Mechanics Emergency Service Booking Id  ================== ///

  postMechanicsEmergencyServiceBookingIDRequest(
      token,
      date,
      time,
      latitude,
      longitude,
      serviceId,
      mechanicId,
      reqType,
      totalPrice,
      paymentType,
      travelTime) async {
    String _query = """  
    mutation {
        emergencyBooking(
              bookedDate: "$date"
              bookedTime: "$time"
              latitude: ${double.parse(latitude.toString())}
              longitude: ${double.parse(longitude.toString())}
              serviceId: ${int.parse(serviceId.toString())}
              mechanicId:${int.parse(mechanicId.toString())}
              reqType: ${int.parse(reqType.toString())}
              paymentType: ${int.parse(paymentType.toString())}
              travelTime:  ""
          ) {
            id
            bookingCode
            reqType
            bookStatus
            totalPrice
            tax
            commission
            serviceCharge
            totalTime
            serviceTime
            latitude
            longitude
            mechLatitude
            mechLongitude
            extend
            totalExt
            extendTime
            bookedDate
            isRated
            status
            customerId
            mechanicId
            vehicleId
            mechanic {
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
            customer {
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
            vehicle {
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
              userId
            }
            bookService {
              id
              mechanicId
              customerId
              status
              serviceId
              bookMechanicId
            }
          }
        }

    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true, token: token, isTokenThere: true, variables: {});
  }

  /// =============== Update Mechanic Booking Id  ================== ///

  postUpdateMechanicsBookingIDRequest(
    token,
    bookingId,
    mechanicId,
  ) async {
    String _query = """  
        mutation {
          updateMechanicBooking(
          bookingId: ${int.parse(bookingId.toString())}, 
          mechanicId: ${int.parse(mechanicId.toString())}) {
            status
            code
            message
          }
        }
    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true, token: token, isTokenThere: true, variables: {});
  }

  /// ===============  Booking Details  ================== ///

  postBookingDetailsRequest(
    token,
    bookingId,
  ) async {
    String _query = """        
      {
        bookingDetails(bookingId: ${int.parse(bookingId.toString())}) {
          id
          bookedDate
          bookedTime
          latitude
          longitude
          demoMechanicId
          customerId
          status
          vehicleId
          serviceId
          bookService {
            id
            mechanicId
            customerId
            status
            serviceId
            bookMechanicId
          }
          vehicle {
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
          mechanic {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            accountType
            status
            jwtToken
            fcmToken
            otpCode
          }
          customer {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            accountType
            status
            jwtToken
            fcmToken
            otpCode
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
      token, serviceSearch, catSearch, count, categoryId) async {
    String _query;

    if (catSearch != null && serviceSearch != null) {
      _query = """ 
    query
    {
        serviceListAll(serviceSearch: "$serviceSearch", catSearch: "$catSearch", count: $count, categoryId: $categoryId) {
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
    } else if (serviceSearch != null) {
      _query = """ 
    query
    {
        serviceListAll(serviceSearch: "$serviceSearch", catSearch: null, count: $count, categoryId: $categoryId) {
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
    } else if (catSearch != null) {
      _query = """ 
    query
    {
        serviceListAll(serviceSearch: null, catSearch: "$catSearch", count: $count, categoryId: $categoryId) {
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
    } else {
      _query = """ 
    query
    {
        serviceListAll(serviceSearch: null, catSearch: null, count: $count, categoryId: $categoryId) {
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
    }
    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  /// ===============  Service List of Mechanic ================== ///

  fetchServiceListOfMechanic(token, mechanicId, page, size, search) async {
    String _query = """
                {
                 mechanicServicesList(
                   mechanicId: ${int.parse(mechanicId.toString())}, 
                   page: ${int.parse(page.toString())}, 
                   size: ${int.parse(size.toString())}, 
                   search: "$search") 
                  {
                    totalItems
                    data 
                    {
                      id
                      fee
                      time
                       service 
                       {
                          id
                          serviceName
                          serviceCode
                          description
                          icon
                          minPrice
                          maxPrice
                          categoryId
                          status
                          category 
                          {
                              id
                              catType
                              catName
                              icon
                              status
                            }
                       }
                      status
                      userId
                      serviceId
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

  fcmTokenUpdate(String fcmToken, String Authtoken) async {
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

  postMechanicMyWalletRequest(String token, mechanicId) async {
    String _query = """
      mutation {
   myWallet(
    dayStart: "2022-07-07"
    dayEnd: "2022-07-07"
    monthStart: "2022-07-01"
    monthEnd: "2022-07-31"
    mechanicId: $mechanicId
  ) {
    jobCount
    monthlySum
    totalPayment
    bookingData {
      id
      bookingCode
      reqType
      bookStatus
      totalPrice
      tax
      commission
      serviceCharge
      totalTime
      serviceTime
      latitude
      longitude
      extend
      totalExt
      extendTime
      bookedDate
      bookedTime
      isRated
      status
      regularType
      mechLatitude
      mechLongitude
      demoMechanicId
      customerId
      vehicleId
      serviceId
      mechanic{
        id
        mechanic{
          profilePic
        }
      }
      customer{
        id
        firstName
        customer{
          profilePic
        }
      }
    }
    payArr {
      id
      transType
      amount
      paymentType
      transId
      status
      createdAt
      updatedAt
      bookingId
      orderId
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

  postMechanicMyJobReviewRequest(String token, mechanicId) async {
    String _query = """
{
  mechanicReviewList(mechanicId: $mechanicId) {
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
      usersId
      yearExp
      profilePic
      mechType
      workType
      noMech
      state
      rcNumber
      brands
      address
      certificate1
      certificate2
      status
      rate
      reviewCount
    }
    mechanicStatus {
      distance
      latitude
      longitude
      workStatus
    }
    mechanicService {
      id
      fee
      time
      service
      {id 
        serviceName}
      status
      userId
      serviceId
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
      order{id}
      bookings{id 
        customer{id
          firstName
        customer{profilePic
        }
        }
        bookService{
          service{id 
            serviceName
          }}
      }
      productData{id}
    }
    mechanicReview
    bookingsCount
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
  serviceList(String token, searchText, count, categoryId) async {
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

  categoryList(String token, searchText, count, categoryId) async {
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

  serviceListWithCategory(
      String token, categoryType, String search, String catSearch) async {
    String _query;
    if (search.isEmpty && catSearch.isEmpty) {
      _query = """
        {
      category_list(catType: $categoryType, serviceSearch: null, catSearch: null) {
        id
        catType
        catName
        icon
        status
        service {
          id
          serviceName
          serviceCode
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
    } else if (search.isEmpty) {
      _query = """
        {
      category_list(catType: $categoryType, catSearch: "$catSearch", serviceSearch: null) {
        id
        catType
        catName
        icon
        status
        service {
          id
          serviceName
          serviceCode
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
    } else if (catSearch.isEmpty) {
      _query = """
        {
      category_list(catType: $categoryType, catSearch: null, serviceSearch: "$search") {
        id
        catType
        catName
        icon
        status
        service {
          id
          serviceName
          serviceCode
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
    } else {
      _query = """
        {
      category_list(catType: $categoryType, catSearch: "$catSearch", serviceSearch: "$search") {
        id
        catType
        catName
        icon
        status
        service {
          id
          serviceName
          serviceCode
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
    }

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

  completeProfileMechanicIndividual(
      String token,
      String workSelection,
      String vehicleSpecialization,
      String address,
      String apprentice_cert,
      String identification_cert,
      String photoUrl) async {
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
      String photoUrl) async {
    print(
        'completeProfileMechanicCorporate>>>>>>  $serviceType   $vehicleSpecialization $address, $mechanicNumber, $rcNumber, $existenceYear$photoUrl');

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

  createPassword(String otp, String newPswd, String confirmPswd) async {
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

  changePassword(String token, String email, String oldPswd, String newPswd,
      String confirmPswd) async {
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

  mechanicAddServiceList(String token, String serviceList, String costList,
      String timeList, catType) async {
    String _query = """ 
    mutation {
      mechanic_service_add(catType: $catType, services: "$serviceList", fee: $costList, time: $timeList) {
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

  categoryListHome(String token, categoryId, serviceSearch, catSearch) async {
    String _query;

    if (catSearch != null && serviceSearch != null) {
      _query = """
      {
      category_list(serviceSearch: "$serviceSearch", catSearch: "$catSearch", catType: $categoryId) {
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
    } else if (catSearch != null) {
      _query = """
      {
      category_list(serviceSearch: null, catSearch: "$catSearch", catType: $categoryId) {
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
    } else if (serviceSearch != null) {
      _query = """
      {
      category_list(serviceSearch: "$serviceSearch", catSearch: null, catType: $categoryId) {
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
    } else {
      _query = """
      {
      category_list(serviceSearch: null, catSearch: null, catType: $categoryId) {
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
    }

    log(_query);
    print("Token >>>>>>> $token");
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  postCustFetchProfileRequest(token, id) async {
    String _query = """ 
     query
     {
        customer_Details(id: $id) {
            id
            userCode
            firstName
            lastName
            emailId
            phoneNo
            accountType
            status
            jwtToken
            fcmToken
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

  postMechanicLocationUpdateRequest(token, mechanicId, lat, lng) async {
    String _query = """
    mutation {
    mechanic_location_update(
      latitude: $lat
      longitude: $lng
      mechanicId: $mechanicId
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

  postMechanicBrandSpecializationRequest(token, brandName) async {
    String _query = """
      {
    brandDetails(brandName: "$brandName") {
      id
      brandName
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

  postMechanicUpcomingServiceRequest(token, type, mechanicId) async {
    String _query;
    if (type.toString() == "undefined") {
      _query = """
      {
      UpcomingCompletedServices(type: null, mechanicId: $mechanicId) 
        {
          id
          bookingCode
          reqType
          bookStatus
          totalPrice
          tax
          commission
          serviceCharge
          totalTime
          serviceTime
          latitude
          longitude
          mechLatitude
          mechLongitude
          extend
          totalExt
          extendTime
          bookedDate
          bookedTime
          isRated
          status
          customerId
          mechanicId
          vehicleId
          regularType
          mechanic {
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
            customer{
              id
            }
            mechanic{
              id
            }
            vendor{
              id
            }
          }
          customer {
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
            customer{
              id
            }
            mechanic{
              id
            }
            vendor{
              id
            }
          }
          vehicle {
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
            userId
          }
          bookService {
            id
            mechanicId
            customerId
            status
            serviceId
            bookMechanicId
            service{
              id
              serviceName
              minPrice
            }
          }
        }
    }
    """;
    } else {
      _query = """
      {
      UpcomingCompletedServices(type: $type, mechanicId: $mechanicId) {
        id
        bookingCode
        reqType
        bookStatus
        totalPrice
        tax
        commission
        serviceCharge
        totalTime
        serviceTime
        latitude
        longitude
        mechLatitude
        mechLongitude
        extend
        totalExt
        extendTime
        bookedDate
        bookedTime
        isRated
        status
        customerId
        mechanicId
        vehicleId
        regularType
        mechanic {
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
          customer{
            id
          }
          mechanic{
            id
          }
          vendor{
            id
          }
        }
        customer {
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
          customer{
            id
          }
          mechanic{
            id
          }
          vendor{
            id
          }
        }
        vehicle {
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
          userId
        }
        bookService {
          id
          mechanicId
          customerId
          status
          serviceId
          bookMechanicId
          service{
            id
            serviceName
            minPrice
          }
        }
      }
    }
    """;
    }

    log(_query);
    return await GqlClient.I.query01(
      _query,
      token,
      enableDebug: true,
      isTokenThere: true,
    );
  }

  postMechanicActiveServiceRequest(token, mechanicId) async {
    String _query = """
     mutation {
  currentlyWorkingService(mechanicId: $mechanicId) {
        id
        bookingCode
        reqType
        bookStatus
        totalPrice
        tax
        commission
        serviceCharge
        totalTime
        serviceTime
        latitude
        longitude
        extend
        totalExt
        extendTime
        bookedDate
        isRated
        status
        customerId
        mechanicId
        vehicleId
        mechanic {
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
          mechanic{
            id
          }
          customer{
            id
          }
        }
        customer {
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
          mechanic{
            id
          }
          customer{
            id
          }
        }
        vehicle {
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
        bookService {
          id
          status
          service{
            id
            serviceName
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
      isTokenThere: true,
    );
  }

  postMechanicIncomingJobUpdateRequest(token, bookingId, bookStatus) async {
    String _query = """
     mutation {
    acceptRejectRequest(bookingId: $bookingId, bookStatus: $bookStatus) {
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

  postMechanicOrderStatusUpdate(
    token,
    bookingId,
    bookStatus,
  ) async {
    String _query = """
     mutation {
      mechanic_status_update(state: $bookStatus, bookId: $bookingId) {
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

  postMechanicAddTimeUpdateRequest(
    token,
    extendTime,
    bookingId,
  ) async {
    String _query = """
     mutation {
    timeUpdateBooking(extendTime: "$extendTime", bookingId: $bookingId) {
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

  postCustomerAddMoreServiceUpdate(
      token, bookingId, serviceIds, totalPrice, travelTime) async {
    String _query = """
     mutation {
      addAdditionalServices(bookingId: $bookingId, serviceId: $serviceIds , totalPrice: $totalPrice, travelTime: $travelTime) {
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

  postCustIndividualEditProfileRequest(
      String token, firstName, lastName, state, status, imageUrl) async {
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

  postCustCorporateEditProfileRequest(String token, firstName, lastName, state,
      status, imageUrl, orgName, orgType) async {
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

  postCustGovernmentEditProfileRequest(String token, firstName, lastName, state,
      status, imageUrl, ministryName) async {
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

  postMechanicFetchProfileRequest(token, userId) async {
    String _query = """ 
    {
  mechanic_Details(id: $userId) {
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
      workType
      rcNumber
      address
      apprentice_cert
      identification_cert
      yearExist
      rate
      reviewCount
      userId
      profilePic
      state
      status
      brands
    }
    mechanicService {
      id
      fee
      time
      service{
        id
        serviceName
      }
      status
      userId
      serviceId
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

  postMechanicEditProfileIndividualRequest(
    token,
    firstName,
    lastName,
    state,
    profilepic,
    status,
    year_of_experience,
  ) async {
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
        enableDebug: true, token: token, isTokenThere: true, variables: {});
  }

  postMechanicEditProfileCorporateRequest(
    token,
    firstName,
    lastName,
    state,
    profilepic,
    status,
    year_of_experience,
    org_Name,
    org_Type,
  ) async {
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
        enableDebug: true, token: token, isTokenThere: true, variables: {});
  }

  postAddMechanicReviewAndRatingRequest(
    token,
    rating,
    feedback,
    bookingId,
  ) async {
    String _query = """ 
    mutation {
        addRating(rating: ${double.parse(rating.toString())}, feedback: "$feedback", bookingId: ${int.parse(bookingId.toString())},  bookingType: 1) {
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

  postCustVehicleListRequest(token) async {
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
          color
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

  postserviceListAllBothRequest(token, type) async {
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

  // 23/05/2022**********add price and fault**********

  postAddPriceFaultReviewRequest(token, mechanicId) async {
    String _query = """ 
     query
     {
  mechanic_Details(id: $mechanicId) {
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
      workType
      numMech
      rcNumber
      address
      apprentice_cert
      identification_cert
      yearExist
      rate
      reviewCount
      userId
      profilePic
      state
      status
      brands
    }
    mechanicService {
      service{
        serviceName
      }
      id
      fee
      time
      status
      userId
      serviceId
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

  postUpdateAddPriceFaultReviewRequest(
      token, mechanicId, time, fee, serviceId) async {
    String _query = """  
      mutation  {
        updateTimeFees(time: "$time", fee: "$fee", mechanicId: $mechanicId, serviceId: $serviceId) {
          message
        }
      }
    """;
    log(_query);
    return await GqlClient.I.mutation11(_query,
        enableDebug: true, token: token, isTokenThere: true, variables: {});
  }

  postEmrgRegAddPriceReviewRequest(
      token, page, size, search, userId, catType) async {
    String _query = """ 
     query
     {
  addPriceServiceList(
    page: $page
    size: $size
    search: "$search"
    userId: $userId
    catType: $catType
  ) {
    totalItems
    data {
      id
      serviceCode
      serviceName
      minPrice
      maxPrice
      icon
      status
      categoryId
      category{id}
      mechanicService{
        id
        time
        fee
      }
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

  postVechicleUpdateRequest(token, id, status) async {
    String _query = """ 
     mutation {
        vehicle_Update(
          id: ${int.parse(id.toString())}
          status: 0
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

  postCustomerCompletedOrdersRequest(token, count, recent, customerId) async {
    String _query = """ 
     {
        cust_completed_orders(count: 300, recent: ${recent == null ? null : int.parse(recent.toString())}, customerId: ${int.parse(customerId.toString())}) 
        {
          id
          bookingCode
          reqType
          regularType
          bookStatus
          totalPrice
          tax
          commission
          serviceCharge
          totalTime
          serviceTime
          latitude
          longitude
          mechLatitude
          mechLongitude
          extend
          totalExt
          extendTime
          bookedDate
          bookedTime
          isRated
          status
          customerId
          mechanicId
          vehicleId
          mechanic {
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
          customer {
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
          vehicle {
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
            userId
          }
          bookService {
            id
            mechanicId
            customerId
            status
            serviceId
            service
            {
              serviceName
              serviceCode
              description
              id
              minPrice
              maxPrice
              icon
              categoryId
            }
            bookMechanicId
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

  postMechServiceDetailsRequest(token, bookingId) async {
    String _query = """
      {
    bookingDetails(bookingId: $bookingId) {
      id
      bookingCode
      reqType
      bookStatus
      totalPrice
      tax
      commission
      serviceCharge
      totalTime
      serviceTime
      latitude
      longitude
      extend
      totalExt
      extendTime
      bookedDate
      bookedTime
      isRated
      status
      regularType
      mechLatitude
      mechLongitude
      demoMechanicId
      customerId
      vehicleId
      serviceId
      bookService {
        id
        mechanicId
        customerId
        status
        serviceId
        bookMechanicId
        service{
          id
          serviceName
          minPrice
        }
      }
      vehicle {
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
        userId
      }
      mechanic {
        id
        userCode
        firstName
        lastName
        emailId
        phoneNo
        accountType
        status
        jwtToken
        fcmToken
        otpCode
        customer{
          id
        }
      }
      customer {
        id
        userCode
        firstName
        lastName
        emailId
        phoneNo
        accountType
        status
        jwtToken
        fcmToken
        otpCode
        customer{
          id
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
      isTokenThere: true,
    );
  }

  postTimePriceServiceDetailsRequest(
      token, services, fee, time, catType) async {
    String _query = """ 
     mutation {
  mechanic_service_add(
  catType: $catType,
  services: "$services",
   fee: $fee,
    time: $time)
     {
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

  postRegularServiceStatusUpdateRequest(
    token,
    bookingId,
    bookStatus,
  ) async {
    String _query = """
         mutation {
      regularMechStatusUpdate(state: $bookStatus, bookId: $bookingId) {
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

  /// sparepartsvehicle
  fetchServicespareparts() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    String authToken = shdPre.getString(SharedPrefKeys.token).toString();
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
          color
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
      authToken,
      enableDebug: true,
      isTokenThere: true,
    );
  }

  /// sparepartslist
  fetchServicesparepartslist(model, search, fromcost, tocost) async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    String authToken = shdPre.getString(SharedPrefKeys.token).toString();
    String _query = """ 
       query
       {
    spare_parts_list(
      modelName: "$model"
      search: $search
      sortBy: 1
      fromCost: $fromcost
      toCost: $tocost
    ) {
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
      vehicleModel {
        id
        modelName
        engineName
        years
        brandName
        status
      }
      reviewCount
      avgRate
      salesCount
      reviewData {
        id
        transType
        rating
        feedback
        bookingId
        orderId
        status
        order{
          id
        }
        bookings{
          id
        }
        productData{
          id
        }
      }
    }
  }

    """;
    log(_query);
    return await GqlClient.I.query01(
      _query,
      authToken,
      enableDebug: true,
      isTokenThere: true,
    );
  }

  /// add to cart queryprovider
  fetchServiceaddcart(productid) async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    String authToken = shdPre.getString(SharedPrefKeys.token).toString();
    print("noel");
    print(authToken);
    String _query = """
        
  mutation {
  addCart(productId: $productid, quantity: 1) {
    msg {
      status
      code
      message
    }
    itemCount
    totalAmount
  }
}


    """;

    return await GqlClient.I.query01(
      _query,
      authToken,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  ///  cartlist queryprovider
  fetchServicecartlist() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    String authToken = shdPre.getString(SharedPrefKeys.token).toString();
    String custId = shdPre.getString(SharedPrefKeys.userID).toString();
    print("custoid");
    print(custId);
    print(authToken);

    String _query = """
   query      
  {
  cartList(customerId: $custId, page: 0, size: 100) {
    totalItems
    data {
      
      id
      customerId
      productId
      quantity
      status
      customer{
        id
        address{
          fullName
          phoneNo
          pincode
          city
          state
          
        }
      }
      product{
        vehicleModel{
          id,
          brandName,
          modelName
        }
        id
        productName
        productCode
        price
        productImage
        
        
      }
    }
    totalPages
    currentPage
    totalPrice
    count
    deliveryCharge
  }
}


    """;

    return await GqlClient.I.query01(
      _query,
      authToken,
      enableDebug: true,
      isTokenThere: false,
    );
  }

  /// delete cart queryprovider
  fetchServicedeletelist(productid) async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    String authToken = shdPre.getString(SharedPrefKeys.token).toString();
    print("noel");
    print(authToken);
    String _query = """
                
  mutation {
  updateCart(productId:$productid, quantity: 1, status: 0) {
    status
    code
    message
  }
}


    """;

    return await GqlClient.I.query01(
      _query,
      authToken,
      enableDebug: true,
      isTokenThere: false,
    );
  }
}
