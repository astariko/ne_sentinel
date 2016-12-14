# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener("DOMContentLoaded", 
	pageLoaded = (event) ->
		# this gets executed after DOM

		checkAllBranches = () ->
			state = document.getElementById("branch-check-all").checked
			checks = document.getElementsByClassName("branch-check")

			for check in checks
				check.checked = state

		document.getElementById("branch-check-all").addEventListener("click", checkAllBranches)


		editBranch = () ->
			checks = document.getElementsByClassName("branch-check")

			count = 0
			id = ""
			for check in checks
				if check.checked
					count += 1
					id = check.value
					checked_item = check
			if count != 1
				window.alert("Please, select exactly one Branch before clicking edit")
			else
				try
					checked_item.checked = false
					form = document.getElementById("edit-" + id.toString())
					form[0].click()
				catch error
					window.alert("Form for ID edit-#{id} not found, " + error)


		document.getElementById("edit-branch").addEventListener("click", editBranch)


		deleteBranch = () ->
			checks = document.getElementsByClassName("branch-check")
			count = 0
			id = ""
			for check in checks
				if check.checked
					count += 1
					id = check.value
					checked_item = check
			if count != 1
				window.alert("Please, select exactly one Branch before clicking delete")
			else
				try
					checked_item.checked = false
					form = document.getElementById("delete-" + id.toString())
					form[0].form[0].click()
				catch error
					window.alert("Form for ID delete-#{id} not found, " + error)

		document.getElementById("delete-branch").addEventListener("click", deleteBranch)

		# UPDATE ALL THIS
		issueUpdateBranchLatestLoads = () ->
			latest_loads = document.getElementsByClassName("branch-latest-load")
			for load in latest_loads
				updateBranch(load.dataset.path)

		updateBranch = () ->
			checks = document.getElementsByClassName("branch-check")
			getStatus = (path) ->
			$.ajax path,
			    type: 'GET'
			    dataType: 'json'
			    error: (jqXHR, textStatus, errorThrown) ->
			        return 'error'
			    success: (data, textStatus, jqXHR) ->
			    	# <<<<<<<<<<<<<<<<<<<<<< whats here? 
			        updateNeStatus(data)

		issueUpdateBranchLatestLoads()
		document.getElementById("branch-update").addEventListener("click", updateBranch)
	)