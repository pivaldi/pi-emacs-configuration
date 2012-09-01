define([
  "dojo/_base/declare",
  "dojo/parser",
  "dojo/ready",
  "dijit/_Widget"
], function(declare, parser, ready, _Widget) {
  var out = declare("MyWidget", [_Widget], {
    // postCreate: function(){
    //   this.inherited(arguments);
    // },

    // buildRendering: function(){
    //   this.inherited(arguments);
    // }

  });

  // the parser is only needed, if you want
  // to instantiate the widget declaratively (in markup)
  ready(function(){
    // Call the parser manually so it runs after our widget is defined,
    // and page has finished loading
    parser.parse();
  });

  return out;
});