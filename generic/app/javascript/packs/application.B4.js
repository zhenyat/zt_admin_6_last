/***
 *  v. 3.12:  Bootstrap 4 + jQuery + popper.js
 ***/
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap'
import "@fortawesome/fontawesome-free/js/all";
import '../stylesheets/application'

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()
})
