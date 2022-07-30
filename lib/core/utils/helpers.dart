


enum RequestType { get, post, delete }

class Helpers {

  static validateEmail(String value) {
    if (value.isEmpty) {
      return "field required";
    }
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
        r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]'
        r'+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'invalid email';
  }

  static validateField(String value) {
    if (value.isEmpty) {
      return "field required";
    }
    return null;
  }

  static validatePhone(String value) {
    if (value.isEmpty) {
      return "field required";
    } else if (value.length < 10) {
      return 'invalid mobile no';
    }
    return null;
  }

  static validateStartDate(DateTime value) {
    if (value == null) {
      return "Please select policy start date";
    }
    return null;
  }

  static removeNullEmptyKey(data) {
    data.removeWhere(
        (key, value) => value == null || value == '' || value == 'null');
    return data;
  }


  static validateDate(DateTime value) {
    if (value == null) {
      return "Please select date";
    }
    return null;
  }

  static validateTime(DateTime value) {
    if (value == null) {
      return "Please select time";
    }
    return null;
  }
}
