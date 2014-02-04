/**
 * Description courte du module (obligatoire)
 *
 * Description plus longue du module (conseillé)
 */
define([
  "module",
  "dojo/_base/declare",
  "geonef/jig/_Widget",
  "dojo/_base/lang",
  "geonef/button/Action"
], function(module, declare, _Widget, lang, Action) {

return declare([_Widget], { //--noindent--

  "class": _Widget.prototype["class"] + " myWidget",

  makeContentNodes: function() {
    return [
      ["div", {}, "My content"]
    ];
  },

  startup: function() {
    this.inherited(arguments);
  },

  declaredClass: module.id

});

});