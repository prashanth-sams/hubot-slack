# Description:
#   Update issues from a Github repository

# Commands:
#   hubot issue close <#number> -- Close an existing issue.
#   hubot issue reopen <#number> -- Re-open an existing issue.
#   hubot issue create <“title”> -- Create an issue with title.
#   hubot issue create <“title”> <#label> -- Create an issue with title and label.
#   hubot issue create <“title”> body <{body}> -- Create an issue with title and body.
#   hubot issue create <“title”> body <{body}> <#label> -- Create an issue with title, body, and label.

_  = require("underscore")

CREATE_CMD = ///
  issue\s
  create\s
  (“.*”)\s*
  (body\s{.*})?\s*
  (\#.*)?
///i

parse_criteria = (message) ->
  [title, body, label] = message.match(CREATE_CMD)[1..]
  title: title,
  body: body if body?,
  label: label if label?

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

  robot.respond CREATE_CMD, (msg) ->
    criteria = parse_criteria msg.message.text
    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'

    who = msg.message.user.name
    title = criteria.title.replace /[“”"'‘’]/g, ""
    body = criteria.body.replace /[{}]/g, "" if criteria.body?
    label = criteria.label if criteria.label?

    query_param =
      title: title
      body: "created by #{who}\n\n#{body}" if criteria.body?
      labels: ["#{label}"] if criteria.label?

    github.post "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/issues", query_param, (issue) ->
      text = "Sure! I created an issue for you\n#{issue.html_url}"
      msg.reply text
