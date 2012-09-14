require(["./sliderise", "./truncate", "./jquery.jtruncate"], function(sliderise,truncate,jTruncate) {
        sliderise('section.people');
        sliderise('section.places');
        sliderise('section.articles');
        sliderise('section.timeline');
	
        truncate('div#news-lab-events article.intro p#event-description');        
        truncate('section.people ul.info li');
});

