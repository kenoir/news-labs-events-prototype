require(["./sliderise","./mapfeed"], function(sliderise,mapfeed) {
        sliderise('section.people');
        sliderise('section.places');
        sliderise('section.articles');

        mapfeed('section.places');
});

