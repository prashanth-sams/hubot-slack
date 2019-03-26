# Description:
#   Show an issue from a Github repository

# Commands:
#   hubot issue <#number> -- Lists any issue with specific number.
_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /issue (#.*)$/i, (msg) ->
    query_params = state: "all", sort: "created"
    query_params.per_page=100
    number = msg.match[1].split("#").join("")

    console.log "============"
    console.log query_params
    console.log "============"

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'

    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/issues", query_params, (issues) ->
      if !_.isEmpty issues
        for issue in issues
          if issue.number.toString() == number.toString()
            msg.send "> `issue ##{issue.number}` #{issue.title} \n \t #{issue.html_url}"
          else
      else
        msg.send "No issues found with number `##{number}`"
