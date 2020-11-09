class Prayer {
  final String id;
  final String title;
  final String description;
  final String userID;
  final List prayerInteractions;
  final String createdAt;
  final bool anonymous;

  Prayer(
      {this.id,
        this.title,
        this.description,
        this.userID,
        this.prayerInteractions,
        this.createdAt,
        this.anonymous});
}
