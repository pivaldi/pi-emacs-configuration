/**
 * Description courte du module (obligatoire)
 *
 * Description plus longue du module (conseillé)
 */
define([
  "module",
  "dojo/_base/declare",
  "dojo/_base/lang",

  "geonef/jig/_Widget",
  "geonef/jig/button/Action"
], function(module, declare, lang, _Widget, Action) {

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