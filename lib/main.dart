import 'package:bloc_counter/bloc/counter_bloc.dart';
import 'package:bloc_counter/bloc/counter_event.dart';
import 'package:bloc_counter/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  late List<int> _counts;
  late int _currentIndex;
  late List<CounterBloc> _counterBlocs;

  @override
  void initState() {
    super.initState();
    _counts = [0, 0, 0];
    _currentIndex = 0;
    _counterBlocs = [
      CounterBloc(),
      CounterBloc(),
      CounterBloc(),
    ];
  }

  @override
  void dispose() {
    _counterBlocs.forEach((bloc) => bloc.close());
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          BlocProvider.value(
            value: _counterBlocs[0],
            child: CounterPage(countIndex: 0),
          ),
          BlocProvider.value(
            value: _counterBlocs[1],
            child: CounterPage(countIndex: 1),
          ),
          BlocProvider.value(
            value: _counterBlocs[2],
            child: CounterPage(countIndex: 2),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            label: '1st Tab',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            label: '2nd Tab',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            label: '3rd Tab',
          ),
        ],
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  final int countIndex;

  CounterPage({required this.countIndex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('You have pushed the button this many times:'),
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              return Text(
                '${state.count}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(
                IncrementCounterEvent(countIndex),
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
