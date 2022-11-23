import 'package:flutter/material.dart';
void main() {
  runApp(
    MaterialApp(

        home:  MyApp()
    ),
  );
}


class MyApp extends StatelessWidget {
  MyApp({super.key});
  ScheduleData scheduleData = ScheduleData();
  late List<String> groups = scheduleData.getGroupsNames();
  late String? selectedGroup = groups[0];
  late Schedule schedule = scheduleData.getScheduleForGroup(selectedGroup);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Groups'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: DropdownButton<String>(
                  value: selectedGroup,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: groups
                      .map((group) =>
                      DropdownMenuItem(
                        value: group,
                        child: Text(group),
                      ))
                      .toList(),
                  onChanged: (String? newGroup) {
                    selectedGroup = newGroup!;
                  }
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Home(selectedGroup: selectedGroup)));
                },
                child: Text('Продовжити')),

          ],
        ),

      ),
    );
  }
}

class Home extends StatelessWidget {
  String? selectedGroup;
  Home({required this.selectedGroup});

  @override
  Widget build(BuildContext context) {


    ScheduleData scheduleData = ScheduleData();
    Schedule schedule = scheduleData.getScheduleForGroup(selectedGroup);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Schedule'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  String dayName = scheduleData.getDayName(index);
                  List<List<String>> subjects = [];
                  schedule.dayToSubjects[dayName]?.subjects.forEach(
                          (key, value) => subjects.add([key.toString(), value]));

                  return ExpansionTile(
                      title: Text(dayName),
                      children: subjects
                          .map((value) =>
                          ListTile(title: Text(value[0] + '. ' + value[1])))
                          .toList());
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
              ))
        ]),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  String login;
  Page2({required this.login});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Login Page')
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(child: Text('Welcome back '+login),),
              Container(child: ElevatedButton(
                  child: Text('Log out'),
                  onPressed: (){Navigator.pop(context);}
              )),
            ],
          ),
        ));
  }
}

class Subjects {
  Subjects(this.subjects);
  Map<int, String> subjects;
}

class Schedule {
  Schedule(Map<String, Map<int, String>> scheduleRaw) {
    scheduleRaw.forEach((key, value) => dayToSubjects[key] = Subjects(value));
  }
  Map<String, Subjects> dayToSubjects = {};
}

class ScheduleData {
  ScheduleData() {
    groupToSchedule = {};
    dataRaw.forEach((key, value) => groupToSchedule[key] = Schedule(value));
  }

  Map<String, Schedule> groupToSchedule = {};

  List<String> getGroupsNames() {
    return groupToSchedule.keys.toList();
  }

  Schedule getScheduleForGroup(String? groupName) {
    return groupToSchedule[groupName]!;
  }

  String getDayName(int dayIndex) {
    switch (dayIndex) {
      case 0:
        return "Понеділок";
      case 1:
        return "Вівторок";
      case 2:
        return "Середа";
      case 3:
        return "Четвер";
      case 4:
        return "П'ятниця";
      default:
    }
    return '';
  }
}

Map<String, Map<String, Map<int, String>>> dataRaw = {
  "KБ-45": {
    "Понеділок": {
      4: 'Технології розслідування інцидентів інформаційної безпеки',
      5: 'Безпека програмного забезпечення',
    },
    "Вівторок": {
      3: 'Основи охорони праці та безпека життєдіяльності',
      4: 'Контрольно-вимірювальна апаратура інформаційної безпеки',
      6: 'Системи охорони державної таємниці',
      7: 'Організаційне забезпечення технічного захисту інформації'
    },
    "Середа": {
      1: 'Безпека програмного забезпечення',
      2: 'Безпека програмного забезпечення',
      7: 'Системи автентифікації і управління доступом'
    },
    "Четвер": {
      1: 'Системи виявлення вторгнень',
      3: 'Мікропроцесори в системах технічного захисту інформації'
    },
    "П'ятниця": {
      1: 'Мікропроцесори в системах технічного захисту інформації',
    },
  },
  "KБ-46": {
    "Понеділок": {
      4: 'Технології розслідування інцидентів інформаційної безпеки',
      5: 'Безпека програмного забезпечення'
    },
    "Вівторок": {
      3: 'Основи охорони праці та безпека життєдіяльності',
      4: 'Організаційне забезпечення технічного захисту інформації',
      6: 'Контрольно-вимірювальна апаратура інформаційної безпеки',
      7: 'Мікропроцесори в системах технічного захисту інформації'
    },
    "Середа": {
      1: 'Контрольно-вимірювальна апаратура інформаційної безпеки',
      2: 'Мікропроцесори в системах технічного захисту інформації',
      3: 'Технології розслідування інцидентів інформаційної безпеки',
      4: 'Технології розслідування інцидентів інформаційної безпеки',
    },
    "Четвер": {
      2: 'Мікропроцесори в системах технічного захисту інформації',
    },
    "П'ятниця": {
      1: 'Мікропроцесори в системах технічного захисту інформації',
    },
  },
  "KБ-47": {
    "Понеділок": {
      2: 'Архітектура спеціалізованих комп`ютерних систем',
      3: 'Діагностика комп`ютерних засобів'
    },
    "Вівторок": {
      1: 'Комп`ютерні засоби опрацювання сигналів',
      4: 'Технології проектування комп`ютерних систем',
      6: 'Проектування комп`ютерних засобів обробки сигналів і зображень'
    },
    "Середа": {
      1: 'Технології проектування комп`ютерних систем',
      2: 'Архітектура спеціалізованих комп`ютерних систем',
      3: 'Захист інформації в комп`ютерних системах'
    },
    "Четвер": {
      4: 'Технології проектування комп`ютерних систем',
      5: 'Архітектура спеціалізованих комп`ютерних систем',
      6: 'Проектування комп`ютерних засобів обробки сигналів і зображень'
    },
    "П'ятниця": {
      2: 'Діагностика комп`ютерних засобів',
      3: 'Комп`ютерні засоби опрацювання сигналів',
      4: 'Захист інформації в комп`ютерних системах'
    },
  },
  "KБ-48": {
    "Понеділок": {
      2: 'Методи та засоби опрацювання сигналів і зображень',
      3: 'Програмні технології мобільних обчислень',
      4: 'Програмне забезпечення інтернету речей'
    },
    "Вівторок": {
      1: 'Програмне забезпечення інтернету речей',
      2: 'Мережні операційні системи',
      3: 'Програмні технології мобільних обчислень'
    },
    "Середа": {
      1: 'Методи та засоби опрацювання сигналів і зображень',
      2: 'Програмне забезпечення інтернету речей'
    },
    "Четвер": {
      3: 'Системне адміністрування комп`ютерних мереж',
      4: 'Захист інформації в комп`ютерних системах'
    },
    "П'ятниця": {
      1: 'Мережні операційні системи',
      2: 'Системне адміністрування комп`ютерних мереж',
      4: 'Захист інформації в комп`ютерних системах'
    },
  },
};