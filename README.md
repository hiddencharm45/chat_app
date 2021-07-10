# chat_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

ADDING FIREBASE rules
Locking database only to authenticated users
nested matches which match individual path inside our database


to make user write and manupulate only their data and not other user's data we'll add another rule
match/users/{uid}{
    allow write: if reuqest.auth!=null && request.auth.uid==uid;
}
match /users/{uid}{
    allow read:if request.auth!=null;
}
match/chats/(document=**){
 allow read,create :if request.auth!=null;
}
simulation can also be done