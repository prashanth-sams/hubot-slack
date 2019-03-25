# Description:
#   Show open issues from a Github repository

# Commands:
#   hubot label <label> -- Lists all the closed issues with specific label.
_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /label (.*)$/i, (msg) ->
    query_params = state: "open", sort: "created"
    query_params.per_page=100
    query_params.labels = msg.match[1]

    console.log "============"
    console.log query_params
    console.log "============"

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'

    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/issues", query_params, (issues) ->
      if !_.isEmpty issues
        for issue in issues
          labels = ("`##{label.name}`" for label in issue.labels).join(" ")
          msg.send "> [`#{issue.number}`] *#{issue.title} #{labels}* #{issue.html_url}"
      else
        msg.send "No open issues with this filter!"
