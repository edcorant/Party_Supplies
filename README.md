Original App Design Project - README Template
===

# Party Supplies!

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
A party supplies assigner app, where you and your friends share a list of stuff needed for a party (like different snacks, different drinks, glow sticks, etc) and each person can sign up to bring one. This way everybody knows what to bring without conflicts and in the end the party would have everything.

### App Evaluation
- **Category:**
Productivity
Lifestyle
Social
- **Mobile:**
This app is intended to be developed for mobile devices (iOS specifically) but could have similar 
usefulness on a computer or other mobile devices(android). Mobile version could potentially have more detailed features.
- **Story:**
Allows user to organize an event by creating a party where they can add members, and assign the supplies needed for the party to the members. Members of a party can also choose an item they would like to bring to the party.
- **Market**
Any individual from any age group can is allowed to use thise app.
- **Habit:**
This app could be used as many times as needed by the user, depending on their lifestyle. There is no restriction to the amount of parties that can be created.
- **Scope:**
This app can start by first providing the ability to organize a party and assign supplies to members and  can eventually become a social app like instagram, broadening itsthe usage and its functionality. The app can become a way to keep others updated on your social life and to notify others of future events in a fun way. Additionally, the app has potential for use with other popular appslications such as twitter, cashapp(money transfers), and more.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* [x] User can register a new account.
* [x] User can log in.
* User can create a party and add members.
* User can create a list of supplies needed for party.
* Party attendees can choose an item from the list to bring to the party.

**Optional Nice-to-have Stories**
* A pay back system to let users exchange money (facilitated by CashApp).
* A history of parties the user has attended.
* Allow users to exchange photos after the party.
* Allow users to add a link to a spotify group session.
* Let user know if nearest store has item in stock (like a Target?)

### App in Action

Here's a small walkthrough of implemented user stories:

<img src='https://i.imgur.com/cgnj3fI.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />



### 2. Screen Archetypes

* Sign Up/Sign In screen
    * User can register a new account.
    * User can log in.
* Your Parties screen
    * User can create a party object.
    * User can edit existing parties.
    * Show history of parties user has thrown (tentative).
* Add Friends screen
    * User can look up friends and add them to their list of friends.
* Upcoming screen
    * User can see the parties they've been invited to and check supplies they'd like to bring to those parties.
* Your Profile screen
    * User can see their profile info.
    * User can edit their profile.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Upcoming (main screen)
* Add Friends
* Your Parties
* Your Profile

**Flow Navigation** (Screen to Screen)

* Sign Up/Sign In screen
    * Upcoming
* Your Parties screen (list of future parties you'll be throwing)
    * Add Friends (tab item)
    * Upcoming (tab item)
    * Your Profile (tab item)
    * Create Party button
* Add Friends screen
    * Your Parties (tab item)
    * Upcoming (tab item)
    * Your Profile (tab item)
* Upcoming screen (list of future parties you'll be attending, including your own parties)
    * Your Parties (tab item)
    * Add Friends (tab item)
    * Your Profile (tab item)
    * Past Parties screen
        * Any one past party (here user can see party photos uploaded by attendees)
* Your Profile screen
    * Your Parties (tab item)
    * Add Friends (tab item)
    * Upcoming (tab item)
## Wireframes
<img src="https://ibb.co/bvjgxpX" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
#### User
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | username      | String   | username of current logged in user |
   | name          | String   | current User's name |
   | userID        | int      | current user's ID |
   | isLoggedIn    | bool     | checks login status |
   | suppliesToBuy | Array    | list of supplies assigned to the current user |
   | pPicture      | File     | users profile picture |
   | friends       | Array    | array of user objects (?) |
   
#### Party

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the party (default field)|
   | author        | Pointer to User| party creator |
   | attendees     | Array    | array w/ pointer to user objects attending |
   | image         | File     | image for the party (optional? has default value) |
   | description   | String   | party description by author     |
   | attending     | Number   | number of people attending party |
   | partySupplies | Array    | things needed for the party to happen |
   | createdAt     | DateTime | date party was created |
   | updatedAt     | DateTime | date when party was last updated|
   | occurringOn   | DateTime | date party is happening |
   | spotifyURL    | String   | URL for party playlist (tentative) |
   
#### Supply
 | Property      | Type     | Description |
 | --------------|----------|-------------|
 | objectId      | String   | unique id for the object |
 | partyId       | String   | unique id for party item belongs to |
 | wasCollected  | bool     | checks whether item is still to be bought |
 | supplyItemName | String  | name of item needed |
 
### Networking
#### List of network requests by screen
- Home Feed Screen
  - (Read/GET) Get all parties user is attending
    ```swift
         let query = PFQuery(className:"Party")
         query.whereKey("attendees", equalTo: currentUser) //idk if this would work
         query.order(byDescending: "occurringOn")
         query.findObjectsInBackground { (parties: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let parties = parties {
               print("Successfully retrieved \(parties.count) parties.")
           // TODO: Do something with posts...
            }
         }
     ```
  - (Create/POST) Create party
    ```swift
    let party = PFObject(className:"Party")
    party["author"] = currentUser
    party["attendees"] = "Sean Plott"
    party["image"] = *pending*
    party["description"] = "bla bla bla lorem ipsum" 
    party["attending"] = 20
    party["partySupplies"] = [Array with all objects for party]
    party["createdAt"] = // idk what this is supposed to be formatted as
    party["updatedAt"] = // idk what this is supposed to be formatted as
    party["occurringOn"] = // idk what this is supposed to be formatted as
    party["spotifyURL"] = "spotify.com/whatever"
    party.saveInBackground { (succeeded, error)  in
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }
    ```
- Profile Screen
  -  (Read/GET) Query logged in user object
     ```swift
     let currentUser = PFUser.current()
     // pending setup, don't know how screen will look yet.
     ```
  
  - (Update/PUT) Update user profile image
     ```swift
     let currentUser = PFUser.current()
     currentUser["pPicture"] = // pretend file is handled here
     currentUser.saveInBackground()
     ```
 
- Your Parties Screen
  - (Read/GET) Query for parties user is subscribed to
      ```swift
      let query = PFQuery(className:"Party")
      query.whereKey("author", equalTo: currentUser) //again, idk if this would work
      query.findObjectsInBackground { (parties: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let parties = parties {
               print("Successfully retrieved \(parties.count) parties.")
           // TODO: Do something with posts...
            }
         }
      
      
      ```

- Add Friends Screen
  - (Update/PUT) Update user friends
     ```swift
     let currentUser = PFUser.current()
     currentUser["friends"] = // pretend this is handled here
     currentUser.saveInBackground()
     ```
