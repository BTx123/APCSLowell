In Class exercise
============
1. Fork and clone down [this respository]("https://github.com/APCSLowell/Thingies")
2. Open the Thingies folder in Sublime, or open Thingies.pde in Processing.
3. Run the program. You should get an error message that says `The field Thingy.myX is not visible` because the *client* code in `setup()` is trying to access `private` member variables.
4. Fix the program by 
  * finishing the four setter and getter functions in `Thingy.java`
  * rewriting the *client* code in `setup()` to use the four setter and getter functions
5. The finished program should print `Distance between bob and mary is 56.568542`
6. Show your teacher the finished program.
