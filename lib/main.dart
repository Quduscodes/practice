import 'package:flutter/material.dart';
import 'package:practice/NewUser.dart';
import 'package:practice/User.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData.dark().copyWith(primaryColor: Colors.grey),
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  String title = 'Practice';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

enum sortType { firstname, lastname, nationality }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchQuery = '';

  void firstnameStringBubbleSort(List<User> arr) {
    for (int i = 0; i < arr.length; i++) {
      for (int j = 0; j < arr.length - i - 1; j++) {
        if (arr[j].firstName.compareTo(arr[j + 1].firstName) == 1) {
          User obj = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = obj;
        }
      }
    }
  }

  void lastnameStringBubbleSort(List<User> arr) {
    for (int i = 0; i < arr.length; i++) {
      for (int j = 0; j < arr.length - i - 1; j++) {
        if (arr[j].lastName.compareTo(arr[j + 1].lastName) == 1) {
          User obj = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = obj;
        }
      }
    }
  }

  void nationalityStringBubbleSort(List<User> arr) {
    for (int i = 0; i < arr.length; i++) {
      for (int j = 0; j < arr.length - i - 1; j++) {
        if (arr[j].nationality.compareTo(arr[j + 1].nationality) == 1) {
          User obj = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = obj;
        }
      }
    }
  }

  binSearch(List<User> arr, int low, int high, var x) {
    if (high >= low) {
      int mid = (high + low) ~/ 2;
      if (arr[mid].firstName.toLowerCase().contains(x) == true) {
        return mid;
      }
      if (x.compareTo(arr[mid].firstName.toLowerCase()) == 1) {
        return binSearch(arr, mid + 1, high, x);
      } else if (x.compareTo(arr[mid].firstName.toLowerCase()) == -1) {
        return binSearch(arr, 0, mid - 1, x);
      }
    } else {
      return -1;
    }
  }

  final _sortTypes = ['Firstname', 'Lastname', 'Nationality'];

  int searchItemIndex = -1;

  getSearchItemIndex(List<User> arr, int low, int high, var x) {
    setState(() {
      searchItemIndex = binSearch(arr, low, high, x);
    });
  }

  String _selectedSortType = 'Firstname';

  var sortMethod;

  @override
  Widget build(BuildContext context) {
    _selectedSortType == 'Lastname'
        ? lastnameStringBubbleSort(users)
        : _selectedSortType == 'Firstname'
            ? firstnameStringBubbleSort(users)
            : _selectedSortType == 'Nationality'
                ? nationalityStringBubbleSort(users)
                : null;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Keeper'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text('Sort by:'),
                  ),
                  DropdownButton<String>(
                      items: _sortTypes.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem.toString()));
                      }).toList(),
                      onChanged: (newSelectedSortType) {
                        setState(() {
                          if (newSelectedSortType != null) {
                            _selectedSortType = newSelectedSortType;
                          }
                        });
                        lastnameStringBubbleSort(users);
                      },
                      value: _selectedSortType),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: 'Enter Name to search',
                      ),
                      onChanged: (val) {
                        if (val.length != 0) {
                          setState(() {
                            searchQuery = val.trim().toLowerCase();
                            getSearchItemIndex(
                                users, 0, users.length - 1, searchQuery.trim());
                          });
                        } else {
                          searchItemIndex = -1;
                        }
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showBottomSheet(
                            context: context, builder: (context) => Preview());
                      },
                      icon: Icon(Icons.person_add_outlined))
                ],
              ),
            ),
            searchItemIndex >= 0
                ? ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      child: Text(users[searchItemIndex].firstName[0]),
                    ),
                    title: Text(
                        '${users[searchItemIndex].firstName} ${users[searchItemIndex].lastName}'),
                    subtitle: Text(users[searchItemIndex].nationality),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            users.removeAt(searchItemIndex);
                            searchItemIndex = -1;
                          });
                        }),
                  )
                : Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: CircleAvatar(
                                child: Text(users[index].firstName[0]),
                              ),
                              title: Text(
                                  '${users[index].firstName} ${users[index].lastName}'),
                              subtitle: Text(users[index].nationality),
                              trailing: InkWell(
                                  onTap: () {
                                    setState(() {
                                      users.removeAt(index);
                                    });
                                  },
                                  child: Material(
                                      type: MaterialType.transparency,
                                      child: Icon(Icons.delete))));
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: users.length),
                  ),
          ],
        ),
      ),
    );
  }
}
