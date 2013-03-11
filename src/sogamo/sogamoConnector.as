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

package sogamo{
	
	import sogamo.sogamoConfigurator;
	
	import sogamo.core.sogamoSystem;
	
	/**
	 * Main class used to send data into <strong>SOGAMO's system</strong>, this one extends the core class which is used internally and all new tracks must be added on this class.
	 * 
	 * <p><strong>Copyright (c) 2013 ZelRealm Interactive Pte Ltd.</strong> Visit <a href="http://sogamo.com">http://sogamo.com</a> for documentation, updates and examples. </p>
	 */
	public class sogamoConnector extends sogamoSystem{
		
		 /**
		 * Constructor
		 * 
         * @param    $conf                     Configurator class to set the update type method
         * @return   none
		 * 
		 * Starts the <strong>SOGAMO</strong> API
         */	
		public function sogamoConnector($conf:sogamoConfigurator = null) {
			super($conf);
		}
		/**
         * Connects your game to the <strong>SOGAMO</strong> API, this interacts with sogamoSystem calling the same method on sogamoSystem class, you can start to call methods at any moment even before connection to <strong>SOGAMO's system</strong> in case is needed.
		 * 
         * @param    $apiKey                   The API key for your game. This can be found in <strong>SOGAMO</strong> dashboard.
         * @param    $player_id                The player’s player ID. For Facebook games, we recommend that you use the player’s Facebook ID. Otherwise, this can be the player ID that you assign to the player.
         * @param    $username                 The player’s username. For Facebook games, we recommend that you use the player’s Facebook username. Otherwise, this can be the username that the player chooses, or left null if not applicable.
         * @param    $firstname                The player’s first name
         * @param    $lastname                 The player’s last name
         * @param    $dob                      The player’s date of birth in the format of MM-DD-YYYY. Example: 02-20-1980
         * @param    $gender                   The player’s gender, which is either male or female. Example: male
         * @param    $signup_datetime          The date that the player signed up to play your game.
         * @param    $updated_datetime         The date that the player last updated his details. The format is as in the example. For Facebook games, this is the “updated_time” field in the User object.
         * @param    $email                    The player’s e-mail address
         * @param    $relationship_status      The player’s relationship status: Single, In a relationship, Engaged, Married, It's complicated, In an open relationship, Widowed, Separated, Divorced, In a civil union, In a domestic partnership
         * @param    $number_of_friends        The player’s number of friends
         * @param    $status                   Player’s status: New Old This is so that <strong>SOGAMO</strong> does not mistake an old player as new, because player can be new to our system but have been playing your game for some time.
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $currency                 A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		
		public function API($apiKey:String, $player_id:String, $username:String = "", $firstname:String = "", $lastname:String = "", $dob:String = "", $gender:String = "", $signup_date:Date = null, $updated_date:Date = null, $email:String = "", $relationship_status:String = "", $no_of_frds:int = NaN, $status:String = "", $credit:int = NaN, $currency:String = ""):void {
			connect($apiKey, $player_id, $username, $firstname, $lastname, $dob, $gender, $signup_date, $updated_date, $email, $relationship_status, $no_of_frds, $status, $credit, $currency);
		}
		
		/**
         * @param    $invite_id                A unique invite ID given by Facebook or generated by you. This will be used to match every response back to the original invite.
         * @param    $recipient_ids            A comma-separated list of recipients’ player IDs Example: 202,205,207,209
         * @param    $invite_type              Type of invite such as asking for help, requesting to be neighbor, etc. Example: Ask for turnip
         * @param    $screen_name              Your game can have different screens like battle area, map etc. Specify that screen name from where the player starts to invite. Screens need not be different pages. Example: Battle area
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		public function trackInviteSent($invite_id:int, $recipient_ids:String, $invite_type:String = "", $screen_name:String = "", $attributes:String = "", $credit:int = 0, $level:int = 0, $experience:int = 0, $virtualCurrency:String = ""):void {
			var params:Object = new Object();
			params["inviteId"] = $invite_id;
			params["recipientIds"] = $recipient_ids;
			params["inviteType"] = $invite_type;
			params["screenName"] = $screen_name;
			
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			
			params["playerId"] = this.playerID;//Filled automatically
			
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			
			//params["sessionId"] = this.sessionID;//Filled automatically
			
			send("inviteSent", params);
		}
		
		/**
         * @param    $invite_id                A unique invite ID given by Facebook or generated by you. This will be used to match the response back to the original invite.
         * @param    $responded_player_id      The player ID of the responded player.
         * @param    $responded_player_status  Indicates whether the responded player was already playing the game (that is, has the game application authorized or installed.) 2 for yes, 1 for no.
		 * @return   none
         */	
		public function trackInviteResponse($invite_id:int, $responded_player_id:String, $responded_player_status:int):void {
			var params:Object = new Object();
			params["inviteId"] = $invite_id;
			params["respondedPlayerId"] = $responded_player_id;
			params["responsedPlayerStatus"] = $responded_player_status;
			
			params["responseDatetime"] = sogamoSystem.convertToUnix(new Date());
			
			//_system.send("inviteResponse", params);
			send("inviteResponse", params);
		}
		
		/**
         * @param    $notification_id          A unique ID given by Facebook or generated by you for the notification. This will be used to match every response back to the original notification.
         * @param    $recipient_ids            A comma-separated list of recipients’ player IDs. Example: 202,205,207,209
         * @param    $notification_subject     The subject of the notification.
         * @param    $notification_text        The body text of the notification.
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		public function trackNotifiSent($notification_id:int, $recipient_ids:String, $notification_subject:String = "", $notification_text:String = "", $attributes:String = "", $credit:int = NaN, $level:int = NaN, $experience:int = NaN, $virtualCurrency:String = ""):void {
			var params:Object = new Object();
			
			params["playerId"] = this.playerID;//Filled automatically
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			params["notifiId"] = $notification_id;
			params["notifiSubject"] = $notification_subject;
			params["recipientIds"] = $recipient_ids;
			params["notifiText"] = $notification_text;
			
			send("notificationSent", params);
		}
		
		/**
         * @param    $notification_id          A unique ID given by Facebook or generated by you for the notification. This will be used to match every response back to the original notification.
         * @param    $responded_player_id      The player ID of the responded player.
         * @param    $responded_player_status  Indicates whether the responded player was already playing the game (that is, has the game application authorized or installed.) 2 for yes, 1 for no.
		 * @return   none
         */	
		public function trackNotifiResponse($notification_id:int, $responded_player_id:String, $responded_player_status:int):void {
			var params:Object = new Object();
			params["notifiId"] = $notification_id;
			params["respondedPlayerId"] = $responded_player_id;
			params["responsedPlayerStatus"] = $responded_player_status;
			
			params["responseDatetime"] = sogamoSystem.convertToUnix(new Date());
			
			send("notificationResponse", params);
		}
		
		/**
         * @param    $gift_id                  A unique ID given by Facebook or generated by you for the gift request. This will be used to match every response back to the original request.
		 * @param    $recipient_ids            A comma-separated list of recipients’ player IDs. Example: 202,205,207,209
         * @param    $gift_items               Comma-separated list of item code of the gifts sent. Example: A121,A131
         * @param    $screen_name              Your game can have different screens like battle area, map etc. Specify that screen name from where the player starts to invite. Screens need not be different pages. Example: Battle area
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		public function trackGiftRqstSent($gift_id:int, $recipient_ids:String, $gift_items:String ="", $screen_name:String ="", $attributes:String = "", $credit:int = NaN, $level:int = NaN, $experience:int = NaN, $virtualCurrency:String = ""):void {
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			params["giftRequestId"] = $gift_id;
			params["giftItems"] = $gift_items;
			params["recipientIds"] = $recipient_ids;
			params["screenName"] = $screen_name;
				
			send("giftSent", params);
		}
		
		/**
         * @param    $gift_id                  A unique ID given by Facebook or generated by you for the gift request. This will be used to match every response back to the original request.
         * @param    $responded_player_id      The player ID of the responded player.
         * @param    $responded_player_status  Indicates whether the responded player was already playing the game (that is, has the game application authorized or installed.) 2 for yes, 1 for no.
		 * @return   none
         */	
		public function trackGiftRqstResponse($gift_id:int, $responded_player_id:String, $responded_player_status:int):void {
			var params:Object = new Object();
			params["giftRequestId"] = $gift_id;
			params["respondedPlayerId"] = $responded_player_id;
			params["responsedPlayerStatus"] = $responded_player_status;
			
			params["responseDatetime"] = sogamoSystem.convertToUnix(new Date());
			
			send("giftResponse", params);
		}
		
		/**
         * @param    $story_id                 A unique ID given by Facebook or generated by you for the feed story. This will be used to match every response back to the original story.
		 * @param    $recipient_ids            A comma-separated list of recipients’ player IDs. Example: 202,205,207,209
         * @param    $story_mesg               The message inside the story.
         * @param    $story_type               The type of the story. Example: Leveled up
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		public function trackFeedStory($story_id:int, $recipient_ids:String, $story_mesg:String ="", $story_type:String ="", $attributes:String = "", $credit:int = NaN, $level:int = NaN, $experience:int = NaN, $virtualCurrency:String = ""):void {
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			
			params["storyId"] = $story_id;
			params["storyMessage"] = $story_mesg;
			params["recipientIds"] = $recipient_ids;
			params["storyType"] = $story_type;
			
			send("feedStory", params);
		}
		
		/**
         * @param    $story_id                 A unique ID given by Facebook or generated by you for the feed story. This will be used to match every response back to the original story.
         * @param    $responded_player_id      The player ID of the responded player.
         * @param    $responded_player_status  Indicates whether the responded player was already playing the game (that is, has the game application authorized or installed.) 2 for yes, 1 for no.
		 * @return   none
         */	
		public function trackFeedStoryResponse($story_id:int, $responded_player_id:String, $responded_player_status:int):void {
			var params:Object = new Object();
			params["storyId"] = $story_id;
			params["respondedPlayerId"] = $responded_player_id;
			params["responsedPlayerStatus"] = $responded_player_status;
			
			params["responseDatetime"] = sogamoSystem.convertToUnix(new Date());
			
			send("feedStoryResponse", params);
		}
		
		/**
         * @param    $story_id                 A unique ID given by Facebook or generated by you for the feed story. This will be used to match every response back to the original story.
		 * @param    $recipient_ids            A comma-separated list of recipients’ player IDs. Example: 202,205,207,209
         * @param    $story_mesg               The message inside the story.
         * @param    $story_type               The type of the story. Example: Leveled up
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		public function trackMultiFeedStory($story_id:int, $recipient_ids:String, $story_mesg:String ="", $story_type:String ="", $attributes:String = "", $credit:int = NaN, $level:int = NaN, $experience:int = NaN, $virtualCurrency:String = ""):void {
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			
			params["storyId"] = $story_id;
			params["storyMessage"] = $story_mesg;
			params["recipientIds"] = $recipient_ids;
			params["storyType"] = $story_type;
			
			send("multiFeedStory", params);
		}
		
		/**
         * @param    $story_id                 A unique ID given by Facebook or generated by you for the feed story. This will be used to match every response back to the original story.
         * @param    $responded_player_id      The player ID of the responded player.
         * @param    $responded_player_status  Indicates whether the responded player was already playing the game (that is, has the game application authorized or installed.) 2 for yes, 1 for no.
		 * @return   none
         */	
		public function trackMultiFeedResponse($story_id:int, $responded_player_id:String, $responded_player_status:int):void {
			var params:Object = new Object();
			params["storyId"] = $story_id;
			params["respondedPlayerId"] = $responded_player_id;
			params["responsedPlayerStatus"] = $responded_player_status;
			
			params["responseDatetime"] = sogamoSystem.convertToUnix(new Date());
			
			send("multiFeedStoryResponse", params);
		}
		
		/**
         * @param    $post_id                  A unique ID given by Facebook or generated by you for the post. This will be used to match every response back to the original post.
		 * @param    $post_mesg                The message inside the post.
         * @param    $post_type                The type of the post. Example: Killed a boss-level creature
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		public function trackPUA($post_id:int, $post_mesg:String, $post_type:String ="", $attributes:String = "", $credit:int = NaN, $level:int = NaN, $experience:int = NaN, $virtualCurrency:String = ""):void {
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			
			params["postId"] = $post_id;
			params["postMessage"] = $post_mesg;
			params["postType"] = $post_type;
			
			send("publishedUserAction", params);
		}
		
		/**
         * @param    $post_id                  A unique ID given by Facebook or generated by you for the post. This will be used to match every response back to the original post.
         * @param    $responded_player_id      The player ID of the responded player.
         * @param    $responded_player_status  Indicates whether the responded player was already playing the game (that is, has the game application authorized or installed.) 2 for yes, 1 for no.
		 * @return   none
         */	
		public function trackPUAResponse($post_id:int, $responded_player_id:String, $responded_player_status:int):void {
			var params:Object = new Object();
			params["postId"] = $post_id;
			params["respondedPlayerId"] = $responded_player_id;
			params["responsedPlayerStatus"] = $responded_player_status;
			
			params["responseDatetime"] = sogamoSystem.convertToUnix(new Date());
			
			send("publishedUserActionResponse", params);
		}
		
		/**
         * @param    $level                    Player’s level
		 * @param    $items_unlocked           Comma-separated list of item code of the items unlocked. Example: A121,A131
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		public function trackLevelUps($level:int, $items_unlocked:String, $attributes:String = "", $credit:int = NaN, $experience:int = NaN, $virtualCurrency:String = ""):void {
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			
			params["presentLevel"] = $level;
			params["levelupDatetime"] = sogamoSystem.convertToUnix(new Date());
			params["itemsUnlocked"] = $items_unlocked;
			
			send("levelUp", params);
		}
		
		/**
         * @param    $items_remaining          Comma-separated list of item code of the items that the player is eligible to buy but did not buy. Example: A121,A131
         * @param    $items_remaining_quantity Comma-separated list of quantity of the items that the player is eligible to buy but did not buy. The order of quantity in this list corresponds with the list of items code specified in items_remaining Example: 1,2
         * @param    $items_bought             Comma-separated list of item code of the items that the player bought. Example: A121,A131
         * @param    $items_bought_quantity    Comma-separated list of quantity of the items that the player bought. The order of quantity in this list corresponds with the list of items code specified in items_bought Example: 1,2
         * @param    $items_bought_price       Comma-separated list of semi-colon separated list of the price of the items bought, in virtual currency. The order of price in this list corresponds with the list of items code specified in items_bought Example: A=10;B=1,A=20 (means that the first item in items_bought has a price of 10 A and 1 B, while the second item has a price of 20 A)
         * @param    $log_action               Put “1” for purchases Example: 1
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $items_in_use             Comma-separated list of item code of the items that the player equips or is using. Example: A121,A131
         * @param    $items_in_inventory       Comma-separated list of item code of the items that is in the player’s inventory. Example: A121,A131
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */
		public function trackItemChange($items_remaining:String, $items_remaining_quantity:String = "", $items_bought:String = "", $items_bought_quantity:String = "", $items_bought_price:String = "", $log_action:String = "", $attributes:String = "", $items_in_use:String = "", $items_in_inventory:String = "", $credit:int = NaN, $level:int = NaN, $experience:int = NaN, $virtualCurrency:String = ""):void {
			
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["attributes"] = $attributes;
			params["itemsInUse"] = $items_in_use;
			params["itemsInInventory"] = $items_in_inventory;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			
			params["logAction"] = $log_action;
			params["itemsRemaining"] = $items_remaining;
			params["itemsRemainingQuantity"] = $items_remaining_quantity;
			params["itemsBought"] = $items_bought;
			params["itemsBoughtQuantity"] = $items_bought_quantity;
			params["itemsBoughtPrice"] = $items_bought_price;
				
			send("itemChange.logDatetime", params);
		}
		
		/**
         * @param    $currency_spent           A comma-separated string containing all of player’s virtual currencies spent Example: G=1,S=20,B=90
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
		 * @return   none
         */	
		public function trackMiscExpenditures($currency_spent:String, $attributes:String = "", $credit:int = NaN, $level:int = NaN, $experience:int = NaN):void {
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["currencySpent"] = $currency_spent;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			
			send("miscExpenditures.logDatetime", params);
		}
		
		/**
         * @param    $currency_earned          A comma-separated string containing all of player’s virtual currencies earned or topped up Example: G=1,S=20,B=90
         * @param    $currency_balance         A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
         * @param    $Remarks                  Remarks on the top-up, if any (such as reason, method of top-up)
		 * @return   none
         */	
		public function trackPlayerTopUp($currency_earned:String, $currency_balance:String, $Remarks:String =""):void {
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["gameId"] = this.gameID;//Filled automatically
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			params["currencyEarned"] = $currency_earned;
			params["currencyBalance"] = $currency_balance;
			params["remarks"] = $Remarks;
				
			send("playerTopUp", params);
		}
		
		/**
         * CREDIT SPENT TO BUY RESOURCE called when the player opens the shop
         * @param    $credit_spent             Amount of Facebook credits spent
		 * @param    $resource_bought          A comma-separated string containing all of player’s virtual currencies bought Example: G=1,S=20,B=90
		 * @param    $exchange_rate            The exchange rate between the real currency (with currency unit specified in real_currency) and 10 Facebook credits For example, assuming real_currency is USD, means USD1.233 is needed to buy 10 Facebook credits Example: 1.233
		 * @param    $real_currency            The real currency unit abbreviation, using ISO 4217 standard Example: USD
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		public function trackCreditSpent($credit_spent:int, $resource_bought:String, $exchange_rate:Number, $real_currency:String, $attributes:String = "", $credit:int = NaN, $level:int = NaN, $experience:int = NaN, $virtualCurrency:String = ""):void {
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["gameId"] = this.gameID;//Filled automatically
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level; //****************************** NO SET ON JAVASCRIPT
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			
			params["creditSpent"] = $credit_spent;
			params["resourceBought"] = $resource_bought;
			params["exchangeRate"] = $exchange_rate;
			params["realCurrency"] = $real_currency;
           
			send("payment.logDateTim", params);
		}
		
		/**
         * @param    $type                     Action type – “achievement”, “task”, “quests”, “tradein”, “pagein”, “pageout”
		 * @param    $successful               Whether the action was successful. 1 for yes, 0 for no. Default: 1 Example: 0
		 * @param    $description              Description explaining the action
		 * @param    $requirements             Requirements to complete the action
		 * @param    $rewards                  Rewards that was given for completing the action
         * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		public function trackPlayerAction($type:String, $successful:Boolean, $description:String="", $requirements:String="", $rewards:String="", $attributes:String = "", $credit:int = NaN, $level:int = NaN, $experience:int = NaN, $virtualCurrency:String = ""):void {
			var params:Object = new Object();
				
			var log_action:String = "";
			if($type == "achievement"){ log_action = "11";}
			if($type == "task"){ log_action = "12";}
			if($type == "quests"){ log_action = "13";}
			if($type == "tradein"){ log_action = "14";}
            
			params["playerId"] = this.playerID;//Filled automatically
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			params["logAction"] = log_action;
			
			params["type"] = $type;
			params["description"] = $description;
			params["requirements"] = $requirements;
			params["rewards"] = $rewards;
			params["successful"] = $successful; //****************************** NO SET ON JAVASCRIPT

			send("playerAction", params);
		}
		
		/**
         * @param    $outcome           The game outcome. You can use “win”, “lose”, “draw” or anything to differentiate different types of game outcomes Example: win
         * @param    $rewards           A comma-separated list of the item code of rewards gained by the user from the game round Example: A11,B02
         * @param    $cards_used        A comma-separated list of all cards or items used by the user Example: AB,G,G,AX
		 * @return   none
         */	
		public function trackGameOutcome($outcome:String = "", $rewards:String = "", $cards_used:String = ""):void {
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			
			params["outcome"] = $outcome;
			params["rewards"] = $rewards;
			params["cards"] = $cards_used; //****************************** SET ON JAVASCRIPT attributes credit level virtualCurrency
				
			send("gameOutcome", params);
		}

		/**
         * @param    $xPos                     X position on screen
         * @param    $yPos              	   Y position on screen
         * @param    $screen_name              Your game can have different screens like battle area, map etc. Specify that screen name from where the player starts to invite. Screens need not be different pages. Example: Battle area
		 * @param    $attributes               Player attributes at that time Example: STR=5,AGI=2
         * @param    $credit                   Player’s Facebook credit balance
         * @param    $level                    Player’s level
         * @param    $experience               Player’s experience amount
         * @param    $virtualCurrency          A comma-separated string containing all of player’s virtual currencies and balances Example: G=1,S=20,B=90
		 * @return   none
         */	
		public function trackUserClicks($xPos:Number, $yPos:Number, $screen_name:String = "", $attributes:String = "", $credit:int = NaN, $level:int = NaN, $experience:int = NaN, $virtualCurrency:String = ""):void {
			var params:Object = new Object();
			params["playerId"] = this.playerID;//Filled automatically
			params["attributes"] = $attributes;
			params["credit"] = $credit;
			params["level"] = $level;
			params["experience"] = $experience;
			params["virtualCurrency"] = $virtualCurrency;
			params["logDatetime"] = sogamoSystem.convertToUnix(new Date());
			//params["sessionId"] = this.sessionID;//Filled automatically
			
			params["screenName"] = $screen_name;
			params["clickedDatetime"] = sogamoSystem.convertToUnix(new Date());
			
			params["xPosition"] = $xPos;
			params["yPosition"] = $yPos;
			
			send("userClicks", params);
		}
		
		/*NOTE
		 * trackItemDetails    NO set
		 * trackPriceSuggest   NO set
		 */
	}
}