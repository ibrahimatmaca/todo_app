import 'package:flutter/material.dart';
import '../../core/date/date_sort.dart';
import '../../core/date/date_calculator.dart';
import '../../core/model/todo.dart';
import '../../core/service/firebase_api_service.dart';
import '../shared/styles/icon_styles.dart';
import '../shared/styles/text_styles.dart';
import '../shared/widgets/custom_card.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateSort dateProcess = DateSort();
  DateCalculator calculatorDate = DateCalculator();
  ApiService service = ApiService.getInstance();
  List<Todo> todoList;
  DateTime dateTime;
  Icon icon = trailingEmptyIcon;
  bool completedTask = false;

  @override
  void initState() {
    super.initState();
    service.getTodo();
  }

  void deleteLastDay(List<Todo> _todo) {
    List<Todo> liste = dateProcess.lastDayRemove(
        data: _todo, lastDay: calculatorDate.lastDateParse);
    print(liste);
    if (liste.isNotEmpty) {
      for (var item in liste) {
        service.deleteTask(item.key);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: _pageColumn,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: addIcon,
        onPressed: () {
          Navigator.pushNamed(context, "/craetetodo");
        },
      ),
    );
  }

  Widget get _pageColumn {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 10,
        ),
        Center(
          child: Text(
            "TODAY",
            style: titleStyle,
          ),
        ),
        _rowDatePickerState,
        SizedBox(
          height: 10,
        ),
        FutureBuilder<List<Todo>>(
          future: service.getTodo(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  deleteLastDay(snapshot.data);
                  todoList = dateProcess.selectedNowDate(
                    data: snapshot.data,
                    selectedDate: dateTime != null
                        ? calculatorDate.selectedDateParse(dateTime)
                        : calculatorDate.nowDateParse,
                  );
                  return _listViewBuilderCustomCard();
                } else {
                  return Center(
                    child: Text(
                      "Date Empty!",
                      style: titleStyle,
                    ),
                  );
                }
                break;
              default:
                return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }

  //TODO: Buradan sonrası sadece tarih seçme işlemi için getiriliyor.
  get _rowDatePickerState {
    return Container(
      width: 200,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width / 30,
          ),
          Text(
            dateTime != null
                ? calculatorDate.selectedDateParse(dateTime)
                : calculatorDate.nowDateParse,
            style: dateTextStyle,
          ),
          dateTimePickerIconButton(),
        ],
      ),
    );
  }

  IconButton dateTimePickerIconButton() {
    return IconButton(
      icon: Icon(
        Icons.arrow_circle_down_sharp,
        color: Colors.white54,
      ),
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: dateTime == null ? DateTime.now() : dateTime,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        ).then((date) {
          setState(() {
            dateTime = date;
          });
        });
      },
    );
  }

//TODO: List view builder buradan başlayarak listemizdeki elemanları getiriyor
  Widget _listViewBuilderCustomCard() {
    return Expanded(
      child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) => deleteToDo(
                child: CustomCard(
                  receiveTodo: todoList[index],
                  completedTask: todoList[index].completed,
                ),
                deleteKey: todoList[index].key,
              )),
    );
  }

  Widget deleteToDo({Widget child, String deleteKey}) {
    return Dismissible(
      key: UniqueKey(),
      child: child,
      secondaryBackground: Center(
        child: Text(
          "DELETE",
          style: detailPageStyle,
        ),
      ),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (dismissDirection) async {
        await service.deleteTask(deleteKey);
        setState(() {
          
        });
      },
    );
  }
}
