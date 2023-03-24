<template>
    <ul class="timeline-wrapper">
        <li class="timeline-item" v-for="item in timelineList" :key="item.id">
            <div class="timeline-box">
                <div class="out-circle">
                    <div class="in-circle"></div>
                    <div class="timeline-date">
                        <el-button plain type="primary" size="mini" v-trigger @click="refresh(item.date)">
                        <!-- <el-button plain type="primary" size="mini" @click="info"> -->
                            {{ item.date }}
                        </el-button>
                    </div>
                </div>
                <div class="long-line" v-show="item.isShow"
                    :style="`width:${item.children ? (item.children.length + 1) * 80 : 1 * 80}px`">
                </div>
            </div>
        </li>
    </ul>
</template>
  
<script>
import Vue from "vue";
export default Vue.component("Timeline", {
    name: "Timeline",
    props: {
        timelineList: {
            type: Array,
            default: () => {
                return [];
            },
        },
    },
    mounted() { },
    methods: {
        // info() {
            
        // },
        refresh(val) {
            this.$emit("refresh", val);
        },
    },
    directive: {
        trigger: {
            inserted(el, binging) {
                console.log(el)
                el.click()
            }
        }
    }
});
</script>
  
<style scoped lang="scss">
ul.timeline-wrapper {
    list-style: none;
    margin: 0;
    padding-top: 20px;
    padding-bottom: 50px;
    padding-left: 50px;
    padding-right: 20px;
    white-space: nowrap;
    overflow-x: auto;
}

/* 时间线 */
.timeline-item {
    position: relative;
    display: inline-block;

    .timeline-box {
        text-align: center;
        // position: absolute;
        display: flex;
        align-items: center;

        .out-circle {
            width: 16px;
            height: 16px;
            background: rgba(14, 116, 218, 0.3);
            box-shadow: 0px 4px 12px 0px rgba(0, 0, 0, 0.4);
            /*opacity: 0.1;*/
            border-radius: 50%;
            display: flex;
            align-items: center;
            cursor: pointer;

            .in-circle {
                width: 8px;
                height: 8px;
                margin: 0 auto;
                background: rgba(14, 116, 218, 1);
                border-radius: 50%;
                box-shadow: 0px 4px 12px 0px rgba(0, 0, 0, 0.1);
            }

            .timeline-date {
                color: #333;
                margin-top: 60px;
                margin-left: -30px;

                .father-text {
                    font-weight: 700;
                    font-size: 10px;
                    margin-left: -15px;
                }
            }
        }

        .long-line {
            // width: 300px;
            height: 2px;
            background: rgba(14, 116, 218, 0.2);
            box-shadow: 0px 4px 12px 0px rgba(0, 0, 0, 0.3);
            display: flex;
            flex-direction: revert;
            justify-content: space-around;

            .sub-item-box {
                margin-top: -20px;
                position: absolute;

                .sub-line-box {
                    // cursor: pointer;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    align-items: center;

                    .children-line-box {
                        width: 0px;
                        border-left: 1px solid rgba(14, 116, 218, 0.3);
                    }

                    .children-box {
                        flex-wrap: wrap;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        border: 1px solid rgba(14, 116, 218, 0.3);
                        white-space: break-spaces;
                        text-align: center;
                        padding: 5px;
                    }
                }

                .top-line-box {
                    margin-top: -100px;
                    height: 60px;
                }

                .bottom-line-box {
                    margin-top: 5px;
                    height: 150px;
                }

                .top-line {
                    height: 60px;
                }

                .bottom-line {
                    height: 120px;
                }

                .top-children-box {
                    margin-top: -90px;
                    // height: 30px;
                    width: 100px;
                }

                .bottom-children-box {
                    // height: 120px;
                    width: 150px;
                }
            }
        }
    }

    .timeline-content {
        box-sizing: border-box;
        margin-left: -20px;
        height: 100px;
        padding: 0 0 0 20px;
        text-align: left;
        margin-bottom: 10px;

        .timeline-title {
            font-size: 10px;
            word-break: break-all;
            margin-bottom: 16px;
            color: #333;
            font-weight: 300;
            /*display: inline;*/
        }

        .timeline-desc {
            font-size: 10px;
            color: #999999;
        }
    }
}

.timeline-item:last-of-type .timeline-content {
    margin-bottom: 0;
}
</style>