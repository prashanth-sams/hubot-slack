## Hubot Slack
> A chatbot for [#slack] using [Hubot] service

<a href="https://twitter.com/intent/tweet?text=%23hubot%20%23slack%20%23Chatbot%20%23DevOps&url=https://github.com/prashanth-sams/hubot-slack"><img src="https://img.shields.io/twitter/url/https/github.com/prashanth-sams/hubot-slack/.svg?label=Tweet&style=social"></a>

#### Hubot Slack runner

```
$ .bin/hubot --adapter <your_adapter_name> HUBOT_SLACK_TOKEN=xxxx-xxxx-xxxx-xxxx \
              HUBOT_GITHUB_API=https://api.github.com \
              HUBOT_GITHUB_TOKEN=xxxx \
              HUBOT_GITHUB_USER=xxxx \
              HUBOT_GITHUB_REPO=xxxx
```

### Slack interaction

- Let's start interacting with the bots created; let's say, `hubot help`
- You can customize the bot name `hubot` with `your_custom_bot_name`. In this project, I named it as `sams` from `bin/hubot.cmd && bin/hubot` and made sure the bot name is the same while creating hubot slack token; so, my statement looks like, `sams help`

```
hubot> hubot help
hubot help - Displays all of the help commands that hubot knows about.
```

The list of commands that qualify under this implementation is described below, along with additional info.

| Command     | Description |
| ---      | ---       |
| `hubot issue <#number>` | Lists an issue with specific number         |
| `hubot issue any all` | Lists all the issues         |
| `hubot issue any all <#label>`     | Lists all the issues with specific label        |
| `hubot issue any all <“text”>`     | Lists all the issues with specific text        |
| `hubot issue any <assignee>`     | Lists all the issues assigned to a known github user        |
| `hubot issue any <assignee> <#label>`     | Lists all the issues with specific label assigned to a known github user        |
| `hubot issue any <assignee> <“text”>` | Lists all the issues with specific text assigned to a known github user         |
| `hubot issue closed all` | Lists all the closed issues         |
| `hubot issue closed all <#label>` | Lists all the closed issues with specific label         |
| `hubot issue closed all <“text”>` | Lists all the closed issues with specific text         |
| `hubot issue closed <assignee>` | Lists all the closed issues assigned to a known github user         |
| `hubot issue closed <assignee> <#label>` | Lists all the closed issues with specific label assigned to a known github user         |
| `hubot issue closed <assignee> <“text”>` | Lists all the closed issues with specific text assigned to a known github user         |
| `hubot issue open all` | Lists all the open issues         |
| `hubot issue open all <#label>` | Lists all the open issues with specific label         |
| `hubot issue open all <“text”>` | Lists all the open issues with specific text         |
| `hubot issue open <assignee>` | Lists all the open issues assigned to a known github user         |
| `hubot issue open <assignee> <#label>` | Lists all the open issues with specific label assigned to a known user         |
| `hubot issue open <assignee> <“text”>` | Lists all the open issues with specific text assigned to a known user         |
| `hubot issue close <#number>`     | Close an existing issue        |
| `hubot issue reopen <#number>`     | Re-open an existing issue        |
| `hubot issue create <“title”>`     | Create an issue with title        |
| `hubot issue create <“title”> <#label>`     | Create an issue with title and label        |
| `hubot issue create <“title”> body <{body}>`     | Create an issue with title and body        |
| `hubot issue create <“title”> body <{body}> <#label>`     | Create an issue with title, body, and label        |

### Support
- <a href="https://twitter.com/intent/follow?screen_name=prashanthsams"><img src="https://img.shields.io/twitter/follow/prashanthsams.svg?style=social" alt="follow on Twitter"></a>


### Blogs

- [Hubot Slack setup]

[#slack]: https://slack.com/
[Hubot]: https://hubot.github.com/
[Hubot Slack setup]: https://devopsqa.wordpress.com/2019/03/19/hubot-slack-setup/
