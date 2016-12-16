# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener("DOMContentLoaded", 
	pageLoaded = (event) ->
		# this gets executed after DOM

		checkAll = () ->
			state = document.getElementById("ne-check-all").checked
			checks = document.getElementsByClassName("ne-check")

			for check in checks
				check.checked = state

		document.getElementById("ne-check-all").addEventListener("click", checkAll)

		editNe = () ->
			checks = document.getElementsByClassName("ne-check")

			count = 0
			id = ""
			for check in checks
				if check.checked
					count += 1
					id = check.value
					checked_item = check
			if count != 1
				window.alert("Please, select exactly one NE before clicking edit")
			else
				try
					checked_item.checked = false
					form = document.getElementById("edit-" + id.toString())
					form[0].click()
				catch error
					window.alert("Form for ID edit-#{id} not found, " + error)


		document.getElementById("edit-button").addEventListener("click", editNe)

		deleteNe = () ->
			checks = document.getElementsByClassName("ne-check")
			count = 0
			id = ""
			for check in checks
				if check.checked
					count += 1
					id = check.value
					checked_item = check
			if count != 1
				window.alert("Please, select exactly one NE before clicking delete")
			else
				try
					checked_item.checked = false
					form = document.getElementById("delete-" + id.toString())
					form[0].form[0].click()
				catch error
					window.alert("Form for ID delete-#{id} not found, " + error)

		document.getElementById("delete-button").addEventListener("click", deleteNe)

		upgradeNe = () ->
			checks = document.getElementsByClassName("ne-check")
			count = 0
			id = ""
			for check in checks
				if check.checked
					count += 1
					id = check.value
					checked_item = check
			if count != 1
				window.alert("Please, select exactly one NE before clicking upgrade")
			else
				try
					checked_item.checked = false
					form = document.getElementById("upgrade-" + id.toString())
					form[0].click()
				catch error
					window.alert("Form for ID upgrade-#{id} not found, " + error)

		document.getElementById("upgrade-button").addEventListener("click", upgradeNe)

		# ----------------------------------------------------------------------------------------
		#online?
		getServerStatus = (path) ->
			$.ajax path,
			    type: 'GET'
			    dataType: 'html'
			    error: (jqXHR, textStatus, errorThrown) ->
			        return 'error'
			    success: (data, textStatus, jqXHR) ->
			    	return 'success'
			    	window.setInterval(getServerStatus('/check_on_server', 25000))
			#ne_statuses = document.getElementsB
			#	getStatus(status.dataset.path2)yClassName("ne-status")
			#for status in ne_statuses

		checkOnStack = (path) ->
			$.ajax path,
			    type: 'GET'
			    dataType: 'json'
			    error: (jqXHR, textStatus, errorThrown) ->
			        return 'error'
			    success: (data, textStatus, jqXHR) ->
			    	return 'success'

		#Page loads and then /check_on_stack executed
		#setTimeout(checkOnStack('/check_on_stack'), 500)
		setTimeout ( ->
		  checkOnStack '/check_on_stack'
		), 500

		#once check_on_stack is completed, we ought to refresh the main page ( I think fully. but make sure taht another DB call is not called for.)
		#setInterval(getServerStatus('/check_on_server', 30000))
		setInterval ( ->
		  getServerStatus '/check_on_server'
		), 15000

		# I can work on some kind of NE status refresh if I want to.
		#window.setInterval(issuePingToNes(), 30000);
		#window.setInterval(getNeStatus(), 10000);
	)

