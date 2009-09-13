## Exercise 2 - refactoring

### Before starting:

    $ rake db:migrate
    $ rake db:test:prepare
    $ rake cucumber
    $ rake spec

You should see that we have:

* 36 passing code examples
* 13 passing scenarios
* 3 failing scenarios *

Take a look at those, and take a look at the passing scenarios to get a feel
of how the app should be behaving at this point. Note that the scenarios in
the "prioritize cards in an iteration" feature are passing, but the
"prioritize cards in the backlog" scenarios are failing.

We're using `acts_as_list` to manage the relationship between Iteration as
list-owner, and Card as list-item. This allows us to prioritze cards within
iterations, but there is no backlog object in our system. If a card's
`iteration_id` is nil, it is considered to be in the backlog. This means that
we can't exploit acts_as_list to do the ordering work for cards in backlog
that it's already doing for iterations.

The exercise is to refactor the design as follows:

* Add a Backlog class
* Change Card to belongs_to :container, :polymorphic => true
  * Backlog and Iteration are the two container types
  
Alternate refactoring:

* Add a Backlog class
* Add a CardCollection class
  * belongs_to :container, :polymorphic => true
    * Backlog and Iteration are the two container types
