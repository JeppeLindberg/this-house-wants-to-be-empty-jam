extends Node2D

@onready var main = get_node('/root/main')

@export var guest_summary_prefab: PackedScene

@export var vbox: Control

var update_pending = false


func queue_update_overview():
	update_pending = true


func _process(_delta: float) -> void:
	if update_pending:
		update_pending = false

		var summaries = vbox.get_children()
		var tracked_guests = []
		for summary in summaries:
			if summary.guest != null and not summary.guest.is_queued_for_deletion():
				tracked_guests.append(summary.guest)

		var new_guests_to_track:Array = main.get_children_in_group(main, 'guest')
		for i in range(len(new_guests_to_track) -1, -1, -1):
			if not 'assigned_room' in new_guests_to_track[i].attributes:
				new_guests_to_track.remove_at(i)
				continue
			if new_guests_to_track[i] in tracked_guests:
				new_guests_to_track.remove_at(i)
				continue

		for guest in new_guests_to_track:
			var new_summary = guest_summary_prefab.instantiate()
			new_summary.guest = guest
			vbox.add_child(new_summary)

		for summary in vbox.get_children():
			summary.update_guest_summary()
			
		
