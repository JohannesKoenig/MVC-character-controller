class_name MoveSorter extends Node

var _moves: Dictionary

func accept_move_dict(moves: Dictionary):
	_moves = moves

func sort_actions(a: String, b: String) -> bool:
	return _moves[a].priority > _moves[b].priority
