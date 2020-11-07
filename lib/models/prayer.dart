class Prayer {
  final String id;
  final bool anonymous;
  final String title;
  final String description;
  final int count;
  final String userID;

  Prayer(
      {this.id,
      this.anonymous,
      this.title,
      this.description,
      this.count,
      this.userID});
}
