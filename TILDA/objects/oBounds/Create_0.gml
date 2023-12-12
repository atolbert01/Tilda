width = bbox_right - bbox_left;
height = bbox_bottom - bbox_top;

//neighbors = ds_list_create();
//leftNeighbors = [];
//topNeighbors = [];
//bottomNeighbors = [];
//rightNeighbors = [];

//var x1 = bbox_left - 1;
//var y1 = bbox_top - 1;
//var x2 = bbox_right + 1;
//var y2 = bbox_bottom + 1;



//var col = collision_rectangle_list(x1, y1, x2, y2, oBounds, false, true, neighbors, false);

//if (col)
//{
//	for (var i = 0; i < ds_list_size(neighbors); i++)
//	{
//		var n = neighbors[| i];
		
		
//		// Are you to the left of me?
//		if (n.bbox_right < bbox_left)
//		{
//			array_push(leftNeighbors, n);
//		}
		
//		// Are you above me?
//		if (n.bbox_bottom < bbox_top)
//		{
//			array_push(topNeighbors, n);
//		}
		
//		// Are you right of me?
//		if (n.bbox_left > bbox_right)
//		{
//			array_push(rightNeighbors, n);
//		}
		
//		// Are you below me?
//		if (n.bbox_top < bbox_bottom)
//		{
//			array_push(bottomNeighbors, n);
//		}
		
//	}
//}