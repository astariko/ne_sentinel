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
			if count != 1
				window.alert("Please, select exactly one NE before clicking edit")
			else
				try
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
			if count != 1
				window.alert("Please, select exactly one NE before clicking delete")
			else
				try
					form = document.getElementById("delete-" + id.toString())
					form[0].form[1].click()
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
			if count != 1
				window.alert("Please, select exactly one NE before clicking upgrade")
			else
				try
					form = document.getElementById("upgrade-" + id.toString())
					form[0].click()
				catch error
					window.alert("Form for ID upgrade-#{id} not found, " + error)

		document.getElementById("upgrade-button").addEventListener("click", upgradeNe)
	)

