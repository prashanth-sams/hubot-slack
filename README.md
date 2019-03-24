### Run slack bot

- Start `hubot` locally
```
    % .bin/hubot --adapter <your_adapter_name> HUBOT_SLACK_TOKEN=xxxx-xxxx-xxxx-xxxx \
    				HUBOT_GITHUB_TOKEN=xxxx \
    				HUBOT_GITHUB_USER=xxxx \
    				HUBOT_GITHUB_API=https://api.github.com \
    				HUBOT_GITHUB_REPO=xxxx
```

### Slack interaction

- Let's start interacting with the bots created; let's say, `hubot help`
- You can customize the bot name `hubot` with `your_custom_bot_name`. In this project, I named it as `sams` from `bin/hubot.cmd && bin/hubot` and made sure the bot name is the same while creating hubot slack token; so , my statement looks like, `sams help`

```
    hubot> hubot help
    hubot help - Displays all of the help commands that hubot knows about.
```

### Blogs

- [Hubot Slack setup]

[Hubot Slack setup]: https://devopsqa.wordpress.com/2019/03/19/hubot-slack-setup/
