<template>
    <div>
        <label>地区：<input v-model="location" /></label>
        <label>小区：<input v-model="keyword" /></label>
        <input type="button" value="搜索" @click="searchBtn" />
        <Timeline :timelineList="timeLineArr" @scrollEvent="scrollEvent" @refresh="refresh" id="timeline" />
        <baidu-map :center="center" :zoom="zoom" @ready="handler" class="getMap" @click="getClickInfo"
            :scroll-wheel-zoom="true">
        </baidu-map>
    </div>
</template>
<script>
import { listArea } from "@/api/data/event";
import { Timeline } from "@/components/TimeLine/index";

export default {
    data() {
        return {
            areas: [],
            center: { lng: 117.35267834853804, lat: 38.99494446989348 },
            zoom: 13,
            location: "天津",
            keyword: "南开大学津南校区",
            BMap: "",
            map: "",
            nomore: true,
            timeLineArr: [
                {
                    id: 1,
                    date: "2022-01",
                    content: "2022-01",
                    isShow: true,
                },
                {
                    id: 2,
                    date: "2022-02",
                    content: "2022-02",
                    isShow: true,
                },
                {
                    id: 3,
                    date: "2022-03",
                    content: "2022-03",
                    isShow: true,
                },
                {
                    id: 4,
                    date: "2022-04",
                    content: "2022-04",
                    isShow: true,
                },
                {
                    id: 5,
                    date: "2022-05",
                    content: "2022-05",
                    isShow: true,
                },
                {
                    id: 6,
                    date: "2022-06",
                    content: "2022-06",
                    isShow: true,
                },
                {
                    id: 7,
                    date: "2022-07",
                    content: "2022-07",
                    isShow: true,
                },
                {
                    id: 8,
                    date: "2022-08",
                    content: "2022-08",
                    isShow: true,
                },
                {
                    id: 9,
                    date: "2022-09",
                    content: "2022-09",
                    isShow: true,
                },
                {
                    id: 10,
                    date: "2022-10",
                    content: "2022-10",
                    isShow: true,
                },
                {
                    id: 11,
                    date: "2022-11",
                    content: "2022-11",
                    isShow: true,
                },
                {
                    id: 12,
                    date: "2022-12",
                    content: "2022-12",
                    isShow: false,
                }
            ]
        };
    },
    methods: {
        async handler({ BMap, map }) {
            this.BMap = BMap;
            this.map = map;
            var point = new BMap.Point(this.center.lng, this.center.lat);
            map.addControl(new BMap.MapTypeControl());
            map.centerAndZoom(point, 13);
            var circle = new BMap.Circle(point, 6, {
                strokeColor: "Blue",
                strokeWeight: 6,
                strokeOpacity: 1,
                Color: "Blue",
                fillColor: "#f03",
            });
            map.addOverlay(circle);
            await listArea("2022-01").then(response => {
                this.areas = response;
            });
            this.showArea(this.location, this.areas, map);
        },
        getClickInfo(e) {
            this.center.lng = e.point.lng;
            this.center.lat = e.point.lat;
        },
        searchBtn() {
            this.showArea(this.location, this.keyword, this.map);
        },
        showArea(city, house, map) {
            var that = this;
            var urls = [];
            var queryHouseCallbacks = [];
            var queryHouseOutlineCallbacks = [];
            for (let i = 0; i < house.length; i++) {
                urls[i] =
                    "http://api.map.baidu.com/place/v2/search?output=json&scope=2" +
                    "&q=" +
                    house[i] +
                    "&region=" +
                    city +
                    "&ak=Cq2xcXoPUN7KQGd1LXuP7I3rGp77n2pl";
                queryHouseCallbacks[i] = "queryHouseCallbacks" + i;
                queryHouseOutlineCallbacks[i] = "queryHouseOutlineCallbacks" + i;
            }
            for (let i = 0; i < house.length; i++) {
                this.$jsonp(urls[i], {
                    callbackQuery: "callback",
                    callbackName: queryHouseCallbacks[i],
                }).then((data) => {
                    if (data.message == "ok") {
                        var houses = data.results;
                        if (houses && houses.length > 0) {
                            var house = houses[0];
                            var urlMap =
                                "http://map.baidu.com/?reqflag=pcmap&coord_type=3&from=webmap&qt=ext&ext_ver=new&l=18&uid=" +
                                house.uid;
                            this.$jsonp(urlMap, {
                                callbackQuery: "callback",
                                callbackName: queryHouseOutlineCallbacks[i],
                            }).then((houseOutline) => {
                                var geo = houseOutline.content.geo;
                                if (!geo) {
                                    var location = house.location;
                                    var point = new BMap.Point(location.lng, location.lat);
                                    //map.centerAndZoom(point, 19);
                                    var marker = new BMap.Marker(point);
                                    marker.setAnimation(BMAP_ANIMATION_BOUNCE);
                                    map.addOverlay(marker);
                                } else {
                                    var geoObj = that.parseGeo(geo);
                                    //边界点
                                    var points = that.coordinateToPoints(map, geoObj.points);
                                    var ply = new BMap.Polygon(points, {
                                        strokeWeight: 2,
                                        strokeColor: "#F01B2D",
                                        strokeOpacity: 0.9,
                                        fillColor: "#FFEBCC",
                                    }); //建立多边形覆盖物
                                    //map.setViewport(ply.getPath()); //调整视野
                                    map.addOverlay(ply); //添加覆盖物
                                }
                            });
                        }
                    }
                });
            }
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
        // 滚动监听
        scrollEvent(e) {
            if (
                e.srcElement.scrollLeft + e.srcElement.clientWidth >=
                e.srcElement.scrollWidth
            ) {
                // 这里正常请求数据即可
                let data = [

                ];
                if (!this.nomore) {
                    this.timeLineArr[this.timeLineArr.length - 1].isShow = true;
                    this.timeLineArr.push(...data);
                    this.nomore = true;
                }
            }
        },

        //更新地图
        async refresh(val) {
            /*
            this.map.addControl(new BMap.MapTypeControl());
            this.map.centerAndZoom(point, 13);
            var circle = new this.BMap.Circle(point, 6, {
                strokeColor: "Blue",
                strokeWeight: 6,
                strokeOpacity: 1,
                Color: "Blue",
                fillColor: "#f03",
            });
            this.map.addOverlay(circle);
            */
            let allOverlayList = this.map.getOverlays();
            //清除所有覆盖物
            for (var i = 0; i < allOverlayList.length; i++) {
                this.map.removeOverlay(allOverlayList[i]);
            }
            await listArea(val).then(response => {
                this.areas = response;
            });
            this.showArea(this.location, this.areas, this.map);
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
   