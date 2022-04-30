# Tracker
No intrusive time tracker.

## Why?

I needed track the time spend programming but tecniques like pomodoro don't work for me because unfocus my attention repeatly, this script only track the time and you need stop or pause the script when you are done. When you stop the time elapsed is saved to a logfile.  

## Instalation

Only execute the script like `./tracker.sh` or you can create an alias in your bash or zsh profile file like `alias tracker=<Path-to-Script>`

## Usage

![usage](https://github.com/hyperdarker/tracker/blob/main/img/usage.png)

`./tracker.sh` to start tracking the time with the defaults.

`./tracker.sh 240` you can pass the minutes suggested to the session, this is only a reminder, the script don't stop if the time is raised.

`./tracker.sh log` to show the previous sessions.

## Configuration

![config](https://github.com/hyperdarker/tracker/blob/main/img/config.png)
<!-- ![config](https://raw.githubusercontent.com/hyperdarker/tracker/main/img/config.png) -->

`MINUTES` Default minutes expected for a session.
`FILEPATH` Directory path to logfile
`FILENAME` Logfile name

