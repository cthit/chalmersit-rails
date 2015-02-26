var system = require('system');

if (system.args.length < 2) {
  console.log("Usage: karkort.js kortnummer");
  phantom.exit(1);
}

var card = {};
var cardNo = system.args[4];

var url = "http://kortladdning2.chalmerskonferens.se/";
var casper = require('casper').create();

casper.start(url, function() {
  this.fillSelectors('#frmLogin', {'#txtCardNumber': cardNo}, false);
  this.click('#btnNext');
});

casper.then(function() {
  card = this.evaluate(function() {
    var value = parseFloat(document.querySelectorAll('#txtPTMCardValue')[0].textContent.replace(/,/g, '.').trim());
    var curr = document.querySelectorAll('#lblPTMCardValueUnit')[0].textContent.trim();
    return {balance: value, currency: curr};
  });
});

casper.run(function() {
  var result = {};
  result[cardNo] = card;
  this.echo(JSON.stringify(result)).exit();
});
