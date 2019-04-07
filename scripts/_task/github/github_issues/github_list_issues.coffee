# Description:
#   Show a(all) issue(s) from a Github repository

# Commands:
#   hubot issue <#number> -- Display an issue with specific number.
#   hubot issue any -- Lists all the open & closed issues.
#   hubot issue any <YYYY-MM-DD> -- Lists all the open & closed issues updated with specific date.
#   hubot issue any <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open & closed issues updated with specific date range.
#   hubot issue any <#label> -- Lists all the open & closed issues with specific label.
#   hubot issue any <#label> <YYYY-MM-DD> -- Lists all the open & closed issues updated with specific label and date.
#   hubot issue any <#label> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open & closed issues updated with specific label and date range.
#   hubot issue any <#text> -- Lists all the open & closed issues with specific text.
#   hubot issue any <#text> <YYYY-MM-DD> -- Lists all the open & closed issues updated with specific text and date.
#   hubot issue any <#text> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open & closed issues updated with specific text and date range.
#   hubot issue any all -- Lists all the open & closed issues.
#   hubot issue any all <YYYY-MM-DD> -- Lists all the open & closed issues updated with specific date.
#   hubot issue any all <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open & closed issues updated with specific date range.
#   hubot issue any all <#label> -- Lists all the open & closed issues with specific label.
#   hubot issue any all <#label> <YYYY-MM-DD> -- Lists all the open & closed issues updated with specific label and date.
#   hubot issue any all <#label> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open & closed issues updated with specific label and date range.
#   hubot issue any all <#text> -- Lists all the open & closed issues with specific text.
#   hubot issue any all <#text> <YYYY-MM-DD> -- Lists all the open & closed issues updated with specific text and date.
#   hubot issue any all <#text> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open & closed issues updated with specific text and date range.
#   hubot issue any <assignee> -- Lists all the open & closed issues assigned to a known github user.
#   hubot issue any <assignee> <YYYY-MM-DD> -- Lists all the open & closed issues assigned to a known github user updated with specific date.
#   hubot issue any <assignee> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open & closed issues assigned to a known github user updated with specific date range.
#   hubot issue any <assignee> <#label> -- Lists all the open & closed issues with specific label assigned to a known github user.
#   hubot issue any <assignee> <#label> <YYYY-MM-DD> -- Lists all the open & closed issues updated with specific label and date assigned to a known github user.
#   hubot issue any <assignee> <#label> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open & closed issues updated with specific label and date assigned to a known github user.
#   hubot issue any <assignee> <#text> -- Lists all the open & closed issues with specific text assigned to a known github user.
#   hubot issue any <assignee> <#text> <YYYY-MM-DD> -- Lists all the open & closed issues updated with specific text and date assigned to a known github user.
#   hubot issue any <assignee> <#text> <YYYY-MM-DD..YYYY-MM-DD> -- Lists all the open & closed issues updated with specific text and date range assigned to a known github user.

_  = require("underscore")

LIST_CMD = ///
  issue\s
  any\s*
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

  robot.respond /issue (#.*)?$/i, (msg) ->
    number = msg.match[1].split("#").join("").toString()

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'

    github.get "#{base_url}/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPO}/issues/#{number}", (issue) ->
      if !_.isEmpty issue
        if issue.number.toString() == number.toString()
          msg.send "> `issue ##{issue.number}` `#{issue.state}` #{issue.title} \n \t #{issue.html_url}"
        else
      else
        msg.send "No issue found with number `##{number}`"

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
      url = "#{base_url}/search/issues?q=is:issue%20assignee:#{assignee}%20updated:#{date}%20repo:#{repo}" if date
      url = "#{base_url}/search/issues?q=is:issue%20assignee:#{assignee}%20repo:#{repo}" if !date
    else if assignee != 'all' && search == 'label'
      url = "#{base_url}/search/issues?q=is:issue%20assignee:#{assignee}%20label:#{labels}%20updated:#{date}%20repo:#{repo}" if date
      url = "#{base_url}/search/issues?q=is:issue%20assignee:#{assignee}%20label:#{labels}%20repo:#{repo}" if !date
    else if assignee == 'all' && (search == 'text' || search == 'no param')
      url = "#{base_url}/search/issues?q=is:issue%20updated:#{date}%20repo:#{repo}" if date
      url = "#{base_url}/search/issues?q=is:issue%20repo:#{repo}" if !date
    else if assignee == 'all' && search == 'label'
      url = "#{base_url}/search/issues?q=is:issue%20label:#{labels}%20updated:#{date}%20repo:#{repo}" if date
      url = "#{base_url}/search/issues?q=is:issue%20label:#{labels}%20repo:#{repo}" if !date
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
                msg.reply "No issues with title containing text `#{get_text}`" if !actual_count && count == issues.items.length
      else
        msg.reply "No issues found with the given filter!"
