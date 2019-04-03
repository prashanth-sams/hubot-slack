# Description:
#   Show a(all) pr(s) from a Github repository

# Commands:
#   hubot pr <#number> -- Lists an pr with specific number.

#   hubot pr any all -- Lists all the prs.
#   hubot pr any all <#label> -- Lists all the prs with specific label.
#   hubot pr any all <#text> -- Lists all the prs with specific text.
#   hubot pr any <assignee> -- Lists all the prs assigned to a known github user.
#   hubot pr any <assignee> <#label> -- Lists all the prs with specific label assigned to a known github user.
#   hubot pr any <assignee> <#text> -- Lists all the prs with specific text assigned to a known github user.

_  = require("underscore")

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /pr (#.*)?$/i, (msg) ->

    number = msg.match[1].split("#").join("").toString()
    console.log number

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'

    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/pulls/#{number}", (prs) ->
      msg.send "> `pr ##{prs.number}` #{prs.title} \n \t #{prs.html_url}"
      if !_.isEmpty prs
        for pr in prs
          if pr.number.toString() == number.toString()
            msg.send "> `pr ##{pr.number}` #{pr.title} \n \t #{pr.html_url}"
          else
      else
        msg.send "No pull requests found with number `##{number}`"

  # robot.respond /pr any (.*)$/i, (msg) ->
  #   query_params = state: "all", sort: "created"
  #   query_params.per_page=100
  #   query_params.assignee = msg.match[1] if msg.match[1] != 'all'
  #
  #   console.log "============"
  #   console.log query_params
  #   console.log "============"
  #
  #   base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
  #
  #   github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/prs", query_params, (prs) ->
  #     if !_.isEmpty prs
  #       for pr in prs
  #         msg.send "> `pr ##{pr.number}` #{pr.title}"
  #     else
  #       msg.send "No prs found!"

  # robot.respond /pr any (.*) (.*)?$/i, (msg) ->
  #   query_params = state: "all", sort: "created"
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
  #   github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/prs", query_params, (prs) ->
  #
  #     switch search
  #       when 'label'
  #         if !_.isEmpty prs
  #           for pr in prs
  #             msg.send "> `pr ##{pr.number}` #{pr.title}"
  #         else
  #           msg.send "No prs with this filter!"
  #
  #       when 'text'
  #         count = 0
  #         if !_.isEmpty prs
  #           for pr in prs
  #             count += 1
  #             if pr.title.indexOf("#{get_text}") != -1
  #               msg.send "> `pr ##{pr.number}` #{pr.title}"
  #             else
  #               msg.send "No prs with title containing text `#{get_text}`" if count == prs.length
  #         else
  #           msg.send "No prs found!"
