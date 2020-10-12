<!-- @format -->

# Sprint 1 Backlog

> implementations to be done before October 13th

### Authentication

- [x] Install and set up Firebase
- [ ] Wrapper
  - listen to authentication change using Stream
  - switch pages according to the user state
- [x] Sign Up using Email and Password
- [x] Sign In using Email and Password
- [x] Sign Out

### Database

- [x] Install and set up Cloud Firestore
- [x] Create and store user accounts database
  - fields: firstname, lastname, username, email, profile image, description, social media
- [x] Create and store events database
  - fields: user id, time created, title, location, time, type of event, description
- [x] Create and store prayer requests database
  - fields: user id, time created, title, description, anonymous (boolean), prayer counter (integer)

### User Interface

- [x] Log In page
  - fields: email, password
  - log in button
  - sign up reference button
- [x] Sign Up page
  - fields: firstname, lastname, username, email, password
- [ ] Feed home page
  - view list of events
  - sign out button here for now
- [x] Add event page
  - fields: title, location, time, type of event, description
  - types of events: bible study, worship, social event, other
- [x] Add prayer request page
  - fields: title, description, anonymous (boolean)
- [ ] Navigation Bar
  - tabs: events, prayers, account
