# Description:
#   Show open pull requests from a Github repository
#
# Commands:
#   hubot pr open all -- Lists all the open prs.

#   hubot pr open all <#label> -- Lists all the open prs with specific label.
#   hubot pr open all <“text”> -- Lists all the open prs with specific text.
#   hubot pr open <assignee> -- Lists all the open prs assigned to a known github user.
#   hubot pr open <assignee> <#label> -- Lists all the open prs with specific label assigned to a known user.
#   hubot pr open <assignee> <“text”> -- Lists all the open prs with specific text assigned to a known user.

_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /pr open (.*)$/i, (msg) ->
    # query_params = state: "open", sort: "created"
    # query_params.per_page=100
    # query_params.assignee = msg.match[1] if msg.match[1] != 'all'

    # console.log "============"
    # console.log query_params
    # console.log "============"

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'

    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/pulls?state=open", (prs) ->
      if !_.isEmpty prs
        for pr in prs
          msg.send "> `pr ##{pr.number}` #{pr.title} #{pr.html_url}"
      else
        msg.send "No open pull requests found"

  # robot.respond /pr open (.*) (.*)?$/i, (msg) ->
  #   query_params = state: "open", sort: "created"
  #   query_params.per_page=100
  #   query_params.assignee = msg.match[1] if msg.match[1] != 'all'
  #
  #   if msg.match[2].indexOf("#") != -1
  #     search = "label"
  #     query_params.labels = msg.match[2].split("#").join("")
  #   else if msg.match[2].match('“|”|"|\'|‘|’')
  #     search = "text"
  #     get_text = msg.match[2].replace /[“”"'‘’]/g, ""
  #   else
  #     console.log msg.match[2]
  #
  #   console.log "============"
  #   console.log query_params
  #   console.log "============"
  #
  #   base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
  #
  #   github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/pulls", query_params, (prs) ->
  #
  #     switch search
  #       when 'label'
  #         if !_.isEmpty prs
  #           for pr in prs
  #             msg.send "> `pr ##{pr.user.login}` #{pr.title} #{pr.html_url}"
  #             # msg.send "> `pr ##{pr.number}` #{pr.title}"
  #         else
  #           msg.send "No open prs with this filter!"
  #
  #       when 'text'
  #         count = 0
  #         if !_.isEmpty prs
  #           for pr in prs
  #             count += 1
  #             if pr.title.indexOf("#{get_text}") != -1
  #               msg.send "> `pr ##{pr.user.login}` #{pr.title} #{pr.html_url}"
  #               # msg.send "> `pr ##{pr.number}` #{pr.title}"
  #             else
  #               msg.send "No open prs with title containing text `#{get_text}`" if count == prs.length
  #         else
  #           msg.send "No open prs found!"
