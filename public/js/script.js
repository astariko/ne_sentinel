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
