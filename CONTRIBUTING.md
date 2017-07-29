## Contributing

First off, thank you for considering contributing to ordinare.

### 1. Where do I go from here?

If you've noticed a bug or have a question you
[search the issue tracker](https://github.com/nikolalsvk/ordinare/issues?q=something)
to see if someone else in the community has already created a ticket.
If not, go ahead and [make one](https://github.com/nikolalsvk/ordinare/issues/new)!

### 2. Fork & create a branch

If this is something you think you can fix, then
[fork Active Admin](https://help.github.com/articles/fork-a-repo)
and create a branch with a descriptive name.

A good branch name would be (where issue #325 is the ticket you're working on):

```sh
git checkout -b 325-add-japanese-translations
```
### 3. Get the test suite running

To get the test suite running you can do:

```
bundle install
```

This will install RSpec needed to run the tests

```
bundle exec rspec
```

### 4. Implement your fix or feature

At this point, you're ready to make your changes! Feel free to ask for help;
everyone is a beginner at first :smile_cat:

### 5. Make a Pull Request

You should switch back to your master branch and make sure it's
up to date with ordinare's master branch:

```sh
git remote add upstream git@github.com:nikolalsvk/ordinare.git
git checkout master
git pull upstream master
```

Then update your feature branch from your local copy of master, and push it!

```sh
git checkout 325-add-japanese-translations
git rebase master
git push --set-upstream origin 325-add-japanese-translations
```

Finally, go to GitHub and
[make a Pull Request](https://help.github.com/articles/creating-a-pull-request)
:D

Semaphore will run our tests and report back with tests results.

### 6. Keeping your Pull Request updated

If a maintainer asks you to "rebase" your PR, they're saying that a lot of code
has changed, and that you need to update your branch so it's easier to merge.

To learn more about rebasing in Git, there are a lot of
[good](http://git-scm.com/book/en/Git-Branching-Rebasing)
[resources](https://help.github.com/articles/interactive-rebase),
but here's the suggested workflow:

```sh
git checkout 325-add-japanese-translations
git pull --rebase upstream master
git push --force-with-lease 325-add-japanese-translations
```
