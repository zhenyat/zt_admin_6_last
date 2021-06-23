/***
 *  v. 3.13:  Bootstrap 5 - jQuery + @popperjs/core
 ***/
 import Rails from "@rails/ujs"
 import Turbolinks from "turbolinks"
 import * as ActiveStorage from "@rails/activestorage"
 import "channels"
 
 Rails.start()
 Turbolinks.start()
 ActiveStorage.start()
 
 import 'bootstrap'
 import "@fortawesome/fontawesome-free/js/all";
 // import "@fortawesome/fontawesome-free/css/all"
 import '../stylesheets/application'
 