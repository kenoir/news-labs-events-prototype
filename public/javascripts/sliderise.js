define(["jquery","./mustache","text!./templates/slider.html"],
  function($,Mustache,t){
    var sliderise = function(selector){
      var elements = $(selector)
      for(var i = 0; i < elements.length; i++){
        slider(elements[i]);
      }

			$(window).resize(function() {
				globalOpen();
			});

      function slider(element){
    	// Check for a parent section element with id -- should do for now
        if( $(element).parents().filter('section').attr('class') ) {
         return false;
        }

    		var head = $(element).find('h2').filter(":first");
        var content = $(element).find('.content').filter(":first");

        var sectionTitle = head.html();
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
				} else {
					$('.sliderised').slideDown();
				}	
			}

      function template(values){
        return Mustache.to_html(t,values);
			}


			function shouldSlide(){
					if($(window).width() < 768){
						return true;
					} 
					return false;
			}
	
			function bindClick(clickElement,targetElement){

        $(clickElement).bind('click',function(){
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
