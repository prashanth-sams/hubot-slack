# Description:
#   Update issues from a Github repository

# Commands:
#   hubot issue close <#number> -- Close an existing issue.
#   hubot issue reopen <#number> -- Re-open an existing issue.

_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /issue close (#.*)/i, (msg) ->
    number = msg.match[1].split("#").join("")

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    github.patch "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/issues/#{number}", {state: "closed"}, (issue, error) ->
      if error then console.log error
      text = "Okay; I closed `issue ##{issue.number}` `#{issue.title}` for you"
      msg.reply text

  robot.respond /issue reopen (#.*)/i, (msg) ->
    number = msg.match[1].split("#").join("")

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    github.patch "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/issues/#{number}", {state: "open"}, (issue, error) ->
      if error then console.log error
      text = "Okay; I re-opened `issue ##{issue.number}` `#{issue.title}` for you"
      msg.reply text
