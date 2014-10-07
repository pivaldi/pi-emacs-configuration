define([
  "module",
  "dojo/_base/declare",

  "geonef/jig/_Widget"
], function(
  module, declare,
  _Widget
) {
  return declare([_Widget], {

    // postMixinProperties: function(){
    //   this.inherited(arguments);
    // },

    makeContentNodes: function() {
      return [];
    },

    // buildRendering: function(){
    //   this.inherited(arguments);
    // },

    // postCreate: function() {
    // },

    declaredClass: module.id
  });
});
