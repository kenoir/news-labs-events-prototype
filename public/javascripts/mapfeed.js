define(["jquery","./polymaps"],
  function($){

    var mapfeed = function(places){
      var po = org.polymaps;

      var map = po.map()
        .container(document.getElementById('map').appendChild(po.svg('svg')))
        .center({lat: 50, lon: -150})
        .add(po.interact())
        .zoom(1);

        var svg = $('#map').find('svg');         
        svg[0].setAttribute('width', '100%');
        svg[0].setAttribute('height', '100%'); 

        svg.prepend($('<style>@import url(svg.css); </style>'));

        map.add(po.geoJson()
          .url("/data/map/world.json")
          .tile(false)
          .zoom(3)
          .on("load", manipulatemap));

        map.add(po.compass()
          .pan("none"));

        map.add(po.geoJson()
          .features([{geometry: {coordinates: [-122.258, 37.805], type: "Point"}}]));

        function manipulatemap(e) {
          for (var i = 0, L = e.features.length; i < L; i++) {
            var feature = e.features[i];
            var  hue = 29;
            var  sat = Math.round(Math.random()*99+1);
            var  lit = Math.round(Math.random()*60+20);
            feature.element.setAttribute("fill", 'hsl(' + hue + ", " + sat + '%, ' + lit + '%)');
            feature.element.setAttribute("id", feature.data.properties.name.toLowerCase().split(" ").join("_"))
          }

          map.resize();
        };

    }

    return mapfeed;

  }
);
