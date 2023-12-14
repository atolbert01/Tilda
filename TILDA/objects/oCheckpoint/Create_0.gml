doQuickSave = false;
tagString = dec_to_hex(tag, 4)
tagWidth = string_width(tagString);
tagHeight = string_height(tagString);
tagX = x - (tagWidth * 0.5);
tagY = y + 4;

// Register ourselves with the game manager
gameManager = oGameManager;
gameManager.add_checkpoint(self);