class TextDocument < Document
	field :content, type: String, default: ""
	
	# embeds_one :text_document_context
	# @doc_machine = StateMachine.build do
	# 	state :edit_requested do
	# 		event :lock_document, :editing
	# 		trans :unlocked, :lock_document, :editing
	# 		trans :locked_by_user, :update_lock, :editing
	# 		trans :locked_by_someone_else, :lock_timed_out, :editing
	# 		trans :locked_by_someone_else, :lock_not_timed_out, :edit_error	
	# 	end
	# 		state :editing do
	# 			event :save_requested, :saved, :successful_save
	# 			event :save_requested, :save_error, :unsuccessful_save
	# 			event :reset_requested, :editing, :reset
	# 			event :cancel_requested, :, :cancel
	# 			on_exit :unlock
	# 		end
	# 	

end