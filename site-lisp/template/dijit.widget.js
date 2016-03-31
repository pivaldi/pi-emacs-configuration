define([
  "module",
  "dojo/_base/declare",

  "geonef/jig/_Widget"
], function (
  module, declare,
  _Widget
) {
  return declare([_Widget], {

    // postMixInProperties: function(){
    //   this.inherited(arguments);
    // },

    // buildRendering: function(){
    //   this.inherited(arguments);
    // },

    makeContentNodes: function () {
      return [];
    },

    // postCreate: function() {
    // },

    declaredClass: module.id
  });
});
