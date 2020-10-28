class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String fname;
  final String lname;
  final String username;
  final List friends;
  final List requests;
  final List requested;

  UserData(
      {this.uid,
      this.fname,
      this.lname,
      this.username,
      this.friends,
      this.requests,
      this.requested});
}
