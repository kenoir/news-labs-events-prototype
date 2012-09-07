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

        updatedHead.bind('click',function(){
          $(content).slideToggle();

          return false;
        });
        $(head).replaceWith(updatedHead);
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
