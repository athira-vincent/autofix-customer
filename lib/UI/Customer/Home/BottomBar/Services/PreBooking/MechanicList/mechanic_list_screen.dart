import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicList/mechanic_list_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicList/mechanic_list_mdl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicListScreen extends StatefulWidget {
  const MechanicListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MechanicListScreenState();
  }
}

class _MechanicListScreenState extends State<MechanicListScreen> {

  final MechanicListBloc _mechanicListBloc = MechanicListBloc();

  List<MechanicListData> mechanicListData = [];
  MechanicListData? mechanicListDataVal;

  String token = "";

  @override
  void initState() {
    super.initState();
    _addToken();
    _mechanicListBloc.postMechanicListRequest(/*token*/
        """eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNjM3ODMwODY4LCJleHAiOjE2Mzc5MTcyNjh9.BeiaYvLKmIhVeBOInXFPuf-cnfiA8s_Takf_aMxpcsk""",
        1, 10);
    _getViewVehicle();
  }

  _addToken() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    token = _shdPre.getString(SharedPrefKeys.token)!;
    print("Token : " + token);
    GqlClient.I.config(token: token);
    //_allMakeBloc.postAllMakeRequest(token);
  }

  @override
  void dispose() {
    super.dispose();
    _mechanicListBloc.dispose();
  }

  _getViewVehicle() async {
    _mechanicListBloc.postViewMechanicList.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {

          print("errrrorr 01");
          //_isLoading = false;
          print(">>>>>mechanic Api Data >>> " +
              "id : " +value.data!.mechanicList!.totalItems.toString()+ " >>>>>>>>>");
          mechanicListData = value.data!.mechanicList!.mechanicListData!;
         // value.data.mechanicList.mechanicListData[0].id;

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mechanic List"),
      ),
      body: buildList(),
    );
  }
  Widget buildList() => ListView.builder(
    itemCount: mechanicListData.length,
    itemBuilder: (context, index){
      String? mechName = mechanicListData[index].firstName;
      String? address = mechanicListData[index].address;
      String? phone = mechanicListData[index].phoneNo;
      //int imageIndex = index +1;
      return ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(
              'http://www.londondentalsmiles.co.uk/wp-content/uploads/2017/06/person-dummy.jpg'
              //'https://source.unsplash.com/random?sig=$index'
          ),
        ),
        title: Text(mechName!),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Text(mechName!),
            Text(address!),
            Text(phone!,),
          ],
            //child: Text("sub-title $index")
        ),

        //onTap: () => selectItem(item),

      );
    },
  );

  void selectItem(String itemSelected){
    final snackBar = SnackBar(
      content: Text("Selected item $itemSelected",
        style: TextStyle(fontSize: 24),),
      backgroundColor: Colors.blue,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
