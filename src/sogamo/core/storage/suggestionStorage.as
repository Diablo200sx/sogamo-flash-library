/*
* Sogamo
* Visit http://sogamo.com/ for documentation, updates and examples.
* 
* Author Oscar Arotaype Herrera 
* email : developers@sogamo.com 
* 
* 
* Copyright (c) 2013 ZelRealm Interactive Pte Ltd.
* 
*/

package sogamo.core.storage {
	
	import sogamo.core.storage.suggestionStorageNode;
	
	/**
	 * Class used to store the suggestions to be called fallowing the order they were called.
	 * 
	 * <p><strong>Copyright (c) 2013 ZelRealm Interactive Pte Ltd.</strong> Visit <a href="http://sogamo.com">http://sogamo.com</a> for documentation, updates and examples. </p>
	 */
	public class suggestionStorage {
		
		private var first:suggestionStorageNode;
		private var last:suggestionStorageNode;
		
		public function suggestionStorage():void{
			first = null;
		}
		
		public function isEmpty():Boolean {
			return (first == null);
		}
		
		public function priority(data:Object):void {
			var node:suggestionStorageNode = new suggestionStorageNode();
			node.next = null;
			node.data = data;
			if (isEmpty()) {
				first = node;
				//last = node;
			} else {
				node.next = first;
				//first.next = first;
				first = node;
				//last = node;
			}
			//last = node;
		}
		
		public function enqueue(data:Object):void {
			var node:suggestionStorageNode = new suggestionStorageNode();
			node.next = null;
			node.data = data;
			if (isEmpty()) {
				first = node;
				//last = node;
			} else {
				last.next = node;
				//last = node;
			}
			last = node;
		}
		
		public function dequeue():Object {
			if (isEmpty()) {
				//trace("Error: \n\t Objects of type Queue must contain data before being dequeued.");
				return null;
			}
			var data:Object = first.data;//first in 3 - 2 - 1 -> 1 - 2 - 3
			first = first.next;
			return data;
		}
		
		public function peek():Object	{
			if (isEmpty()) {
				//trace("Error: \n\t Objects of type Queue must contain data before you can peek.");
				return null;
			}
			return first.data;
		}
	}
}