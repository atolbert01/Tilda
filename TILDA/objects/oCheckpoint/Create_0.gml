doQuickSave = false;
gameManager = oGameManager;
//tag = dec_to_hex(instance_number(oCheckpoint), 4);

tag = gameManager.add_checkpoint(self);

show_debug_message(tag);