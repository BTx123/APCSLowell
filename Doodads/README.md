In Class exercise
============
1. Fork and clone down [this respository]("https://github.com/APCSLowell/Doodads")
2. Open the Doodads folder in Sublime, or open Doodads.pde in Processing.
3. Run the program. You should get an error message that says `The field Doodad.myNum is not visible` because the *client* code in `setup()` is trying to access a `private` member variable.
4. Fix the program by 
  * finishing the two setter and getter functions in `Doodad.java`
  * rewriting the *client* code in `setup()` to use the two setter and getter functions
5. The finished program should print `Sum is 5.859870195388794`
6. Show your teacher the finished program.
