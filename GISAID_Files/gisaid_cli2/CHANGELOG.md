**v2.1.6**

- set `type = str` for username and password argparse objects

**v2.1.5**

- dev branch

**v2.1.4**

- removed timeout from call_api

**v2.1.3**

- updated demo locations to prevent `exception` errors being returned from API

**v2.1.2**

- refactored `uploader` to `cli2` throughout
- pushed tag 2.1.2
- updated readme.md, preparing for release via GISAID portal

**v.2.1.1**

- relative imports are now absolute
- restructured package to allow absolute imports
- pushed tag 2.1.1 (message "release 2.1.1")
- using CHANGELOG.md
- added `uploader/data/known_bugs.txt`
- updated FAQ in README.md

**v2.1.0**

- touch CHANGELOG.md
- pushed (first) tag 2.1.0 (message "release 2.1.0")
- breaking changes:
    - changed the help menu and user interface considerably
        - will no longer work now with calls to version 1 help menu layout
    - frameshifts notifications
        - submitters now have option to use `cli2` to set frameshift notification preferences
- created a python package by refactoring version 1 of the CLI script
- added test data
- added install instructions
- re-wrote documentation
- added runtime clock
- defaults now to appending of log and fails
    - prevents need to guess at what has succeeded (records now preserved in appended logs, not overwritten logs or ephemeral stdout/stderr)
    - prints progress of run to stdout
- removed need to revoke authtokens; instead, now advising users to delete manually and re-create
- removed sys.exit from script when a bad record is found, now continues to end of submission (saving log of fails instead of failing)
    - this is to avoid abortion of entire upload when, for instance, record 5001 of 5002 is bad the submitter does not need to repeat entire submission
- used CI/CD via gitlab CI
- invited beta testers via dev repo, feedback has been received and changes implemented

**v2.0.1**

- moved dev to gitlab
- created package



