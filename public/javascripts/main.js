require(["./sliderise", "./truncate", "./jquery.jtruncate"], function(sliderise,truncate,jTruncate) {
  $(document).ready(function(){
    sliderise('section.people');
    sliderise('section.places');
    sliderise('section.articles');
    sliderise('section.timeline');
	
    truncate('div#news-lab-events article.intro p#event-description');        
    truncate('section.people ul.info li');
    
    // Toggle ORB barlesque footer disclaimer
    toggleNewsLabDisclaimer();
  });
  
  function toggleNewsLabDisclaimer() { 	
	var disclaimer = "This page is produced as part of BBC News Labs Product Exploration."
  	disclaimer += "Content may not be real, and must not in any way be interpreted as part of BBC News' official publications."
  	disclaimer += "For further information you can reach us at <a href='https://twitter.com/BBC_News_Labs'>https://twitter.com/BBC_News_Labs</a> ";
  	disclaimer += "or <a href='https://twitter.com/BBC_News_Labs'>@BBC_News_Labs</a>.";
  	$('.orb-hilight').parent('small').addClass('summer-labs-disclaimer').html(disclaimer);
  }
  
});

