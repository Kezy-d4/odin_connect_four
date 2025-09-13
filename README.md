# Connect Four
A Connect Four command line game programmed in Ruby as part of 
[The Odin Project](https://www.theodinproject.com/) curriculum. The primary 
learning objectives of this project were to practice with RSpec, testing, and
Test-Driven Development.

# Screenshot
<img width="318" height="282" alt="Screenshot from 2025-09-12 18-26-28" src="https://github.com/user-attachments/assets/eedfc5cd-6c3a-40a9-a00f-dd6a220c7b71" />


# Video Demo
[connect_four_tdd.webm](https://github.com/user-attachments/assets/3096b6f9-bcb0-441b-a504-16bafc346887)

# Reflections
This project revealed to me the benefits of testing in remaining confident in the code as development progresses, allowing for easy extension and refactoring. 

That said, I barely discovered a nasty bug during play testing that slipped through my automated tests. I suppose then that tests can't always protect you from what you don't anticipate could go wrong or oversights in the design and code. 

The bug was to do with the four-in-a-row connection detecting logic. When a connection forming token was dropped at either end of a line, the line would be detected, but if the token was dropped somewhere in the middle of the line, it would not. I manged to resolve the bug with a less than ideal solution. I ended up refactoring my detection logic to check every single cell on the board for every possible line each time a player drops a token into the board. I recognize how horribly inefficient that is in terms of performance and time complexity, but for the purposes of this project, I decided to stomach it. Though I would like to give greater consideration to DSA solutions that could alleviate this kind of problem as I move onto Chess.

As for the tests, I tried to employ TDD wherever I could, and I did for many of the methods. For others though, I couldn't resist writing the method first and the tests after. 

Overall, I'm fairly happy with how the project turned out and I invite you to review the code and install the game. Thank you
