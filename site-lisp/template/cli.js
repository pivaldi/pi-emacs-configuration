var settings;

module.exports = function() {
  var Cli = require('./Cli')();
  Cli.prototype.ini = function() {settings = this.app.settings;};
  Cli.prototype.main = function() {main(this);};
  return Cli;
};


function main(cli) {
  !§!_!§!
}
