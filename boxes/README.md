# Boxes

A box represents an exercices that the student has to accomplish.

A box is configured with an `box.ini` file that contains all the meta-data:
* `id`: box unique identifier
* `title`: box title displayed in frontend
* `dependencies`: the list of boxes that must be unlocked by the student before trying this one
* `tags`: list of arbitrary strings
* `engine`: engine used to test this box
* `stars`: the list of stars that can be unlocked in this box
