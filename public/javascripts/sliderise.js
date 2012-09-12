define(["jquery","./mustache","text!./templates/slider.html"],
  function($,Mustache,t){
    var sliderise = function(selector){
      var elements = $(selector)
      for(var i = 0; i < elements.length; i++){
        slider(elements[i]);
      }

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
        $(updatedHead).bind('click',function(){
          $(content).slideToggle();
          $('html,body').animate({"scrollTop": updatedHead.offset().top}, 2000);
          $(this).parents().filter('section').toggleClass('open');          
          return false;
        });

        $(content).slideUp();

        return element;
      }

      function template(values){
        return Mustache.to_html(t,values);
      }

    }

    return sliderise;
  }
);
