# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Notifications
	constructor: ->
		@notifications = $("[data-behavior='notifications']")
		@setup() if @notifications.length > 0

	setup: ->
		$("[data-behavior='notifications-link']").on "click", @handleClick
		$.ajax(
			url: "/notifications.json"
			datatype: "JSON"
			method: "GET"
			success: @handleSuccess
		)

	handleClick: (e) =>
		$.ajax(
			url: "/notifications/mark_as_read"
			beforeSend: (xhr)->
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
			datatype: "JSON"
			method: "POST"
			success: ->
				$("[data-behavior='unread-count']").text(0)
		)

	handleSuccess: (data) =>
		items = $.map data, (notification) ->
			"<a class='dropdown-item' href='#{notification.url}''>#{notification.actor} #{notification.action} #{notification.notifiable.type}</a>"
		$("[data-behavior='unread-count']").text(items.length)
		$("[data-behavior='notification-items']").html(items)

jQuery ->
	new Notifications