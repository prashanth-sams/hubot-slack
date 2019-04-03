# Description:
#   Show a(all) issue(s) from a Github repository

# Commands:
#   hubot issue <#number> -- Lists an issue with specific number.
#   hubot issue any all -- Lists all the issues.
#   hubot issue any all <#label> -- Lists all the issues with specific label.
#   hubot issue any all <#text> -- Lists all the issues with specific text.
#   hubot issue any <assignee> -- Lists all the issues assigned to a known github user.
#   hubot issue any <assignee> <#label> -- Lists all the issues with specific label assigned to a known github user.
#   hubot issue any <assignee> <#text> -- Lists all the issues with specific text assigned to a known github user.

_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /issue (#.*)?$/i, (msg) ->
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

  robot.respond /issue any (.*)$/i, (msg) ->
    query_params = state: "all", sort: "created"
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
        msg.send "No issues found!"

  robot.respond /issue any (.*) (.*)?$/i, (msg) ->
    query_params = state: "all", sort: "created"
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
            msg.reply "No issues with this filter!"

        when 'text'
          count = 0
          if !_.isEmpty issues
            for issue in issues
              count += 1
              if issue.title.indexOf("#{get_text}") != -1
                msg.send "> `issue ##{issue.number}` #{issue.title}"
                actual_count = issues.length
              else
                msg.reply "No issues with title containing text `#{get_text}`" if !actual_count && count == issues.length
          else
            msg.reply "No issues found!"
