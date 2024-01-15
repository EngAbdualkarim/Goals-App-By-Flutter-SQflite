import 'package:flutter/material.dart';

import '../cubit/main_cubit.dart';

Widget goalItem(context,goal_id,goal_name) => InkWell(
  onTap: (){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            height: 140,
            child: Column(
              children: [
                Container(
                  color: Colors.blue[900],
                  height: 30,
                  child: Center(
                    child: Text(
                      'Write your Goal:',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(
                                  Colors.red)),
                          onPressed: () {
                            MainCubit.get(context).removeData(goal_id);
                            MainCubit.get(context)
                                .addTextController
                                .text = ' ';
                            MainCubit.get(context).getData();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Remove',
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(
                                  Colors.blue)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  },
  child:   Container(

        margin: EdgeInsets.all(8),

        height: 80,

        decoration: BoxDecoration(

            boxShadow: [

              BoxShadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 5)

            ],

            borderRadius: BorderRadius.circular(20),

            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [

              Colors.blue,

              Colors.blue[900]!,

            ])),

        child: Center(

          child: Text(

            '$goal_id : $goal_name',

            style: TextStyle(

                fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),

          ),

        ),

      ),
);
