# Making a contribution
Thanks for helping with the MyMGS app! To make sure development can go as smoothly as possible, please follow this guide when making a contribution.

## Git
Before doing anything code-related with this repository, please ensure you know the basics of Git. You don't need to be able to do anything fancy, but it's quite easy to mess up your repository (and lose your work) if you don't use Git correctly. Basically, just choose any of [these videos](https://www.youtube.com/results?search_query=git+tutorial) and ask Pal any questions you have.

Also, always follow these best practices:

- Commit as often as possible. As long as you're using your own branch, it doesn't matter if your commit contains completely broken code — but keep committing to avoid conflicts with someone else who might be working on your branch too.
- Pull as often as possible. Not having changes locally available could cause several problems. Always remember that Git only connected to the internet when you explicitly use `git push`, `git pull`, or `git fetch`. Running `git checkout` or `git merge` will use the locally available repository from the last time you ran `git pull`.
- Don't pull when you have uncommitted changes. Or at least avoid it. Git will try to give you a nice error, but sometimes it gets buggy.
- Use Google! If Git gives you an error, don't try and throw random commands at it. Take some time to research the issue first.
- Pull requests and `git merge` are two different things. Use `git merge` to locally merge two branches on your computer, and create a pull request to request a formal code review before merging into the `master` branch. Only Pal can push changes to master, so trying to `git merge` a branch into master on your computer will result in an error.

## Agile guide
1. In the [project tracker](https://github.com/My-MGS/my-mgs/projects/1), find an issue or task that you like, and drag it into the 'In progress' section. Do not work on tasks that were dragged there by others. Also, only move a task into this section if you are **currently** working on it — don't reserve tasks for future work.
2. Create a **new branch** from the latest commit on the `master` branch. Make sure you pull your code locally before doing this. Give your branch a sensible name, and **include the issue number** in the branch name.
3. Make your changes in the branch. Try to use many small commits if possible (rather than few large commits), but avoid committing code that introduces a compile-time error. Runtime errors are acceptable in working branches, but not in the `master` branch. Always push commits immediately after making them.
4. Once you're ready, open a new [pull request](https://github.com/My-MGS/my-mgs/pulls). Describe your implementation in as much detail as possible, as well as any notes that future developers working on the new code you added should be aware of. Make sure to mention any issue numbers that the PR relates to (e.g. put '#2' in the PR body somewhere)
5. Someone will review your code and leave comments suggesting improvements. Please respond to these promptly by adding new commits to your branch (new commits are automatically added to pull requests) and marking comments as resolved.
6. Once the reviewer has marked your PR as accepted, click the 'Merge' button on GitHub (avoid merging PRs locally). If there are any merge conflicts you can't resolve, feel free to ask for help.

## Design work
When making UX wireframes or UI mockups, using [Figma](https://www.figma.com/) is highly recommended. The paid plan is free for MGS students and staff. Just verify your educational account, and then ask Pal to add you to the team!
