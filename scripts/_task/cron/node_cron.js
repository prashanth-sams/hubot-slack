const cron = require("node-cron");

module.exports = robot => {
  new cron.schedule("*/1 * * * *", function() {
    robot.messageRoom(
      "website", `I am running once in every 1 minut`
    )
  });
}
