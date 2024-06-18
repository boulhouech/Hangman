**Hangman Game Documentation**

**Overview**

The Hangman game is a console-based game where the user tries to guess a randomly selected word by suggesting letters. The game is implemented in Ruby and consists of three classes: `Game`, `Hangman`, and `Main`.

**Game Class**

The `Game` class is responsible for managing the game state and flow. It initializes a new game, picks a random word, and handles user input.

**Attributes**

* `correct_guesses`: An array of correct guesses made by the user, initialized with underscores representing the word to be guessed.
* `remaining_attempts`: The number of remaining attempts the user has to guess the word, initialized to 10.
* `option`: The user's choice to start a new game or load a saved game.
* `random_word`: The randomly selected word to be guessed, chosen from a file of words.

**Methods**

### `initialize`

Initializes a new game by picking a random word, setting up the correct guesses array, and setting the remaining attempts to 10.

### `user_option(option)`

Prompts the user to choose an option (1 or 2) and sets the `option` attribute accordingly. Based on the user's choice, it either starts a new game or loads a saved game.

### `pick_random_word`

Selects a random word from a file of words, ensuring the word length is between 5 and 12 characters.

### `start_new_game`

Starts a new game with the randomly selected word.

### `play_game(word)`

The main game loop, which continues until the user wins or runs out of attempts. It displays the game state, prompts the user for input, updates the correct guesses and remaining attempts, and checks for winning or losing conditions.

### `display_game_state(correct_guesses, incorrect_guesses, max_incorrect_guesses)`

Displays the current game state, including the word, incorrect guesses, and remaining attempts.

### `get_user_guess`

Prompts the user to enter a letter and returns the input.

### `update_correct_guesses(word, correct_guesses, guess)`

Updates the correct guesses array based on the user's input.

### `won?(correct_guesses, word)`

Checks if the user has won the game by comparing the correct guesses array with the original word.

### `congratulate_user(word)`

Displays a congratulatory message when the user wins.

### `lost?(remaining_attempts)`

Checks if the user has lost the game by running out of attempts.

### `sorry_user(word)`

Displays a sorry message when the user loses.

### `save_game(correct_guesses, incorrect_guesses, remaining_attempts, word)`

Saves the current game state to a file, including correct guesses, incorrect guesses, remaining attempts, and the word.

### `load_saved_game`

Loads a saved game from a file, prompting the user to choose a saved game and then resuming the game from the saved state.

**Hangman Class**

The `Hangman` class is responsible for drawing the Hangman gallows and figure based on the number of lives remaining.

**Methods**

### `draw_it(lives)`

Draws the Hangman gallows and figure based on the number of lives remaining. The figure is drawn in stages, with each stage representing a decrease in lives.

**Main Class**

The `Main` class is the entry point of the Hangman game application. It initializes a new game and provides a menu for the user to start a new game or load a saved game.

**Attributes**

* `@game`: An instance of the Game class, which manages the game state and flow.

**Methods**

### `initialize`

Initializes a new Main object, creating a new instance of the Game class.

### `start_game`

Starts the game by displaying a welcome message and a menu with two options: start a new game or load a saved game. It prompts the user to enter their choice and passes it to the `user_option` method of the Game class to handle the user's selection.

**Usage**

To start the game, create a new instance of the Main class and call the `start_game` method:
```
main = Main.new
main.start_game
```
This will display the welcome message and menu, allowing the user to start a new game or load a saved game.
