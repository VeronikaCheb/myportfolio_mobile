# myportfolio_mobile

A new Flutter project.

## Project Description
This is a Flutter mobile application developed for the Individual Assignments 7 and 8. It serves as a mobile portfolio, displaying student identity information through InfoCards. The app features a grid of interactive action buttons (ItemCards) and a navigation drawer. 

### How to Run
1. Make sure you have Flutter installed.
2. Clone the repository.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run -d chrome` to start the application in the browser.

### How to Use
Once the app is running, you can:
- **View your profile**: The top of the screen shows your NPM, Name, and Class.
- **Navigate**: Click the hamburger menu (three lines) in the top left corner to open the Drawer.
- **Add Project**: Click the "Add Project" button on the home screen or in the drawer. Fill in the form (Name, Description, Category, etc.) and press Save.
- **Add Experience**: Click the "Add Experience" button on the home screen or in the drawer. Fill in your Role, Description, and Category, then press Save.

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

### Assignment 8

1. Explain the differences between Navigator.push(), Navigator.pushReplacement(), and Navigator.pop(). Which method opens the form from the action card? Explain how the Home option in the drawer takes the user back to the home screen.

`Navigator.push()` opens a new screen on top of the current one. It keeps the previous screen in the background, so when you press the system Back button, you just return to where you were. We use this to open the Experience form from the action card. 

`Navigator.pushReplacement()` opens a new screen but removes the current one from the memory stack. If you press Back after this, you won't go to the previous screen; you'll exit or go to the one before it. We use this in the Drawer menu so we don't stack up screens endlessly. 

`Navigator.pop()` just closes the current screen (or dialog) and goes back. 

The Home option in the Drawer uses `pushReplacement()` to load the MyHomePage, effectively replacing the form screen with the home screen.

2. How does the arrangement of Scaffold, AppBar, and Drawer keep the page structure consistent? Give one example of the portfolio theme colors being used on more than one page.

Using `Scaffold` as the foundation for every page ensures the layout is always the same (AppBar at the top, body in the middle). We also reuse the `LeftDrawer` widget across all screens (Home, Add Project, Add Experience), so the navigation menu looks and works exactly the same everywhere. 

For the colors, we use our custom dark green (`#00674F`) as the background for the `AppBar` on the Home page, the Project Form page, and the Experience Form page. This keeps the visual identity consistent.

3. Why was this layout chosen for the form? Explain what the spacing and scrolling widgets do when screen space is limited.

I used a `SingleChildScrollView` wrapped around a `Column` because mobile screens are small, and when the keyboard pops up, it covers half the screen. If we didn't have the scroll view, the "Save" button would be pushed off-screen and the user couldn't press it. 

The `Padding` around each `TextFormField` ensures the input boxes don't touch the edges of the screen, making it look clean and preventing accidental taps.

4. What roles do GlobalKey<FormState>, validator, and validate() play when Save is pressed? Give one example of a value the form rejects and explain why choosing an input widget or keyboard type alone is insufficient.

`GlobalKey<FormState>` is like a remote control for the form. When we press Save, we call `_formKey.currentState!.validate()`. This tells the form to run every `validator` function attached to the fields.

For example, if the "Role / Position" field is empty or just spaces, the validator returns "Enter a role or position.", and the form refuses to submit. 

Just using an input widget or setting the keyboard type (like `TextInputType.url`) is not enough because the user can leave the field empty or paste garbage. The `validator` is the only thing that actually checks the content before saving and enforces the rules.

AI Disclosure: I used AI to help me figure out how to structure of folders and combine paths. I manually tested the form in Chrome, made sure the error messages appeared correctly, and fixed the styling to match my portfolio colors. Also I discussed questions with AI.