# Description:
#   Show closed issues from a Github repository

# Commands:
#   hubot issue closed all -- Lists all the closed issues.
#   hubot issue closed all <#label> -- Lists all the closed issues with specific label.
#   hubot issue closed all <“text”> -- Lists all the closed issues with specific text.
#   hubot issue closed <assignee> -- Lists all the closed issues assigned to a known github user.
#   hubot issue closed <assignee> <#label> -- Lists all the closed issues with specific label assigned to a known github user.
#   hubot issue closed <assignee> <“text”> -- Lists all the closed issues with specific text assigned to a known github user.

_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /issue closed (.*)$/i, (msg) ->
    query_params = state: "closed", sort: "created"
    query_params.per_page=100
    query_params.assignee = msg.match[1] if msg.match[1] != 'all'

    console.log "============"
    console.log query_params
    console.log "============"

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'

    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/issues", query_params, (issues) ->
      if !_.isEmpty issues
        for issue in issues
          msg.send "> `issue ##{issue.number}` #{issue.title}"
      else
        msg.send "No closed issues"

  robot.respond /issue closed (.*) (.*)?$/i, (msg) ->
    query_params = state: "closed", sort: "created"
    query_params.per_page=100
    query_params.assignee = msg.match[1] if msg.match[1] != 'all'

    if msg.match[2].indexOf("#") != -1
      search = "label"
      query_params.labels = msg.match[2].split("#").join("")
    else if msg.match[2].match('“|”|"|\'|‘|’')
      search = "text"
      get_text = msg.match[2].replace /[“”"'‘’]/g, ""
    else
      console.log msg.match[2]

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
            msg.reply "No closed issues with this filter!"

        when 'text'
          count = 0
          if !_.isEmpty issues
            for issue in issues
              count += 1
              if issue.title.indexOf("#{get_text}") != -1
                msg.send "> `issue ##{issue.number}` #{issue.title}"
                actual_count = issues.length
              else
                msg.reply "No closed issues with title containing text `#{get_text}`" if !actual_count && count == issues.length
          else
            msg.reply "No closed issues found!"
