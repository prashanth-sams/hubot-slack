const CronJob = require("cron").CronJob

module.exports = robot => {
  new CronJob(
    "00 37 16 * * *",
    function() {
      try {
        robot.messageRoom(
          "general", `Hey Prashanth! You got a notification message now`
        )
      } catch (e) {
        console.error(e)
      }
    },
    null,
    true,
    "Asia/Dubai"
  )
}
