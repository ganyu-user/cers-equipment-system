<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="预约单ID" prop="orderId">
        <el-input
          v-model="queryParams.orderId"
          placeholder="请输入预约单ID"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="预约人姓名" prop="realName">
        <el-input
          v-model="queryParams.realName"
          placeholder="请输入预约人姓名"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学号" prop="studentNo">
        <el-input
          v-model="queryParams.studentNo"
          placeholder="请输入学号"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="预约开始时间" style="width: 308px">
        <el-date-picker
          v-model="daterangeReserveTime"
          value-format="YYYY-MM-DD"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="预计归还时间" style="width: 308px">
        <el-date-picker
          v-model="daterangeExpectReturnTime"
          value-format="YYYY-MM-DD"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="实际归还时间" style="width: 308px">
        <el-date-picker
          v-model="daterangeActualReturnTime"
          value-format="YYYY-MM-DD"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="预约状态" prop="orderStatus">
        <el-select v-model="queryParams.orderStatus" placeholder="请选择预约状态" clearable>
          <el-option
            v-for="dict in res_order_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="延期状态" prop="extendStatus">
        <el-select v-model="queryParams.extendStatus" placeholder="请选择延期状态" clearable>
          <el-option
            v-for="dict in res_extend_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="创建时间" style="width: 308px">
        <el-date-picker
          v-model="daterangeCreateTime"
          value-format="YYYY-MM-DD"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['system:reserveOrder:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:reserveOrder:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:reserveOrder:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['system:reserveOrder:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="reserveOrderList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="预约单ID" align="center" prop="orderId" />
      <el-table-column label="预约数量" align="center" prop="quantity" />
      <el-table-column label="预约人姓名" align="center" prop="realName" />
      <el-table-column label="学号" align="center" prop="studentNo" />
      <el-table-column label="年级" align="center" prop="grade" />
      <el-table-column label="专业" align="center" prop="major" />
      <el-table-column label="手机号" align="center" prop="phone" />
      <el-table-column label="预约开始时间" align="center" prop="reserveTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.reserveTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="预计归还时间" align="center" prop="expectReturnTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.expectReturnTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="实际归还时间" align="center" prop="actualReturnTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.actualReturnTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="预约状态" align="center" prop="orderStatus">
        <template #default="scope">
          <dict-tag :options="res_order_status" :value="scope.row.orderStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="拒绝理由" align="center" prop="rejectReason" />
      <el-table-column label="领取地点" align="center" prop="pickupLocation" />
      <el-table-column label="领取时间" align="center" prop="pickupTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.pickupTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="延期状态" align="center" prop="extendStatus">
        <template #default="scope">
          <dict-tag :options="res_extend_status" :value="scope.row.extendStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="延期后的预计归还时间" align="center" prop="extendExpectReturnTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.extendExpectReturnTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="延期原因/审批意见" align="center" prop="extendReason" />
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:reserveOrder:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:reserveOrder:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改设备预约单管理对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="reserveOrderRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="ReserveOrder">
import { listReserveOrder, getReserveOrder, delReserveOrder, addReserveOrder, updateReserveOrder } from "@/api/system/reserveOrder"

const { proxy } = getCurrentInstance()
const { res_order_status, res_extend_status } = useDict('res_order_status', 'res_extend_status')

const reserveOrderList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const daterangeReserveTime = ref([])
const daterangeExpectReturnTime = ref([])
const daterangeActualReturnTime = ref([])
const daterangeCreateTime = ref([])

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    orderId: undefined,
    realName: undefined,
    studentNo: undefined,
    reserveTime: undefined,
    expectReturnTime: undefined,
    actualReturnTime: undefined,
    orderStatus: undefined,
    extendStatus: undefined,
    createTime: undefined,
  },
  rules: {
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询设备预约单管理列表 */
function getList() {
  loading.value = true
  queryParams.value.params = {}
  if (null != daterangeReserveTime.value && '' != daterangeReserveTime.value) {
    queryParams.value.params["beginReserveTime"] = daterangeReserveTime.value[0]
    queryParams.value.params["endReserveTime"] = daterangeReserveTime.value[1]
  }
  if (null != daterangeExpectReturnTime.value && '' != daterangeExpectReturnTime.value) {
    queryParams.value.params["beginExpectReturnTime"] = daterangeExpectReturnTime.value[0]
    queryParams.value.params["endExpectReturnTime"] = daterangeExpectReturnTime.value[1]
  }
  if (null != daterangeActualReturnTime.value && '' != daterangeActualReturnTime.value) {
    queryParams.value.params["beginActualReturnTime"] = daterangeActualReturnTime.value[0]
    queryParams.value.params["endActualReturnTime"] = daterangeActualReturnTime.value[1]
  }
  if (null != daterangeCreateTime.value && '' != daterangeCreateTime.value) {
    queryParams.value.params["beginCreateTime"] = daterangeCreateTime.value[0]
    queryParams.value.params["endCreateTime"] = daterangeCreateTime.value[1]
  }
  listReserveOrder(queryParams.value).then(response => {
    reserveOrderList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

/** 取消按钮 */
function cancel() {
  open.value = false
  reset()
}

/** 表单重置 */
function reset() {
  form.value = {
    orderId: null,
    userId: null,
    equipId: null,
    quantity: null,
    realName: null,
    studentNo: null,
    grade: null,
    major: null,
    phone: null,
    reserveTime: null,
    expectReturnTime: null,
    actualReturnTime: null,
    orderStatus: null,
    rejectReason: null,
    pickupLocation: null,
    pickupTime: null,
    extendStatus: null,
    extendExpectReturnTime: null,
    extendReason: null,
    createTime: null,
    updateBy: null,
    updateTime: null,
    remark: null
  }
  proxy.resetForm("reserveOrderRef")
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  daterangeReserveTime.value = []
  daterangeExpectReturnTime.value = []
  daterangeActualReturnTime.value = []
  daterangeCreateTime.value = []
  proxy.resetForm("queryRef")
  handleQuery()
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.orderId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加设备预约单管理"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _orderId = row.orderId || ids.value
  getReserveOrder(_orderId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改设备预约单管理"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["reserveOrderRef"].validate(valid => {
    if (valid) {
      if (form.value.orderId != null) {
        updateReserveOrder(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addReserveOrder(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _orderIds = row.orderId || ids.value
  proxy.$modal.confirm('是否确认删除设备预约单管理编号为"' + _orderIds + '"的数据项？').then(function() {
    return delReserveOrder(_orderIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/reserveOrder/export', {
    ...queryParams.value
  }, `reserveOrder_${new Date().getTime()}.xlsx`)
}

getList()
</script>
