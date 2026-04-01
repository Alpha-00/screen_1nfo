import 'package:flutter/material.dart';
import 'package:screen_s1ze/widget/data_line.dart';

class DataLines extends StatelessWidget{
  final Map<String, DataValue> data;
  const DataLines({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return _cardGroupWidget(data);
  }

}

Widget _cardGroupWidget(Map<String, DataValue> data) => Card(
      elevation: 1,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 8,
          children: 
            data.entries.map((e)=> Row(
              mainAxisAlignment: .spaceBetween,
              children: [
              Text(e.key),
              Text(e.value.toString()),
            ],)).toList()
          
        ),
      ),
    );

    