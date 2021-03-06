


import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'dooboolab flutter calendar',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Calendar Carousel Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  bool size = true;

  String _currentMonth =DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime(2019, 2, 3);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );



  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    DateTime now = new DateTime.now();
//   DateTime month = new DateTime(now.month.);




    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.transparent,
      todayButtonColor: Colors.transparent,
      childAspectRatio: 1,


      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },


      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 14
      ),

      //  thisMonthDayBorderColor: Colors.grey,
      selectedDayBorderColor: Color.fromRGBO(74, 160, 166, 1),
      selectedDayButtonColor: Color.fromRGBO(229, 245, 245, 1),
      weekFormat: false,
      firstDayOfWeek: 2,
      //     markedDatesMap: _markedDateMap,
      height: 300.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,

      markedDateCustomShapeBorder: CircleBorder(
          side: BorderSide(color: Colors.blueAccent)
      ),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,



      daysHaveCircularBorder: false,
      weekdayTextStyle: TextStyle(
          color: Colors.grey
      ),
      showWeekDays: true,

      //dayButtonColor: Colors.transparent,
      isScrollable:(size!=true)? true:false,
      customGridViewPhysics: NeverScrollableScrollPhysics(),

      staticSixWeekFormat: (size==true)?true:false,
      selectedDayTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
      minSelectedDate: _currentDate,
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //custom icon
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarousel,
              ), // This trailing comma makes auto-formatting nicer for build methods.
              //custom icon without header
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          _currentMonth,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        )),
                    Container(
                      height: 30,
                      child:RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)
                        ),

                        onPressed: (){
                          setState(() {
                            if(size != true){
                              size=true;
                            }else{
                              size=false;
                            }
                          });
                        },
                        child: Row(
                          children: <Widget>[

                            (size==true)?  Text("Show Month",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300),):Text("Less Days",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300),),
                            Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                          ],
                        ),




                      ),
                    )


//                    FlatButton(
//                      child: Text('PREV'),
//                      onPressed: () {
//                        setState(() {
//                          _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month -1);
//                          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
//                        });
//                      },
//                    ),
//                    FlatButton(
//                      child: Text('NEXT'),
//                      onPressed: () {
//                        setState(() {
//                          _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month +1);
//                          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
//                        });
//                      },
//                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarouselNoHeader,
              ), //
            ],
          ),
        ));
  }
}
