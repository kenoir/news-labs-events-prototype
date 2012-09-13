define(["jquery","./jquery.jtruncate"],
		
	function ($) {
		    
    	var truncate = function(element) {

    		var element = $(element).find('li').last();    	
    		element.jTruncate(
    				{  
    			        length: 100,  
    			        minTrail: 0,  
    			        moreText: "[More]",  
    			        lessText: "[Less]",  
    			        ellipsisText: " ...",  
    			        moreAni: "fast",  
    			        lessAni: 300  
    			    }
    		);
    		
    	};
    	
    	return truncate;
	    
    }
	
    

);

