# Description:
#   Show closed prs from a Github repository

# Commands:
#   hubot pr closed all -- Lists all the closed pull requests.
#   hubot pr closed all <#label> -- Lists all the closed pull requests with specific label.
#   hubot pr closed all <“text”> -- Lists all the closed pull requests with specific text.
#   hubot pr closed <assignee> -- Lists all the closed pull requests assigned to a known github user.
#   hubot pr closed <assignee> <#label> -- Lists all the closed pull requests with specific label assigned to a known github user.
#   hubot pr closed <assignee> <“text”> -- Lists all the closed pull requests with specific text assigned to a known github user.

_  = require("underscore")

LIST_CMD = ///
  pr\s
  closed\s*
  (\w+-\w*|\w+_\w*|\w*)?\s*
  (\#.*|“.*”)?
///i

parse_criteria = (message) ->
  [assignee, param] = message.match(LIST_CMD)[1..]
  assignee: assignee if assignee?,
  param: param if param?


module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond LIST_CMD, (msg) ->
    criteria = parse_criteria msg.message.text

    if criteria.assignee?
      assignee = criteria.assignee.replace /[“”"'‘’]/g, ""
    else
      assignee = "all"

    if criteria.param?
      param = criteria.param

      if param.indexOf("#") != -1
        search = "label"
        labels = param.split("#").join("")
      else if param.match('“|”|"|\'|‘|’')
        search = "text"
        get_text = param.replace /[“”"'‘’]/g, ""
      else
        console.log param
    else
      search = "no param"

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    repo = "#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}"

    if assignee != 'all' && (search == 'text' || search == 'no param')
      url = "#{base_url}/search/issues?q=is:pr%20state:closed%20assignee:#{assignee}%20repo:#{repo}"
    else if assignee != 'all' && search == 'label'
      url = "#{base_url}/search/issues?q=is:pr%20state:closed%20assignee:#{assignee}%20label:#{labels}%20repo:#{repo}"
    else if assignee == 'all' && (search == 'text' || search == 'no param')
      url = "#{base_url}/search/issues?q=is:pr%20state:closed%20repo:#{repo}"
    else if assignee == 'all' && search == 'label'
      url = "#{base_url}/search/issues?q=is:pr%20state:closed%20label:#{labels}%20repo:#{repo}"
    else
      console.log "No matchers with this filter"

    github.get url, (prs) ->
      if prs.total_count != 0
        switch search
          when 'label', 'no param'
            for pr in prs.items
              msg.send "> `pr ##{pr.number}` `#{pr.state}` #{pr.title} \n \t #{pr.html_url}"

          when 'text'
            count = 0
            for pr in prs.items
              count += 1
              if pr.title.indexOf("#{get_text}") != -1
                msg.send "> `pr ##{pr.number}` `#{pr.state}` #{pr.title} \n \t #{pr.html_url}"
                actual_count = prs.items.length
              else
                msg.reply "No closed pull requests with title containing text `#{get_text}`" if !actual_count && count == prs.items.length
      else
        msg.reply "No closed pull requests found with the given filter!"
