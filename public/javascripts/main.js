require(["./sliderise","./mapfeed"], function(sliderise,mapfeed) {
        sliderise('section.people');
        sliderise('section.places');

        mapfeed('section.places');
});

