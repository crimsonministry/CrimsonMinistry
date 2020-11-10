class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String fname;
  final String lname;
  final String username;
  final String bio;
  final String ministry;
  final List friends;
  final List requests;
  final List requested;
  final String twitter;
  final String facebook;
  final String instagram;

  UserData(
      {this.uid,
      this.fname,
      this.lname,
      this.username,
      this.bio,
      this.ministry,
      this.friends,
      this.requests,
      this.requested,
      this.twitter,
      this.facebook,
      this.instagram});
}
