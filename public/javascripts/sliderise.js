define(["jquery","./mustache","text!./templates/slider.html"],
  function($,Mustache,t){
    var sliderise = function(selector){
      var elements = $(selector)
      for(var i = 0; i < elements.length; i++){
        slider(elements[i]);
      }

      function slider(element){
        var head = $(element).find('h2');
        var content = $(element).find('.content');

        var sectionTitle = head.html();
        var updatedHead = $(template({title: sectionTitle}));

        $(head).replaceWith(updatedHead);
        $(updatedHead).bind('click',function(){

          $(content).slideToggle();
          //$(content).animate({height:'200px'}, 500);

          $('html,body').animate({"scrollTop": updatedHead.offset().top}, 2000);
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
