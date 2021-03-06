// NOTE: Declarations in this file are analyzed but not tested.
// ignore_for_file: unused_element, unused_local_variable

import 'animal.dart';

void _miscDeclAnalyzedButNotTested() {
  {
    // #docregion opening-example
    void fn(List<int> a) => print(a);

    void main() {
      var list = [];
      list.add(1);
      list.add("2");
      // ignore_for_file: 1, 2, argument_type_not_assignable
      fn(list); //!analysis-issue
    }
    // #enddocregion opening-example
  }

  {
    // #docregion type-inference-1-orig
    Map<String, dynamic> arguments = {'argA': 'hello', 'argB': 42};
    // #enddocregion type-inference-1-orig

    // ignore_for_file: 1, 2, argument_type_not_assignable
    arguments[1] = null;

    // #docregion type-inference-2-orig
    Map<String, dynamic> message = {
      'method': 'someMethod',
      'args': <Map<String, dynamic>>[arguments],
    };
    // #enddocregion type-inference-2-orig
  }

  {
    // #docregion type-inference-1
    var arguments = {'argA': 'hello', 'argB': 42};
    // #enddocregion type-inference-1

    // ignore_for_file: 1, 2, argument_type_not_assignable
    arguments[1] = null;

    // #docregion type-inference-2
    var message = {
      'method': 'someMethod',
      'args': <Map<String, dynamic>>[arguments],
    };
    // #enddocregion type-inference-2
  }

  Map<String, List> foo;

  {
    // #docregion type-inference-3-orig
    List<dynamic> arguments = foo['args'];
    // #enddocregion type-inference-3-orig
  }

  {
    // #docregion type-inference-3
    var arguments = foo['args'];
    // #enddocregion type-inference-3
  }

  {
    // #docregion local-var-type-inference-error
    var x = 3; // x is inferred as an int
    // ignore_for_file: 1, 2, invalid_assignment
    x = 4.0; //!analysis-issue
    // #enddocregion local-var-type-inference-error
  }

  {
    // #docregion local-var-type-inference-ok
    num y = 3; // a num can be double or int
    y = 4.0;
    // #enddocregion local-var-type-inference-ok
  }

  {
    // #docregion type-arg-inference
    // Inferred as if you wrote <int>[].
    List<int> listOfInt = [];

    // Inferred as if you wrote <double>[3.0].
    var listOfDouble = [3.0];

    // Inferred as Iterable<int>
    var ints = listOfDouble.map((x) => x.toInt());
    // #enddocregion type-arg-inference

    // ignore_for_file: 1, 2, invalid_assignment
    listOfDouble[0] = '';
  }

  {
    // #docregion Animal-Cat-ok
    Animal c = new Cat();
    // #enddocregion Animal-Cat-ok
  }

  {
    // #docregion MaineCoon-Cat-err
    // ignore_for_file: 1, invalid_assignment
    // ignore_for_file: 2, strong_mode_invalid_cast_new_expr
    MaineCoon c = new Cat();
    // #enddocregion MaineCoon-Cat-err
  }

  {
    // #docregion Cat-MaineCoon-ok
    Cat c = new MaineCoon();
    // #enddocregion Cat-MaineCoon-ok
  }

  {
    // #docregion generic-type-assignment-MaineCoon
    List<Cat> myCats = new List<MaineCoon>();
    // #enddocregion generic-type-assignment-MaineCoon
  }

  {
    // Since we're using --no-implicit-casts, the following causes a static error.
    // #docregion generic-type-assignment-Animal
    // ignore_for_file: 2, invalid_assignment
    List<Cat> myCats = new List<Animal>();
    // #enddocregion generic-type-assignment-Animal
  }

  {
    // #docregion generic-type-assignment-implied-cast
    List<Cat> myCats = new List<Animal>() as List<Cat>;
    // #enddocregion generic-type-assignment-implied-cast
  }

  {
    // #docregion dart-1-checked-mode-permissiveness
    // ignore_for_file: 1, 2, invalid_assignment
    String result = 1 + 2;
    // #enddocregion dart-1-checked-mode-permissiveness
  }
}
