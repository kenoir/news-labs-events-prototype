require(["./sliderise","./mapfeed", "./truncate", "./jquery.jtruncate"], function(sliderise,mapfeed,truncate,jtruncate) {
        sliderise('section.people');
        sliderise('section.places');
        sliderise('section.articles');
        sliderise('section.timeline');

        mapfeed('section.places');
        
        truncate('section.people ul.info');
});

