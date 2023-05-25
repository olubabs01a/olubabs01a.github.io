// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:olubabs01a_site/archives.dart';
import 'package:olubabs01a_site/contact.dart';
import 'package:olubabs01a_site/projects.dart';
import 'package:olubabs01a_site/resume.dart';
import 'package:provider/provider.dart';
import 'about.dart';
import 'extra_curr.dart';
import 'utils/get_material_state_colors.dart';
import 'work.dart';
import 'coursework.dart';

void main() {
  runApp(MyApp());
}

const appTitle = 'Olufunmilola Babalola | Learning. Creating. Being.';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MyHomePage(),
        // darkTheme: ThemeData.dark()
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];

  GlobalKey? historyListKey;

  void getNext() {
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = AboutPage();
        break;
      case 2:
        page = WorkPage();
        break;
      case 3:
        page = CoursesPage();
        break;
      case 4:
        page = ProjectsPage();
        break;
      case 5:
        page = ActivitiesPage();
        break;
      case 6:
        page = ContactPage();
        break;
      // case 7:
      //   page = ArchivesPage();
      //   break;
      case 7:
        page = ResumePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            // Use a more mobile-friendly layout with BottomNavigationBar
            // on narrow screens.
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.shifting,
                    showUnselectedLabels: false,
                    // iconSize: 18.0,
                    selectedIconTheme: theme.iconTheme,
                    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    unselectedIconTheme: theme.iconTheme,
                    selectedItemColor: getBackgroundColor({}, theme, false),
                    landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        activeIcon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person_2_outlined),
                        activeIcon: Icon(Icons.person_2_rounded),
                        label: 'About',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.work_history_outlined),
                        activeIcon: Icon(Icons.work_history),
                        label: 'Work',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.school_outlined),
                        activeIcon: Icon(Icons.school),
                        label: 'Coursework',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.lightbulb_outlined),
                        activeIcon: Icon(Icons.lightbulb),
                        label: 'Projects',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.volunteer_activism_outlined),
                        activeIcon: Icon(Icons.volunteer_activism),
                        label: 'Activities',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.contact_page_outlined),
                        activeIcon: Icon(Icons.contact_page),
                        label: 'Contact',
                      ),
                      // BottomNavigationBarItem(
                      //   icon: Icon(Icons.archive),
                      //   label: 'Archives',
                      // ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.receipt_outlined),
                        activeIcon: Icon(Icons.receipt),
                        label: 'Resume',
                      )
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person_2_outlined),
                        selectedIcon: Icon(Icons.person_2_rounded),
                        label: Text('About'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.work_history_outlined),
                        selectedIcon: Icon(Icons.work_history),
                        label: Text('Work Experience'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.school_outlined),
                        selectedIcon: Icon(Icons.school),
                        label: Text('Selected Coursework'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.lightbulb_outlined),
                        selectedIcon: Icon(Icons.lightbulb),
                        label: Text('Personal Projects'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.volunteer_activism_outlined),
                        selectedIcon: Icon(Icons.volunteer_activism),
                        label: Text('Extra-Curricular'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.contact_page_outlined),
                        selectedIcon: Icon(Icons.contact_page),
                        label: Text('Contact'),
                      ),
                      // NavigationRailDestination(
                      //   icon: Icon(Icons.archive),
                      //   label: Text('The Archives'),
                      // ),
                      NavigationRailDestination(
                        icon: Icon(Icons.receipt_outlined),
                        selectedIcon: Icon(Icons.receipt),
                        label: Text('Resume'),
                      )
                    ],
                    selectedIndex: selectedIndex,
                    selectedLabelTextStyle: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.inverseSurface),
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: HistoryListView(),
          ),
          SizedBox(height: 10),
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          // Make sure that the compound word wraps correctly when the window
          // is too narrow.
          child: MergeSemantics(
            child: Wrap(
              children: [
                Text(
                  pair.first,
                  style: style.copyWith(fontWeight: FontWeight.w200),
                ),
                Text(
                  pair.second,
                  style: style.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  /// Needed so that [MyAppState] can tell [AnimatedList] below to animate
  /// new items.
  final _key = GlobalKey();

  /// Used to "fade out" the history items at the top, to suggest continuation.
  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      // This blend mode takes the opacity of the shader (i.e. our gradient)
      // and applies it to the destination (i.e. our animated list).
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final pair = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  appState.toggleFavorite(pair);
                },
                icon: appState.favorites.contains(pair)
                    ? Icon(Icons.favorite, size: 12)
                    : SizedBox(),
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
