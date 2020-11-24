<!-- @format -->

# Sprint 3 Backlog

> implementation goals before November 29th

### Front-End

- Add new navigation tab
  - [x] Move account page to the side tab
  - [x] Split change user info and social media into 2 different pages
  - [x] Add Google Maps view to the bottom navigation
- Add Event with Location
  - [x] Implement current location reader
  - [x] Add location picker
- Add Google Maps
  - [x] Show Google Maps view of the campus
  - [x] Display pins of the events coming up
  - [x] View event from Map view
- Events Feed Page
  - [x] Add new event types: `Mission` and `Volunteer`
  - [ ] Add a filter for type of event
  - [ ] Only show future events
- Event RSVP Page
  - [ ] Add a button in Event detail page `View RSVP list`
  - [ ] Show list of users in the RSVP list
- Prayers Page
  - [x] Add a button in Prayer Requests page `View Prayed list`
  - [ ] Show list of interacted in the prayer list
  - [ ] Only show recent prayers (10 days since created)
- Account Page
  - [x] Display list of events you RSVPed to
  - [x] Display list of prayer requests you prayed for
- Friending System
  - [ ] Favorite other users from their username
- Other user profile page
  - [ ] Display the account page with another user's info and a button to favorite them
- Website
  - [ ] Add Sprint 2 Deliverables
  - [ ] Add Sprint 3 Deliverables
  - [ ] Demo Video
- Presentation
  - [ ] Slides
  - [ ] Demo
- GitHub
  - [ ] Create App Icon
  - [ ] Create social preview
  - [ ] Documentation of the Code
  - [ ] Open-Source Licensing (MIT)

### Back-End

- Event Location
  - [x] Edit `location` attribute from String type to coordinates
- Read list of Users
  - [ ] Store list of `UserData` locally associated with their UserID
- Account Interactions
  - [x] Store RSVPed list
  - [x] Store Prayed list
- Account Profile
  - [ ] Upload profile image
  - [ ] Read profile image
  - [ ] Detect any duplicate usernames associated with other accounts
- Account Friends
  - [ ] Favorite other users
