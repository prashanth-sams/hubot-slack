# Description:
#   Show closed prs from a Github repository

# Commands:
#   hubot pr closed all -- Lists all the closed prs.

#   hubot pr closed all <#label> -- Lists all the closed prs with specific label.
#   hubot pr closed all <“text”> -- Lists all the closed prs with specific text.
#   hubot pr closed <assignee> -- Lists all the closed prs assigned to a known github user.
#   hubot pr closed <assignee> <#label> -- Lists all the closed prs with specific label assigned to a known github user.
#   hubot pr closed <assignee> <“text”> -- Lists all the closed prs with specific text assigned to a known github user.

_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /pr closed (.*)$/i, (msg) ->
    # query_params = state: "closed", sort: "created"
    # query_params.per_page=100
    # query_params.assignee = msg.match[1] if msg.match[1] != 'all'

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'

    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/pulls?state=closed", (prs) ->
      if !_.isEmpty prs
        for pr in prs
          msg.send "> `pr ##{pr.number}` #{pr.title}"
      else
        msg.send "No closed pull requests"

  # robot.respond /pr closed (.*) (.*)?$/i, (msg) ->
  #   # query_params = state: "closed", sort: "created"
  #   # query_params.per_page=100
  #   # query_params.assignee = msg.match[1] if msg.match[1] != 'all'
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
  #   base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
  #
  #   github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/pulls", (prs) ->
  #
  #     switch search
  #       when 'label'
  #         if !_.isEmpty prs
  #           for pr in prs
  #             msg.send "> `pr ##{pr.number}` #{pr.title}"
  #         else
  #           msg.send "No closed pull requests with this filter!"
  #
  #       when 'text'
  #         count = 0
  #         if !_.isEmpty prs
  #           for pr in prs
  #             count += 1
  #             if pr.title.indexOf("#{get_text}") != -1
  #               msg.send "> `pr ##{pr.number}` #{pr.title}"
  #             else
  #               msg.send "No closed pull requests with title containing text `#{get_text}`" if count == prs.length
  #         else
  #           msg.send "No closed pull requests found!"
