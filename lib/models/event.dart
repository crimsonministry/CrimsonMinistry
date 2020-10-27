class Event {
  final String id;
  final String title;
  final String location;
  final String time;
  final String typeOfEvent;
  final String description;
  final List rsvp;
  final String userID;

  Event(
      {this.id,
      this.title,
      this.location,
      this.time,
      this.typeOfEvent,
      this.description,
      this.rsvp,
      this.userID});
}
