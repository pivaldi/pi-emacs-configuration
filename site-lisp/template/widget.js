define([
  "dojo/_base/declare",
  "geonef/jig/_Widget",
  "dojo/_base/lang",
  "geonef/button/Action"
], function(declare, _Widget, lang, Action) {

  return declare([_Widget],
{ //--noindent--

  "class": _Widget.prototype["class"] + " myWidget",

  makeContentNodes: function() {
    return [
      ["div", {}, "My content"]
    ];
  },

  startup: function() {
    this.inherited(arguments);
  }

});

});