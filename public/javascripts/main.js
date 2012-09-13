require(["./sliderise", "./truncate", "./jquery.jtruncate"], function(sliderise,truncate,jtruncate) {
        sliderise('section.people');
        sliderise('section.places');
        sliderise('section.articles');
        sliderise('section.timeline');
        
        truncate('section.people ul.info');
});

