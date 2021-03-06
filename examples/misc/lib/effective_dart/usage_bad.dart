// ignore_for_file: avoid_init_to_null, empty_constructor_bodies, final_not_initialized_constructor_1, prefer_is_not_empty, sort_constructors_first, type_annotate_public_apis, type_init_formals, unnecessary_brace_in_string_interps, unnecessary_getters_setters, unused_element, unused_local_variable
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'usage_good.dart';

void miscDeclAnalyzedButNotTested() {
  {
    // #docregion adjacent-strings-literals
    raiseAlarm('ERROR: Parts of the spaceship are on fire. Other ' +
        'parts are overrun by martians. Unclear which are which.');
    // #enddocregion adjacent-strings-literals
  }

  (String name, num year, num birth) {
    // #docregion string-interpolation
    'Hello, ' + name + '! You are ' + (year - birth).toString() + ' y...';
    // #enddocregion string-interpolation
  };

  (name, decade) {
    return
        // #docregion string-interpolation-avoid-curly
        'Hi, ${name}!'
        "Wear your wildest ${decade}'s outfit."
        // #enddocregion string-interpolation-avoid-curly
        ;
  };

  {
    // #docregion collection-literals
    var points = new List();
    var addresses = new Map();
    // #enddocregion collection-literals
  }

  {
    // #docregion generic-collection-literals
    var points = new List<Point>();
    var addresses = new Map<String, Address>();
    // #enddocregion generic-collection-literals
  }

  (Iterable lunchBox, Iterable words) {
    // #docregion dont-use-length
    if (lunchBox.length == 0) return 'so hungry...';
    if (!words.isEmpty) return words.join(' ');
    // #enddocregion dont-use-length
  };

  (Iterable people) {
    // #docregion avoid-forEach
    people.forEach((person) {
      /*...*/
    });

    // #enddocregion avoid-forEach
  };

  {
    // #docregion func-decl
    void main() {
      var localFunction = () {
        /*...*/
      };
    }
    // #enddocregion func-decl
  }

  (Iterable names) {
    // #docregion use-tear-off
    names.forEach((name) {
      print(name);
    });
    // #enddocregion use-tear-off
  };

  {
    // #docregion omit-types-on-locals
    Map<int, List<Person>> groupByZip(Iterable<Person> people) {
      Map<int, List<Person>> peopleByZip = <int, List<Person>>{};
      for (Person person in people) {
        peopleByZip.putIfAbsent(person.zip, () => <Person>[]);
        peopleByZip[person.zip].add(person);
      }
      return peopleByZip;
    }
    // #enddocregion omit-types-on-locals
  }

  {
    // #docregion rethrow
    try {
      somethingRisky();
    } catch (e) {
      if (!canHandle(e)) throw e;
      handle(e);
    }
    // #enddocregion rethrow
  }

  (log) {
    // #docregion async-await
    Future<bool> doAsyncComputation() {
      return longRunningCalculation().then((result) {
        return verifyResult(result.summary);
      }).catchError((e) {
        log.error(e);
        return new Future.value(false);
      });
    }
    // #enddocregion async-await
  };

  {
    // #docregion unnecessary-async
    Future afterTwoThings(Future first, Future second) async {
      return Future.wait([first, second]);
    }
    // #enddocregion unnecessary-async
  }

  {
    // #docregion avoid-completer
    Future<bool> fileContainsBear(String path) {
      var completer = new Completer<bool>();

      new File(path).readAsString().then((contents) {
        completer.complete(contents.contains('bear'));
      });

      return completer.future;
    }
    // #enddocregion avoid-completer
  }
}

//----------------------------------------------------------------------------

// #docregion no-null-init
int _nextId = null;

class LazyId {
  int _id = null;

  int get id {
    if (_nextId == null) _nextId = 0;
    if (_id == null) _id = _nextId++;

    return _id;
  }
}
// #enddocregion no-null-init

//----------------------------------------------------------------------------

// #docregion cacl-vs-store1
class Circle1 {
  num radius;
  num area;
  num circumference;

  Circle1(num radius)
      : radius = radius,
        area = PI * radius * radius,
        circumference = PI * 2.0 * radius;
}
// #enddocregion cacl-vs-store1

//----------------------------------------------------------------------------

// #docregion cacl-vs-store2
class Circle2 {
  num _radius;
  num get radius => _radius;
  set radius(num value) {
    _radius = value;
    _recalculate();
  }

  num _area;
  num get area => _area;

  num _circumference;
  num get circumference => _circumference;

  Circle2(this._radius) {
    _recalculate();
  }

  void _recalculate() {
    _area = PI * _radius * _radius;
    _circumference = PI * 2.0 * _radius;
  }
}
// #enddocregion cacl-vs-store2

//----------------------------------------------------------------------------

// #docregion dont-wrap-field
class Box {
  var _contents;
  get contents => _contents;
  set contents(value) {
    _contents = value;
  }
}
// #enddocregion dont-wrap-field

//----------------------------------------------------------------------------

// #docregion final
class Box1 {
  var _contents;
  get contents => _contents;
}
// #enddocregion final

//----------------------------------------------------------------------------

// #docregion this-dot
class Box2 {
  var value;

  void clear() {
    this.update(null);
  }

  void update(value) {
    this.value = value;
  }
}
// #enddocregion this-dot

//----------------------------------------------------------------------------

// #docregion field-init-at-decl
class Folder {
  final String name;
  final List<Document> contents;

  Folder(this.name) : contents = [];
  Folder.temp() : name = 'temporary'; // Oops! Forgot contents.
}
// #enddocregion field-init-at-decl

//----------------------------------------------------------------------------

// #docregion field-init-as-param
class Point {
  num x, y;
  Point(num x, num y) {
    this.x = x;
    this.y = y;
  }
}
// #enddocregion field-init-as-param

//----------------------------------------------------------------------------

// #docregion dont-type-init-formals
class Point1 {
  int x, y;
  Point1(int this.x, int this.y);
}
// #enddocregion dont-type-init-formals

//----------------------------------------------------------------------------

// #docregion semicolon-for-empty-body
class Point2 {
  int x, y;
  Point2(this.x, this.y) {}
}
// #enddocregion semicolon-for-empty-body

//----------------------------------------------------------------------------
// ignore_for_file: super_goes_last, strong_mode_invalid_super_invocation

class View extends ViewBase {
  var _children;
  get children => _children;
  // #docregion super-first
  View(Style style, List children)
      : super(style),
        _children = children;
  // #enddocregion super-first
}
