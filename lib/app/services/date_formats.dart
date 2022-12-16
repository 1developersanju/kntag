String get_data1(List<String> list) {
  List<String> data1 = [];
  bool s = true;
  if (list.length == 0) s = false;
  while (s) {
    if (list[0] != ' ') {
      data1.add(list[0]);
      list.remove(list[0]);
    } else {
      s = false;
      list.remove(list[0]);
    }

    if (list.length == 0) s = false;
  }

  return data1.join();
}

//------------------------------------------------
String get_data2(List<String> list) {
  List<String> data2 = [];
  bool s = true;
  if (list.length == 0) s = false;
  while (s) {
    if (list[0] != ' ') {
      data2.add(list[0]);
      list.remove(list[0]);
    } else {
      s = false;
      list.remove(list[0]);
    }

    if (list.length == 0) s = false;
  }

  return data2.join();
}

//------------------------------------------------
String get_data3(List<String> list) {
  List<String> data3 = [];
  bool s = true;
  if (list.length == 0) s = false;
  while (s) {
    if (list[0] != ' ') {
      data3.add(list[0]);
      list.remove(list[0]);
    } else {
      s = false;
      list.remove(list[0]);
    }

    if (list.length == 0) s = false;
  }

  return data3.join();
}

//------------------------------------------------
String decode_data(String data1, data2, data3) {
  String d = '', m = '', y = '';

  if (is_int(data1[0])) {
    List a = data1.split('');
    a.remove('t');
    a.remove('h');
    a.remove('s');
    a.remove('n');
    a.remove('r');
    a.remove('d');
    data1 = a.join();
  }

  if (is_int(data2[0])) {
    List a = data2.split('');
    a.remove('t');
    a.remove('h');
    a.remove('s');
    a.remove('n');
    a.remove('r');
    a.remove('d');
    data2 = a.join();
  }

  if (is_int(data3[0])) {
    List a = data3.split('');
    a.remove('t');
    a.remove('h');
    a.remove('s');
    a.remove('n');
    a.remove('r');
    a.remove('d');
    data3 = a.join();
  }

  if (data1.length == 0 || data2.length == 0 || data3.length == 0)
    return 'e1 some data is missing (or) have input error';
  if (is_int(data1[0]) && data1.length > 2) {
    y = data1;
  } else if (is_int(data1[0]) && data1.length <= 2) {
    d = data1;
  } else if ((data1[0].codeUnitAt(0) > 96) && (data1[0].codeUnitAt(0) < 123)) {
    m = get_m('${data1[0]}${data1[1]}${data1[2]}');
    if (m == '!') return 'e2 some data is missing (or) have input error';
  } else {
    print(data1);
    return 'e3 some data is missing (or) have input error';
  }

  if (is_int(data2[0]) && data2.length > 2) {
    y = data2;
  } else if (is_int(data2[0]) && data2.length <= 2) {
    d = data2;
  } else if (((data2[0].codeUnitAt(0) > 96) &&
      (data2[0].codeUnitAt(0) < 123))) {
    m = get_m('${data2[0]}${data2[1]}${data2[2]}');
    if (m == '!') return 'e4 some data is missing (or) have input error';
  } else
    return 'e5 some data is missing (or) have input error';

  if (is_int(data3[0]) && data3.length > 2) {
    y = data3;
  } else if (is_int(data3[0]) && data3.length <= 2) {
    d = data3;
  } else if (((data3[0].codeUnitAt(0) > 96) &&
      (data3[0].codeUnitAt(0) < 123))) {
    m = get_m('${data3[0]}${data3[1]}${data3[2]}');
    if (m == '!') return 'e6 some data is missing (or) have input error';
  } else
    return 'e7 some data is missing (or) have input error';

  return '0${y}-0${m}-0${d}';
}

//------------------------------------------------
String get_m(String a) {
  switch (a) {
    case 'jan':
      {
        return '1';
      }
      break;

    case 'feb':
      {
        return '2';
      }
      break;

    case 'mar':
      {
        return '3';
      }
      break;

    case 'apr':
      {
        return '4';
      }
      break;

    case 'may':
      {
        return '5';
      }
      break;

    case 'jun':
      {
        return '6';
      }
      break;

    case 'jul':
      {
        return '7';
      }
      break;

    case 'aug':
      {
        return '8';
      }
      break;

    case 'sep':
      {
        return '9';
      }
      break;

    case 'oct':
      {
        return '10';
      }
      break;

    case 'nov':
      {
        return '11';
      }
      break;

    case 'dec':
      {
        return '12';
      }
      break;

    default:
      {
        return '!';
      }
      break;
  }
}

//------------------------------------------------
bool is_int(var cha) {
  var s = cha.codeUnitAt(0);
  if ((s >= 48) && (s <= 57))
    return true;
  else
    return false;
}
