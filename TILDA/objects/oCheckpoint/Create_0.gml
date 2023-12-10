doQuickSave = false;
roomManager = oRoomManager;
//tag = dec_to_hex(instance_number(oCheckpoint), 4);
tag = dec_to_hex(instance_number(object_index), 4);
roomManager.add_checkpoint(tag, self);

show_debug_message(tag);