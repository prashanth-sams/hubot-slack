# Description:
#   Show closed issues from a Github repository

# Commands:
#   hubot closed <assignee> <#label> -- Lists all the closed issues with specific label and assignee.
#   hubot closed <assignee> <text> -- Lists all the closed issues with specific text.
_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /closed (.*) (.*)$/i, (msg) ->
    query_params = state: "closed", sort: "created"
    query_params.per_page=100
    query_params.assignee = msg.match[1] if msg.match[1]?
    if msg.match[2].indexOf("#") != -1
      search = "label"
      query_params.labels = msg.match[2].split("#").join("")
    else
      search = "text"
      get_text = msg.match[2]

    console.log "============"
    console.log query_params
    console.log "============"

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'

    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/issues", query_params, (issues) ->

      switch search
        when 'label'
          if !_.isEmpty issues
            for issue in issues
              msg.send "> `issue ##{issue.number}` #{issue.title}"
          else
            msg.send "No closed issues with this filter!"

        when 'text'
          count = 0
          if !_.isEmpty issues
            for issue in issues
              count += 1
              if issue.title.indexOf("#{get_text}") != -1
                msg.send "> `issue ##{issue.number}` #{issue.title}"
              else
                msg.send "No closed issues with title containing text `#{get_text}`" if count == issues.length
          else
            msg.send "No closed issues found!"
