# README

A Chemistry quiz website for students taking A-level Chemistry written using Ruby on Rails

A production version can be found at: https://shocking-zombie-04284.herokuapp.com/

## Features

- Randomly generated quizzes on:
  - Chemical symbols
  - Element names
  - Molecule properties
  - Mole calculations (in progress)
- User signup to record your best scores for each quiz
- Global high scores and fastest time for each quiz


## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```
