# Description:
#   Show closed issues from a Github repository

# Commands:
#   hubot closed <your_username> <label> -- Lists all the closed issues with specific label.
_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /closed (.*) (.*)$/i, (msg) ->
    query_params = state: "closed", sort: "created"
    query_params.per_page=100
    query_params.assignee = msg.match[1] if msg.match[1]?
    query_params.labels = msg.match[2]

    console.log "============"
    console.log query_params
    console.log "============"

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'

    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/issues", query_params, (issues) ->
      if !_.isEmpty issues
        for issue in issues
          msg.send "> `issue ##{issue.number}` #{issue.title}"
      else
        msg.send "No issues closed at this specific date"
