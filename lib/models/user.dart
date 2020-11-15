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
  final List favoritesList;
  final List rsvpedList;
  final List prayedList;
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
      this.favoritesList,
      this.rsvpedList,
      this.prayedList,
      this.twitter,
      this.facebook,
      this.instagram});
}
