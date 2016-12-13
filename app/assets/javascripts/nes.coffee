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
		issuePingToNes = () ->
			ne_statuses = document.getElementsByClassName("ne-status")
			for status in ne_statuses
				issuePing(status.dataset.path)

		issuePing = (path) ->
			$.ajax path,
			    type: 'GET'
			    dataType: 'json'
			    error: (jqXHR, textStatus, errorThrown) ->
			    	#console.log('error')
			        return 'error'
			    success: (data, textStatus, jqXHR) ->
			    	#console.log('win')
			    	return 'success'

		getStatus = (path) ->
			$.ajax path,
			    type: 'GET'
			    dataType: 'json'
			    error: (jqXHR, textStatus, errorThrown) ->
			    	#console.log('error')
			        return 'error'
			    success: (data, textStatus, jqXHR) ->
			    	#console.log('win')
			        updateNeStatus(data)
		getNeStatus = () ->
			ne_statuses = document.getElementsByClassName("ne-status")
			for status in ne_statuses
				getStatus(status.dataset.path2)

		updateNeStatus = (data) ->
			ne_status = document.getElementById("ne-status-"+data["id"])
			ne_status.innerHTML = data["status"]

		issuePingToNes()
		window.setTimeout(getNeStatus(), 5000)

		# I can work on some kind of NE status refresh if I want to.
		#window.setInterval(issuePingToNes(), 30000);
		#window.setInterval(getNeStatus(), 10000);

	)

