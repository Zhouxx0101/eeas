<template>
  <div class="app-container">
      <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
              <el-button
              type="primary"
              plain
              icon="el-icon-plus"
              size="mini"
              @click="handleAdd"
              v-hasPermi="['system:task:add']"
              >新建任务</el-button>
          </el-col>
      </el-row>

      <el-row>
          <el-col :span="8" v-for="(item, i) in taskList" :key="i" :offset="1.5">
              <div style="margin-top:30px">        
                  <el-card class="box-card">
                      <div slot="header" class="clearfix">
                          <span>{{item.name}}</span>
                          <el-button style="float: right; padding: 3px 0" type="text" @click="jumpToMap(item)">查看</el-button>
                      </div>
                      <div class="text item">
                          <span>地区：</span>
                          <span>{{item.place}}</span>
                      </div>
                      <div class="text item">
                          <span>开始时间：</span>
                          <span>{{item.startTime}}</span>
                      </div>
                      <div class="text item">
                          <span>结束时间：</span>
                          <span>{{item.endTime}}</span>
                      </div>
                      <div class="text item">
                          <span>时间窗口：</span>
                          <span>{{item.timeInterval}}</span>
                      </div>
                      <!-- <div class="text item">
                          <span>数据源：</span>
                          <span v-if="item.dataSource=='0'">自动导入</span>
                          <span v-if="item.dataSource=='1'">手动录入</span>
                      </div> -->
                      <el-button
                          size="mini"
                          type="text"
                          icon="el-icon-edit"
                          @click="handleUpdate(item)"
                          v-hasPermi="['system:task:edit']"
                      >修改</el-button>
                      <el-button
                          size="mini"
                          type="text"
                          icon="el-icon-delete"
                          @click="handleDelete(item)"
                          v-hasPermi="['system:task:remove']"
                      >删除</el-button>

                  </el-card>
              </div>

          </el-col>
      </el-row>

      <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :page-sizes="[6, 12, 24, 36]"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
      />

      <!-- 添加任务对话框 -->
      <el-dialog :title="title" :visible.sync="openAdd" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rulesAdd" label-width="80px">
          <el-form-item label="任务名称" prop="name">
              <el-input v-model="form.name" placeholder="请输入任务名称" />
          </el-form-item>
          <el-form-item label="开始时间" prop="startTime">
          <el-date-picker clearable
              v-model="form.startTime"
              type="date"
              value-format="yyyy-MM-dd"
              placeholder="请选择开始时间">
          </el-date-picker>
          </el-form-item>
          <el-form-item label="结束时间" prop="endTime">
          <el-date-picker clearable
              v-model="form.endTime"
              type="date"
              value-format="yyyy-MM-dd"
              placeholder="请选择结束时间">
          </el-date-picker>
          </el-form-item>
          <el-form-item label="时间窗口" prop="timeInterval">
          <el-input v-model="form.timeInterval" placeholder="请输入时间窗口" />
          </el-form-item>
          <el-form-item label="地点" prop="place">
          <el-input v-model="form.place" placeholder="请输入地点" />
          </el-form-item>
          <!-- <el-form-item label="数据源" prop="dataSource">
          <el-select v-model="form.dataSource" placeholder="请选择数据源">
              <el-option
              v-for="dict in dict.type.eeas_task"
              :key="dict.value"
              :label="dict.label"
  :value="parseInt(dict.value)"
              ></el-option>
          </el-select>
          </el-form-item> -->
          <el-form-item label="源数据">
            <input type="file" ref="clearFile" @change="getFile($event)" multiple="multiplt" class="add-file-left-input" style="margin-left:0px;" accept=".docx,.doc,.pdf,.xlsx,.xls">
            <el-button type="primary" @click="submitAddFile" size="small">开始上传</el-button>

          </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
      </div>
      </el-dialog>

      <!-- 修改任务对话框 -->
      <el-dialog :title="title" :visible.sync="openEdit" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rulesEdit" label-width="80px">
          <el-form-item label="任务名称" prop="name">
              <el-input v-model="form.name" placeholder="请输入任务名称" />
          </el-form-item>
          <el-form-item label="开始时间" prop="startTime">
          <el-date-picker clearable
              v-model="form.startTime"
              :disabled="true"
              type="date"
              value-format="yyyy-MM-dd"
              placeholder="请选择开始时间">
          </el-date-picker>
          </el-form-item>
          <el-form-item label="结束时间" prop="endTime">
          <el-date-picker clearable
              v-model="form.endTime"
              type="date"
              value-format="yyyy-MM-dd"
              placeholder="请选择结束时间">
          </el-date-picker>
          </el-form-item>
          <el-form-item label="时间窗口" prop="timeInterval">
          <el-input v-model="form.timeInterval" placeholder="请输入时间窗口" />
          </el-form-item>
          <el-form-item label="地点" prop="place">
          <el-input v-model="form.place" :disabled="true" placeholder="请输入地点" />
          </el-form-item>
          <!-- <el-form-item label="数据源" prop="dataSource">
          <el-select v-model="form.dataSource" :disabled="true" placeholder="请选择数据源">
              <el-option
              v-for="dict in dict.type.eeas_task"
              :key="dict.value"
              :label="dict.label"
  :value="parseInt(dict.value)"
              ></el-option>
          </el-select>
          </el-form-item> -->
          

      </el-form>
      <div slot="footer" class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
      </div>
      </el-dialog>

  </div>
</template>

<script>
import { listTask, getTask, delTask, addTask, updateTask } from "@/api/data/task";
import { selectComponents } from "@/utils/generator/config";

export default {
name: "Task",
dicts: ['eeas_task'],
data() {
  return {
    // 遮罩层
    loading: true,
    // 选中数组
    ids: [],
    // 非单个禁用
    single: true,
    // 非多个禁用
    multiple: true,
    // 显示搜索条件
    showSearch: true,
    // 总条数
    total: 0,
    // 任务表格数据
    taskList: [],
    // 弹出层标题
    title: "",
    // 是否显示弹出层
    openAdd: false,
    openEdit: false,
    // 查询参数
    queryParams: {
      pageNum: 1,
      pageSize: 6,
      name: null,
      startTime: null,
      endTime: null,
      timeInterval: null,
      place: null,
      dataSource: null
    },
    // 表单参数
    form: {},
    // 表单校验
    rulesAdd: {
      name: [{required: true, trigger: 'blur'}],
      startTime: [{required: true, trigger: 'blur'}],
      timeInterval: [{required: true, trigger: 'blur'}],
      place: [{required: true, trigger: 'blur'}],
      dataSource: [{required: true, trigger: 'blur'}],
    },
    rulesEdit: {
      // endTime: [{required: true, trigger: 'blur'}],
    }
  };
},
created() {
  this.getList();
},
methods: {
  sleep(ms) { //sleep延迟方法2
            var unixtime_ms = new Date().getTime();
            while(new Date().getTime() < unixtime_ms + ms) {}
        },
  // 点击上传文件，弹出上传成功对话框
  submitAddFile(){
          this.sleep(500);
          alert("文件上传成功！")
        },
  /** 查询任务列表 */
  getList() {
    this.loading = true;
    listTask(this.queryParams).then(response => {
      console.log("listTask called")
      console.log(response)
      this.taskList = response.rows;
      this.total = response.total;
      this.loading = false;
      console.log(this.taskList);
    });
  },
  // 取消按钮
  cancel() {
    this.openAdd = false;
    this.openEdit = false;
    this.reset();
  },
  // 表单重置
  reset() {
    this.form = {
      id: null,
      name: null,
      startTime: null,
      endTime: null,
      timeInterval: null,
      place: null,
      dataSource: null
    };
    this.resetForm("form");
  },
  /** 搜索按钮操作 */
  handleQuery() {
    this.queryParams.pageNum = 1;
    this.getList();
  },
  /** 重置按钮操作 */
  resetQuery() {
    this.resetForm("queryForm");
    this.handleQuery();
  },
  // 多选框选中数据
  handleSelectionChange(selection) {
    this.ids = selection.map(item => item.id)
    this.single = selection.length!==1
    this.multiple = !selection.length
  },
  /** 新增按钮操作 */
  handleAdd() {
    this.reset();
    this.openAdd = true;
    this.title = "添加任务";
  },
  /** 修改按钮操作 */
  handleUpdate(item) {
    this.reset();
    const id = item.id
    getTask(id).then(response => {
      this.form = response.data;
      this.openEdit = true;
      this.title = "修改任务";
    });
  },
  /** 提交按钮 */
  submitForm() {
    this.$refs["form"].validate(valid => {
      if (valid) {
        if (this.form.id != null) {
          updateTask(this.form).then(response => {
            this.$modal.msgSuccess("修改成功");
            this.openEdit = false;
            this.getList();
          });
        } else {
          addTask(this.form).then(response => {
            this.$modal.msgSuccess("新增成功");
            this.openAdd = false;
            this.getList();
          });
        }
      }
    });
  },
  /** 删除按钮操作 */
  handleDelete(item) {
    const idp = item.name
    this.$modal.confirm('是否确认删除任务名称为"' + idp + '"的任务项？').then(function() {
      return delTask(ids);
    }).then(() => {
      this.getList();
      this.$modal.msgSuccess("删除成功");
    }).catch(() => {});
  },
  /** 导出按钮操作 */
  handleExport() {
    this.download('system/task/export', {
      ...this.queryParams
    }, `task_${new Date().getTime()}.xlsx`)
  },
  // 点击查看按钮，跳转到交互地图
  jumpToMap(item){
    console.log("查看")
    this.$router.push("/diagram")
    localStorage.setItem("taskid",item.id);
  }
}
};
</script>

<style>
.time {
  font-size: 13px;
  color: #999;
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  padding: 0;
  float: right;
}

.image {
  width: 100%;
  display: block;
}

.clearfix:before,
.clearfix:after {
    display: table;
    content: "";
}

.clearfix:after {
    clear: both
}

.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}

.box-card {
  width: 480px;
}
</style>
