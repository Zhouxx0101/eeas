<template>
  <div>
    <label>地区：<input v-model="location"/></label>
    <label>小区：<input v-model="keyword"/></label>
    <input type="button" value="搜索" @click="searchBtn" />
    <baidu-map
      :center="center"
      :zoom="zoom"
      @ready="handler"
      class="getMap"
      @click="getClickInfo"
      :scroll-wheel-zoom="true"
    >
    </baidu-map>
  </div>
</template>
<script>
export default {
  data() {
    return {
      center: { lng: 116.404, lat: 39.915 },
      zoom: 13,
      location: "北京",
      keyword: "天安门",
      BMap:"",
      map:""
    };
  },
  mounted() {  },
  methods: {
    handler({ BMap, map }) {
      this.BMap = BMap;
      this.map = map;
      var point = new BMap.Point(this.center.lng,this.center.lat);
      map.addControl(new BMap.MapTypeControl());
      map.centerAndZoom(point, 13);
      var marker = new BMap.Marker(point); // 创建标注
      map.addOverlay(marker); // 将标注添加到地图中
      var circle = new BMap.Circle(point, 6, {
        strokeColor: "Red",
        strokeWeight: 6,
        strokeOpacity: 1,
        Color: "Red",
        fillColor: "#f03",
      });
      map.addOverlay(circle);
      this.showArea(this.location, this.keyword,map);
    },
    getClickInfo(e) {
      //   console.log(e.point.lng);
      //   console.log(e.point.lat);
      this.center.lng = e.point.lng;
      this.center.lat = e.point.lat;
    },
    searchBtn() {
      this.showArea(this.location, this.keyword,this.map);
    },
    showArea(city, house,map) {
      var that = this;
      var url =
        "http://api.map.baidu.com/place/v2/search?output=json&scope=2" +
        "&q=" +
        house +
        "&region=" +
        city +
        "&ak=Cq2xcXoPUN7KQGd1LXuP7I3rGp77n2pl";

      this.$jsonp(url, {
        callbackQuery: "callback",
        callbackName: "queryHouseCallback",
      }).then((data) => {
        // console.log(data)
        if (data.message == "ok") {
          var houses = data.results;
          if (houses && houses.length > 0) {
            var house = houses[0];
            var urlMap =
              "http://map.baidu.com/?reqflag=pcmap&coord_type=3&from=webmap&qt=ext&ext_ver=new&l=18&uid=" +
              house.uid;
            this.$jsonp(urlMap, {
              callbackQuery: "callback",
              callbackName: "queryHouseOutlineCallback",
            }).then((houseOutline) => {
                //console.log(houseOutline);
                var geo = houseOutline.content.geo;
              if (!geo) {
                var location = house.location;
                var point = new BMap.Point(location.lng, location.lat);
                map.centerAndZoom(point, 19);
                var marker = new BMap.Marker(point);
                marker.setAnimation(BMAP_ANIMATION_BOUNCE);
                map.addOverlay(marker);
              } else {
                map.clearOverlays();
                var geoObj = that.parseGeo(geo);
                //var bounds = coordinateToPoints(geoObj.bound);
                //边界点
                var points = that.coordinateToPoints(map, geoObj.points);
                var ply = new BMap.Polygon(points, {
                  strokeWeight: 2,
                  strokeColor: "#F01B2D",
                  strokeOpacity: 0.9,
                  fillColor: "#FFEBCC",
                }); //建立多边形覆盖物
                map.addOverlay(ply); //添加覆盖物
                map.setViewport(ply.getPath()); //调整视野
              }
            });
            
          }
        }
      });
    },
    
    coordinateToPoints(map, coordinate) {
      var points = [];
      if (coordinate) {
        var arr = coordinate.split(";");
        if (arr) {
          for (var i = 0; i < arr.length; i++) {
            var coord = arr[i].split(",");
            if (coord && coord.length == 2) {
              var mctXY = new BMap.Pixel(coord[0], coord[1]);
              var project = map.getMapType().getProjection();
              var point = project.pointToLngLat(mctXY);
              points.push(new BMap.Point(point.lng, point.lat));
            }
          }
        }
      }
      return points;
    },
    parseGeo(mocator) {
      if (typeof mocator != "string") {
        return {};
      }
      var t = mocator.split("|");
      var n = parseInt(t[0]);
      var i = t[1];
      var r = t[2];
      var o = r.split(";");
      if (n === 4) {
        for (var a = [], s = 0; s < o.length - 1; s++) {
          "1" === o[s].split("-")[0] && a.push(o[s].split("-")[1]);
        }
        o = a;
        o.push("");
      }
      var u = [];
      switch (n) {
        case 1:
          u.push(o[0]);
          break;
        case 2:
        case 3:
        case 4:
          for (var s = 0; s < o.length - 1; s++) {
            var l = o[s];
            if (l.length > 100) {
              l = l.replace(
                /(-?[1-9]\d*\.\d*|-?0\.\d*[1-9]\d*|-?0?\.0+|0|-?[1-9]\d*),(-?[1-9]\d*\.\d*|-?0\.\d*[1-9]\d*|-?0?\.0+|0|-?[1-9]\d*)(,)/g,
                "$1,$2;"
              );
              u.push(l);
            } else {
              for (var c = [], d = l.split(","), f = 0; f < d.length; f += 2) {
                var p = d[f];
                var h = d[f + 1];
                c.push(p + "," + h);
              }
              u.push(c.join(";"));
            }
          }
          break;
        default:
          break;
      }

      if (u.length <= 1) {
        u = u.toString();
      }

      var result = {
        type: n,
        bound: i,
        points: u,
      };
      return result;
    },
  },
};

</script>
<style lang="scss" scoped>
.getMap {
  width: 100%;
  height: 781px;
}
</style>
