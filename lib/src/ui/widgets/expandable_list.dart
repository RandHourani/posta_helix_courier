import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';

class ListExpansion extends StatefulWidget {
  Widget firstList;
  Widget minList;

  ListExpansion({this.firstList, this.minList});

  @override
  _ListExpansionState createState() =>
      _ListExpansionState(firstList: firstList, minList: minList);
}

class _ListExpansionState extends State<ListExpansion> {
  ExpandableController _controller;
  Widget firstList;
  Widget minList;

  _ListExpansionState({this.firstList, this.minList});

  @override
  void initState() {
    super.initState();
    _controller = ExpandableController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Column(
        children: [
          ExpandablePanel(
              controller: _controller,
              hasIcon: false,
              tapHeaderToExpand: false,
              tapBodyToCollapse: false,
              collapsed: minList,
              expanded:
              Column(children: [
                firstList,

              ],)
          ),

          RaisedButton(
            onPressed: () {
              _controller.expanded
                  ? approvedCaptainBloc.setExpandableController(true)
                  : approvedCaptainBloc.setExpandableController(false);
              setState(() {
                _controller.toggle();
              });
            },
            child: Text("test"),
          )
        ],
      ),
    );
  }
}
