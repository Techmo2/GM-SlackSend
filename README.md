# SlackSend

## What is SlackSend?
SlackSend is a server addon that allows players within the server to submit reports on the fly.

## Usage
At the moment, **SlackSend** only has one command:
```
!report <playername> <report message>
```

An Example:
```
!report newbie22 killing everyone on the team
```
This will show up on the slack server as:
```
(Player Abuse Report)
By: CoolGuy123
Offender: newbie22
Reason:  killing everyone on the team
```
## Configuration
Before SlackSend can be used, it must be provided with a Slack **incoming-webhook** url, which can be found in the channel settings. This should be inserted into ```slackURL```.

The channel also needs to be configured. By default, the channel is set to be **#general**. To change the channel, you will need to set the ```slackURL``` to the incoming-webhook url for that channel, and change ```slackChannel``` to the desired channel.

The Slack username can also be changed. This is simply what username the messages appear under.
