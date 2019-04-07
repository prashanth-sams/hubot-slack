# Description:
#   Show open issues from a Github repository

# Commands:
#   hubot issue open -- Lists all the open issues.
#   hubot issue open <YYYY-MM-DD> -- Lists all the open issues with specific date.
#   hubot issue open <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open issues with specific date range.
#   hubot issue open <#label> -- Lists all the open issues with specific label.
#   hubot issue open <#label> <YYYY-MM-DD> -- Lists all the open issues with specific label and date.
#   hubot issue open <#label> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open issues with specific label and date range.
#   hubot issue open <“text”> -- Lists all the open issues with specific text.
#   hubot issue open <“text”> <YYYY-MM-DD> -- Lists all the open issues with specific text and date.
#   hubot issue open <“text”> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open issues with specific text and date range.
#   hubot issue open all -- Lists all the open issues.
#   hubot issue open all <YYYY-MM-DD> -- Lists all the open issues with specific date.
#   hubot issue open all <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open issues with specific date range.
#   hubot issue open all <#label> -- Lists all the open issues with specific label.
#   hubot issue open all <#label> <YYYY-MM-DD> -- Lists all the open issues with specific label and date.
#   hubot issue open all <#label> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open issues with specific label and date range.
#   hubot issue open all <“text”> -- Lists all the open issues with specific text.
#   hubot issue open all <“text”> <YYYY-MM-DD> -- Lists all the open issues with specific text and date.
#   hubot issue open all <“text”> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open issues with specific text and date range.
#   hubot issue open <assignee> -- Lists all the open issues assigned to a known github user.
#   hubot issue open <assignee> <YYYY-MM-DD> -- Lists all the open issues assigned to a known github user with specific date.
#   hubot issue open <assignee> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open issues assigned to a known github user with specific date range.
#   hubot issue open <assignee> <#label> -- Lists all the open issues with specific label assigned to a known user.
#   hubot issue open <assignee> <#label> <YYYY-MM-DD> -- Lists all the open issues with specific label and date assigned to a known user.
#   hubot issue open <assignee> <#label> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open issues with specific label and date range assigned to a known user.
#   hubot issue open <assignee> <“text”> -- Lists all the open issues with specific text assigned to a known user.
#   hubot issue open <assignee> <“text”> <YYYY-MM-DD> -- Lists all the open issues with specific text and date assigned to a known user.
#   hubot issue open <assignee> <“text”> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open issues with specific text and date range assigned to a known user.

_  = require("underscore")

LIST_CMD = ///
  issue\s
  open\s*
  ((?!\d\d\d\d)[\w-]+)?\s*
  ([#]+[^\s]+|“.*”|‘.*’|".*")?\s*
  (\d\d\d\d-\d\d-\d\d..\d\d\d\d-\d\d-\d\d|\d\d\d\d-\d\d-\d\d)?
///i

parse_criteria = (message) ->
  [assignee, param, date] = message.match(LIST_CMD)[1..]
  assignee: assignee if assignee?,
  param: param if param?,
  date: date if date?

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

    date = criteria.date if criteria.date

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    repo = "#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}"

    if assignee != 'all' && (search == 'text' || search == 'no param')
      url = "#{base_url}/search/issues?q=is:issue%20state:open%20assignee:#{assignee}%20created:#{date}%20repo:#{repo}" if date
      url = "#{base_url}/search/issues?q=is:issue%20state:open%20assignee:#{assignee}%20repo:#{repo}" if !date
    else if assignee != 'all' && search == 'label'
      url = "#{base_url}/search/issues?q=is:issue%20state:open%20assignee:#{assignee}%20label:#{labels}%20created:#{date}%20repo:#{repo}" if date
      url = "#{base_url}/search/issues?q=is:issue%20state:open%20assignee:#{assignee}%20label:#{labels}%20repo:#{repo}" if !date
    else if assignee == 'all' && (search == 'text' || search == 'no param')
      url = "#{base_url}/search/issues?q=is:issue%20state:open%20created:#{date}%20repo:#{repo}" if date
      url = "#{base_url}/search/issues?q=is:issue%20state:open%20repo:#{repo}" if !date
    else if assignee == 'all' && search == 'label'
      url = "#{base_url}/search/issues?q=is:issue%20state:open%20label:#{labels}%20created:#{date}%20repo:#{repo}" if date
      url = "#{base_url}/search/issues?q=is:issue%20state:open%20label:#{labels}%20repo:#{repo}" if !date
    else
      console.log "No matchers with this filter"

    github.get url, (issues) ->
      if issues.total_count != 0
        switch search
          when 'label', 'no param'
            for issue in issues.items
              msg.send "> `issue ##{issue.number}` `#{issue.state}` #{issue.title} \n \t #{issue.html_url}"

          when 'text'
            count = 0
            for issue in issues.items
              count += 1
              if issue.title.indexOf("#{get_text}") != -1
                msg.send "> `issue ##{issue.number}` `#{issue.state}` #{issue.title} \n \t #{issue.html_url}"
                actual_count = issues.items.length
              else
                msg.reply "No open issues with title containing text `#{get_text}`" if !actual_count && count == issues.items.length
      else
        msg.reply "No open issues found with the given filter!"
