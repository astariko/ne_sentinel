// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


// Event handling
document.addEventListener("DOMContentLoaded",
    function (event) {

        function checkAll (event) {
            var state = document
                .getElementById("ne-check-all")
                .checked;
            var checks = document
                .getElementsByClassName("ne-check")

            for (var i = 0; i < checks.length; i++) {
                checks[i].checked = state;
            }
        }//checkAll

        function load (event) {
            var checks = document
                .getElementsByClassName("ne-check")

            for (var i = 0; i < checks.length; i++) {
                if (checks[i].checked)
                    console.log("checked");
            }
        }//checkAll

        // Unobtrusive event binding
        document.getElementById("ne-check-all")
            .addEventListener("click", checkAll);
        document.getElementById("button-load")
            .addEventListener("click", load);
    }
);
