## Hubot Slack
> A chatbot for [#slack] using [Hubot] service

<a href="https://twitter.com/intent/tweet?text=%23hubot%20%23slack%20%23Chatbot%20%23DevOps%20%40prashanthsams&url=https://github.com/prashanth-sams/hubot-slack"><img src="https://img.shields.io/twitter/url/https/twitter.com/prashanthsams.svg?label=Tweet&style=social"></a>

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

### Github Issues
------

List, Create, Close, Open and Reopen GitHub issues

| Command     | Description |
| ---      | ---       |
| `hubot issue <#number>` | Display an issue with specific number         |
| `hubot issue any` <br> `hubot issue any all` | Lists all the open & closed issues         |
| `hubot issue any <YYYY-MM-DD>` <br> `hubot issue any all <YYYY-MM-DD>` | Lists all the open & closed issues updated with specific date         |
| `hubot issue any <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot issue any all <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open & closed issues updated with specific date range         |
| `hubot issue any <#label>` <br> `hubot issue any all <#label>` | Lists all the open & closed issues with specific label         |
| `hubot issue any <#label> <YYYY-MM-DD>` <br> `hubot issue any all <#label> <YYYY-MM-DD>` | Lists all the open & closed issues updated with specific label and date         |
| `hubot issue any <#label> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot issue any all <#label> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open & closed issues updated with specific label and date range         |
| `hubot issue any <#text>` <br> `hubot issue any all <#text>` | Lists all the open & closed issues with specific text         |
| `hubot issue any <#text> <YYYY-MM-DD>` <br> `hubot issue any all <#text> <YYYY-MM-DD>` | Lists all the open & closed issues updated with specific text and date         |
| `hubot issue any <#text> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot issue any all <#text> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open & closed issues updated with specific text and date range         |
| `hubot issue any <assignee>`     | Lists all the open & closed issues assigned to a known github user        |
| `hubot issue any <assignee> <YYYY-MM-DD>` | Lists all the open & closed issues assigned to a known github user updated with specific date         |
| `hubot issue any <assignee> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open & closed issues assigned to a known github user updated with specific date range         |
| `hubot issue any <assignee> <#label>` | Lists all the open & closed issues with specific label assigned to a known github user         |
| `hubot issue any <assignee> <#label> <YYYY-MM-DD>` | Lists all the open & closed issues updated with specific label and date assigned to a known github user         |
| `hubot issue any <assignee> <#label> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open & closed issues updated with specific label and date assigned to a known github user         |
| `hubot issue any <assignee> <#text>` | Lists all the open & closed issues with specific text assigned to a known github user         |
| `hubot issue any <assignee> <#text> <YYYY-MM-DD>` | Lists all the open & closed issues updated with specific text and date assigned to a known github user         |
| `hubot issue any <assignee> <#text> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open & closed issues updated with specific text and date range assigned to a known github user         |
| `hubot issue closed` <br> `hubot issue closed all` | Lists all the closed issues         |
| `hubot issue closed <YYYY-MM-DD>` <br> `hubot issue closed all <YYYY-MM-DD>` | Lists all the closed issues with specific date         |
| `hubot issue closed <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot issue closed all <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the closed issues with specific date range         |
| `hubot issue closed <#label>` <br> `hubot issue closed all <#label>` | Lists all the closed issues with specific label         |
| `hubot issue closed <#label> <YYYY-MM-DD>` <br> `hubot issue closed all <#label> <YYYY-MM-DD>` | Lists all the closed issues with specific label and date         |
| `hubot issue closed <#label> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot issue closed all <#label> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the closed issues with specific label and date range         |
| `hubot issue closed <“text”>` <br> `hubot issue closed all <“text”>` | Lists all the closed issues with specific text         |
| `hubot issue closed <“text”> <YYYY-MM-DD>` <br> `hubot issue closed all <“text”> <YYYY-MM-DD>` | Lists all the closed issues with specific text and date         |
| `hubot issue closed <“text”> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot issue closed all <“text”> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the closed issues with specific text and date range         |
| `hubot issue closed <assignee>` | Lists all the closed issues assigned to a known github user         |
| `hubot issue closed <assignee> <YYYY-MM-DD>` | Lists all the closed issues assigned to a known github user with specific date         |
| `hubot issue closed <assignee> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the closed issues assigned to a known github user with specific date range         |
| `hubot issue closed <assignee> <#label>` | Lists all the closed issues with specific label assigned to a known github user         |
| `hubot issue closed <assignee> <#label> <YYYY-MM-DD>` | Lists all the closed issues with specific label assigned to a known github user with specific date         |
| `hubot issue closed <assignee> <#label> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the closed issues with specific label assigned to a known github user with specific date range         |
| `hubot issue closed <assignee> <“text”>` | Lists all the closed issues with specific text assigned to a known github user         |
| `hubot issue closed <assignee> <“text”> <YYYY-MM-DD>` | Lists all the closed issues with specific text assigned to a known github user with specific date         |
| `hubot issue closed <assignee> <“text”> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the closed issues with specific text assigned to a known github user with specific date range         |
| `hubot issue open` <br> `hubot issue open all` | Lists all the open issues         |
| `hubot issue open <YYYY-MM-DD>` <br> `hubot issue open all <YYYY-MM-DD>` | Lists all the open issues with specific date         |
| `hubot issue open <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot issue open all <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open issues with specific date range         |
| `hubot issue open <#label>` <br> `hubot issue open all <#label>` | Lists all the open issues with specific label         |
| `hubot issue open <#label> <YYYY-MM-DD>` <br> `hubot issue open all <#label> <YYYY-MM-DD>` | Lists all the open issues with specific label and date         |
| `hubot issue open <#label> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot issue open all <#label> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open issues with specific label and date range         |
| `hubot issue open <“text”>` <br> `hubot issue open all <“text”>` | Lists all the open issues with specific text         |
| `hubot issue open <“text”> <YYYY-MM-DD>` <br> `hubot issue open all <“text”> <YYYY-MM-DD>` | Lists all the open issues with specific text and date         |
| `hubot issue open <“text”> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot issue open all <“text”> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open issues with specific text and date range         |
| `hubot issue open <assignee>` | Lists all the open issues assigned to a known github user         |
| `hubot issue open <assignee> <YYYY-MM-DD>` | Lists all the open issues assigned to a known github user with specific date         |
| `hubot issue open <assignee> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open issues assigned to a known github user with specific date range         |
| `hubot issue open <assignee> <#label>` | Lists all the open issues with specific label assigned to a known user         |
| `hubot issue open <assignee> <#label> <YYYY-MM-DD>` | Lists all the open issues with specific label and date assigned to a known user         |
| `hubot issue open <assignee> <#label> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open issues with specific label and date range assigned to a known user         |
| `hubot issue open <assignee> <“text”>` | Lists all the open issues with specific text assigned to a known user         |
| `hubot issue open <assignee> <“text”> <YYYY-MM-DD>` | Lists all the open issues with specific text and date assigned to a known user         |
| `hubot issue open <assignee> <“text”> <YYYY-MM-DD..YYYY-MM-DD>` | Lists all the open issues with specific text and date range assigned to a known user         |
| `hubot issue close <#number>`     | Close an existing issue        |
| `hubot issue reopen <#number>`     | Re-open an existing issue        |
| `hubot issue create <“title”>`     | Create an issue with title        |
| `hubot issue create <“title”> <#label>`     | Create an issue with title and label        |
| `hubot issue create <“title”> body <{body}>`     | Create an issue with title and body        |
| `hubot issue create <“title”> body <{body}> <#label>`<img width=800/>     | Create an issue with title, body, and label <img width=400/>        |


### Github Pull Request
------

List GitHub pull request(s)

| Command     | Description |
| ---      | ---       |
| `hubot pr <#number>`     | Display a pull request with specific number        |
| `hubot pr any` <br> `hubot pr any all`     | Lists all the open & closed pull requests        |
| `hubot pr any <YYYY-MM-DD>` <br> `hubot pr any all <YYYY-MM-DD>`     | Lists all the open & closed pull requests updated with specific date        |
| `hubot pr any <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot pr any all <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open & closed pull requests updated with specific date range        |
| `hubot pr any <#label>` <br> `hubot pr any all <#label>`     | Lists all the open & closed pull requests with specific label        |
| `hubot pr any <#label> <YYYY-MM-DD>` <br> `hubot pr any all <#label> <YYYY-MM-DD>`     | Lists all the open & closed pull requests updated with specific label and date        |
| `hubot pr any <#label> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot pr any all <#label> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open & closed pull requests updated with specific label and date range        |
| `hubot pr any <#text>` <br> `hubot pr any all <#text>`     | Lists all the open & closed pull requests with specific text        |
| `hubot pr any <#text> <YYYY-MM-DD>` <br> `hubot pr any all <#text> <YYYY-MM-DD>`     | Lists all the open & closed pull requests updated with specific text and date        |
| `hubot pr any <#text> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot pr any all <#text> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open & closed pull requests updated with specific text and date range        |
| `hubot pr any <assignee>`     | Lists all the open & closed pull requests assigned to a known github user        |
| `hubot pr any <assignee> <YYYY-MM-DD>`     | Lists all the open & closed pull requests assigned to a known github user updated with specific date        |
| `hubot pr any <assignee> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open & closed pull requests assigned to a known github user updated with specific date range        |
| `hubot pr any <assignee> <#label>`     | Lists all the open & closed pull requests with specific label assigned to a known github user        |
| `hubot pr any <assignee> <#label> <YYYY-MM-DD>`     | Lists all the open & closed pull requests updated with specific label and date assigned to a known github user        |
| `hubot pr any <assignee> <#label> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open & closed pull requests updated with specific label and date assigned to a known github user        |
| `hubot pr any <assignee> <#text>`     | Lists all the open & closed pull requests with specific text assigned to a known github user        |
| `hubot pr any <assignee> <#text> <YYYY-MM-DD>`     | Lists all the open & closed pull requests updated with specific text and date assigned to a known github user        |
| `hubot pr any <assignee> <#text> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open & closed pull requests updated with specific text and date range assigned to a known github user        |
| `hubot pr closed` <br> `hubot pr closed all`     | Lists all the closed pull requests        |
| `hubot pr closed <YYYY-MM-DD>` <br> `hubot pr closed all <YYYY-MM-DD>`     | Lists all the closed pull requests with specific date        |
| `hubot pr closed <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot pr closed all <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the closed pull requests with specific date range        |
| `hubot pr closed <#label>` <br> `hubot pr closed all <#label>`     | Lists all the closed pull requests with specific label        |
| `hubot pr closed <#label> <YYYY-MM-DD>` <br> `hubot pr closed all <#label> <YYYY-MM-DD>`     | Lists all the closed pull requests with specific label and date        |
| `hubot pr closed <#label> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot pr closed all <#label> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the closed pull requests with specific label and date range        |
| `hubot pr closed <“text”>` <br> `hubot pr closed all <“text”>`     | Lists all the closed pull requests with specific text        |
| `hubot pr closed <“text”> <YYYY-MM-DD>` <br> `hubot pr closed all <“text”> <YYYY-MM-DD>`     | Lists all the closed pull requests with specific text and date        |
| `hubot pr closed <“text”> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot pr closed all <“text”> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the closed pull requests with specific text and date range        |
| `hubot pr closed <assignee>`     | Lists all the closed pull requests assigned to a known github user        |
| `hubot pr closed <assignee> <YYYY-MM-DD>`     | Lists all the closed pull requests assigned to a known github user with specific date        |
| `hubot pr closed <assignee> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the closed pull requests assigned to a known github user with specific date range        |
| `hubot pr closed <assignee> <#label>`     | Lists all the closed pull requests with specific label assigned to a known github user        |
| `hubot pr closed <assignee> <#label> <YYYY-MM-DD>`     | Lists all the closed pull requests with specific label assigned to a known github user with specific date        |
| `hubot pr closed <assignee> <#label> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the closed pull requests with specific label assigned to a known github user with specific date range        |
| `hubot pr closed <assignee> <“text”>`     | Lists all the closed pull requests with specific text assigned to a known github user        |
| `hubot pr closed <assignee> <“text”> <YYYY-MM-DD>`     | Lists all the closed pull requests with specific text assigned to a known github user with specific date        |
| `hubot pr closed <assignee> <“text”> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the closed pull requests with specific text assigned to a known github user with specific date range        |
| `hubot pr open` <br> `hubot pr open all`     | Lists all the open pull requests        |
| `hubot pr open <YYYY-MM-DD>` <br> `hubot pr open all <YYYY-MM-DD>`     | Lists all the open pull requests with specific date        |
| `hubot pr open <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot pr open all <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open pull requests with specific date range        |
| `hubot pr open <#label>` <br> `hubot pr open all <#label>`     | Lists all the open pull requests with specific label        |
| `hubot pr open <#label> <YYYY-MM-DD>` <br> `hubot pr open all <#label> <YYYY-MM-DD>`     | Lists all the open pull requests with specific label and date        |
| `hubot pr open <#label> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot pr open all <#label> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open pull requests with specific label and date range        |
| `hubot pr open <“text”>` <br> `hubot pr open all <“text”>`     | Lists all the open pull requests with specific text        |
| `hubot pr open <“text”> <YYYY-MM-DD>` <br> `hubot pr open all <“text”> <YYYY-MM-DD>`     | Lists all the open pull requests with specific text and date        |
| `hubot pr open <“text”> <YYYY-MM-DD..YYYY-MM-DD>` <br> `hubot pr open all <“text”> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open pull requests with specific text and date range        |
| `hubot pr open <assignee>`     | Lists all the open pull requests assigned to a known github user        |
| `hubot pr open <assignee> <YYYY-MM-DD>`     | Lists all the open pull requests assigned to a known github user with specific date        |
| `hubot pr open <assignee> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open pull requests assigned to a known github user with specific date range        |
| `hubot pr open <assignee> <#label>`     | Lists all the open pull requests with specific label assigned to a known user        |
| `hubot pr open <assignee> <#label> <YYYY-MM-DD>`     | Lists all the open pull requests with specific label and date assigned to a known user        |
| `hubot pr open <assignee> <#label> <YYYY-MM-DD..YYYY-MM-DD>`     | Lists all the open pull requests with specific label and date range assigned to a known user        |
| `hubot pr open <assignee> <“text”>`     | Lists all the open pull requests with specific text assigned to a known user        |
| `hubot pr open <assignee> <“text”> <YYYY-MM-DD>`     | Lists all the open pull requests with specific text and date assigned to a known user        |
| `hubot pr open <assignee> <“text”> <YYYY-MM-DD..YYYY-MM-DD>`<img width=800/>     | Lists all the open pull requests with specific text and date range assigned to a known user <img width=350/>       |

### Support
- <a href="https://twitter.com/intent/follow?screen_name=prashanthsams"><img src="https://img.shields.io/twitter/follow/prashanthsams.svg?style=social" alt="follow on Twitter"></a>


### Blogs

- [Hubot Slack setup]

[#slack]: https://slack.com/
[Hubot]: https://hubot.github.com/
[Hubot Slack setup]: https://devopsqa.wordpress.com/2019/03/19/hubot-slack-setup/
