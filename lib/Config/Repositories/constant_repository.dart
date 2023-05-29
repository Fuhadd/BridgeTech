class ConstantRepository {
  List<String> convertStringToList(
      String? string1, String? string2, String? string3, String? string4) {
    try {
      List<String> skills = [];
      if (string1 != null) {
        skills.add(string1);
      }
      if (string2 != null && string2 != '') {
        skills.add(string2);
      }
      if (string3 != null && string3 != '') {
        skills.add(string3);
      }
      if (string4 != null && string4 != '') {
        skills.add(string4);
      }
      print(string1);
      return skills;
    } catch (error) {
      throw Exception(error);
    }
  }

  List<String> convertStringToList1(
      String? string1, String? string2, String? string3, String? string4) {
    try {
      List<String> skills = [];
      if (string1 != null) {
        skills.add(string1);
        print(1222);
      }
      if (string2 != null) {
        skills.add(string2);
      }
      if (string3 != null) {
        skills.add(string3);
      }
      if (string4 != null) {
        skills.add(string4);
      }
      print(string1);
      return skills;
    } catch (error) {
      throw Exception(error);
    }
  }
}
