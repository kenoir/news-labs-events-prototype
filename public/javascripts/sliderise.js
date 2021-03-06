define(["jquery","./mustache","text!./templates/slider.html"],
  function($,Mustache,t){
    var sliderise = function(selector){
      var elements = $(selector)
      for(var i = 0; i < elements.length; i++){
        slider(elements[i]);
      }
      
      var width = $(window).width();
      $(window).resize(function(){
         if($(this).width() != width){
            width = $(this).width();
            globalOpen();
         }
      });

      function slider(element){
    	// Check for a parent section element with id -- should do for now
        if( $(element).parents().filter('section').attr('class') ) {
          return false;
        }

    	var head = $(element).find('h2').filter(":first");
        var content = $(element).find('.content').filter(":first");

        var sectionTitle = head.text();
        var updatedHead = $(template({title: sectionTitle}));

        $(head).replaceWith(updatedHead);
				bindClick(updatedHead,content);
				$(content).addClass('sliderised');
				if (shouldSlide()){
					$(content).slideUp();
				}

				return element;
		}

		function globalOpen(){
			if(shouldSlide()){
				$('.sliderised').slideUp();
				$('div#news-lab-events section').removeClass('no-slider');
				$('div#news-lab-events section').removeClass('open');
			} else {
				$('.sliderised').slideDown();
				$('div#news-lab-events section').addClass('no-slider');
			}	
		}

        function template(values){
            return Mustache.to_html(t,values);
	    }


	    function shouldSlide(){
			if($(window).width() < 720){
				return true;
			} 
			return false;
	    }
	
		function bindClick(clickElement,targetElement){

        $(clickElement).bind('click',function(event){
        		if(!shouldSlide()) { return; }
		         $(targetElement).slideToggle();
		         $('html,body').animate({"scrolltop": clickElement.offset().top - 5}, 750);
		         $(this).parents().filter('section').toggleClass('open');
		                   
		         return false;
        });


		}

    }

    return sliderise;
  }
);
