# myportfolio_mobile

A new Flutter project.

## Project Description
This is a Flutter mobile application developed for the Individual Assignment 7. It serves as a mobile portfolio, displaying student identity information  through InfoCards. The app also features a grid of interactive action buttons (ItemCards) with unique colors that display a SnackBar notification when tapped. 

### How to Run
1. Make sure you have Flutter installed.
2. Clone the repository.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run -d chrome` to start the application in the browser.

### Assignment 7

1. What is a widget tree and how do parent-child relationships work?

The widget tree is basically the skeleton of the UI in Flutter. Everything you see on screen — text, buttons, images — is a widget. They're arranged in a hierarchy, like a family tree. A parent (say, a Column or Row) holds its children and controls them: it decides where each child ends up on screen and how much space it gets. When the parent updates, it usually drags its children along — they rebuild together with it.

2. Which widgets were used and what for

MaterialApp — the root of the app. Sets the theme (colors, fonts) and handles navigation.

Scaffold — the basic screen frame: AppBar on top, body in the middle.

AppBar — the top bar where the "MyPortfolio" title is displayed.

Text — for the name, NPM, and welcome message.

Row — places the three InfoCards side by side horizontally.

Column — stacks things vertically: first the row of cards, then the grid.

Card — the container for InfoCard with a slight shadow.

Container — inside InfoCard, limits the width and adds padding.

Padding — breathing room around content so it doesn't stick to the edges.

GridView.count — a three-column grid for the buttons.

Material + InkWell — together they make a clickable button with a ripple effect on tap.

Icon — folder, plus, and logout icons.

ScaffoldMessenger — shows the SnackBar at the bottom of the screen.

3. Why is MaterialApp needed and why is it the root?

MaterialApp is the foundation. It gives the app its Material Design look and provides all the other widgets with the context they need: Navigator for switching between screens, Theme for colors. We put it at the very top because it works as a wrapper — without it, the inner widgets simply wouldn't know how to look or behave.

4. How does StatelessWidget differ from StatefulWidget, and when to use which

StatelessWidget is static. It's built once and never changes. Great for anything fixed — like our MyHomePage, which just shows static info and buttons.

StatefulWidget is alive. It can change over time (a counter, a form). Inside it has a State object, and to update the UI it calls setState(). You should only reach for it when the screen needs to react to user actions or load data. In this assignment everything is static, so we didn't need it.

5. What is BuildContext and why is it important? How is it used in build?

BuildContext is a map that tells a widget exactly where it sits in the tree. It's essential: through the context a widget can look up things from its parents — like the current theme. In the build method we write ScaffoldMessenger.of(context) — that means "find the ScaffoldMessenger above me in the tree and show a SnackBar through it."

6. Hot reload vs. hot restart — what's the difference?

Hot reload injects new code into the already-running app instantly, but keeps the current state — it remembers which page you're on and what you've typed. Hot restart, on the other hand, wipes the memory and starts the app from scratch.

Hot reload won't work if you've changed global variables, the main() function, or the app's core structure — in those cases you need a hot restart.

AI Disclosure: I used AI for better understanding fuctions and discussed questions.