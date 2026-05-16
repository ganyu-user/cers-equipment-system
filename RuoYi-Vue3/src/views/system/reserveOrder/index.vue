<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
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
      <el-form-item label="预约时间" prop="reserveTime">
        <el-date-picker
          v-model="queryParams.reserveTime"
          type="date"
          placeholder="选择预约时间"
          value-format="YYYY-MM-DD"
          clearable
        />
      </el-form-item>
      <el-form-item label="归还状态" prop="returnStatus">
        <el-select v-model="queryParams.returnStatus" placeholder="请选择归还状态" clearable>
          <el-option
            v-for="dict in eq_return_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
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
          v-hasPermi="['system:resOrder:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:resOrder:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:resOrder:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['system:resOrder:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="resOrderList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="订单ID" align="center" prop="orderId" />
      <el-table-column label="用户名称" align="center" prop="userName" />
      <el-table-column label="预约时间" align="center" prop="reserveTime" width="180" />
      <el-table-column label="预约状态" align="center" prop="orderStatus">
        <template #default="scope">
          <dict-tag :options="res_order_status" :value="scope.row.orderStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="设备名称" align="center" prop="equipmentName" />
      <el-table-column label="设备图片" align="center" prop="equipmentImage" width="100">
        <template #default="scope">
          <el-image v-if="scope.row.equipmentImage" style="width: 50px; height: 50px" :src="scope.row.equipmentImage" :preview-src-list="[scope.row.equipmentImage]" fit="cover" />
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="预约数量" align="center" prop="quantity" />
      <el-table-column label="分配设备编号" align="center" prop="assignedUnitCodes" width="180">
        <template #default="scope">
          <span>{{ scope.row.assignedUnitCodes || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="预计归还时间" align="center" prop="expectReturnTime" width="180" />
      <el-table-column label="审批人" align="center" prop="approverName">
        <template #default="scope">
          <span>{{ scope.row.approverName || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审批时间" align="center" prop="approveTime" width="180">
        <template #default="scope">
          <span>{{ scope.row.approveTime || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="归还状态" align="center" prop="returnStatus">
        <template #default="scope">
          <dict-tag :options="eq_return_status" :value="scope.row.returnStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="260">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:resOrder:edit']">修改</el-button>
          <el-button link type="success" icon="CircleCheck" @click="handleApprove(scope.row)" v-if="scope.row.orderStatus === '0'" v-hasPermi="['system:resOrder:approve']">通过</el-button>
          <el-button link type="danger" icon="CircleClose" @click="handleReject(scope.row)" v-if="scope.row.orderStatus === '0'" v-hasPermi="['system:resOrder:approve']">拒绝</el-button>
          <el-button link type="warning" icon="RefreshRight" @click="handleReturn(scope.row)" v-if="scope.row.orderStatus === '4'" v-hasPermi="['system:resOrder:return']">归还</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:resOrder:remove']">删除</el-button>
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

    <!-- 添加或修改预约订单对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="resOrderRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="用户ID" prop="userId">
              <el-input v-model="form.userId" placeholder="请输入用户ID" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="预约时间" prop="reserveTime">
              <el-date-picker
                v-model="form.reserveTime"
                type="date"
                placeholder="选择预约时间"
                value-format="YYYY-MM-DD"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="预约状态" prop="orderStatus">
              <el-radio-group v-model="form.orderStatus">
                <el-radio
                  v-for="dict in res_order_status"
                  :key="dict.value"
                  :value="dict.value"
                >{{ dict.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="设备ID" prop="equipmentId">
              <el-input v-model="form.equipmentId" placeholder="请输入设备ID" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="预约数量" prop="quantity">
              <el-input v-model="form.quantity" placeholder="请输入预约数量" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="预计归还时间" prop="expectReturnTime">
              <el-date-picker
                v-model="form.expectReturnTime"
                type="date"
                placeholder="选择预计归还时间"
                value-format="YYYY-MM-DD"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 拒绝对话框 -->
    <el-dialog title="拒绝订单" v-model="rejectOpen" width="450px" append-to-body>
      <el-form ref="rejectFormRef" :model="rejectForm" :rules="rejectRules" label-width="80px">
        <el-form-item label="拒绝原因" prop="rejectReason">
          <el-input v-model="rejectForm.rejectReason" type="textarea" placeholder="请输入拒绝原因" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitReject">确 定</el-button>
          <el-button @click="rejectOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 归还对话框 -->
    <el-dialog title="归还设备" v-model="returnOpen" width="450px" append-to-body>
      <el-form ref="returnFormRef" :model="returnForm" :rules="returnRules" label-width="80px">
        <el-form-item label="归还状态" prop="returnStatus">
          <el-radio-group v-model="returnForm.returnStatus">
            <el-radio
              v-for="dict in eq_return_status.slice(1)"
              :key="dict.value"
              :value="dict.value"
            >{{ dict.label }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="损坏备注" prop="damageRemark" v-if="returnForm.returnStatus === '2'">
          <el-input v-model="returnForm.damageRemark" type="textarea" placeholder="请描述设备损坏情况" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitReturn">确 定</el-button>
          <el-button @click="returnOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="ResOrder">
import { listResOrder, getResOrder, delResOrder, addResOrder, updateResOrder, approveOrder, rejectOrder, returnOrder } from "@/api/system/reserveOrder"

const { proxy } = getCurrentInstance()
const { res_order_status } = useDict('res_order_status')
const { eq_return_status } = useDict('eq_return_status')

const resOrderList = ref([])
const open = ref(false)
const rejectOpen = ref(false)
const returnOpen = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const currentRejectId = ref(null)
const currentReturnId = ref(null)

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    orderStatus: undefined,
    reserveTime: undefined,
    returnStatus: undefined
  },
  rules: {
    userId: [
      { required: true, message: "用户ID不能为空", trigger: "blur" }
    ],
    reserveTime: [
      { required: true, message: "预约时间不能为空", trigger: "blur" }
    ],
    orderStatus: [
      { required: true, message: "预约状态不能为空", trigger: "change" }
    ],
    equipmentId: [
      { required: true, message: "设备ID不能为空", trigger: "blur" }
    ]
  },
  rejectForm: {
    rejectReason: ''
  },
  rejectRules: {
    rejectReason: [
      { required: true, message: "拒绝原因不能为空", trigger: "blur" }
    ]
  },
  returnForm: {
    returnStatus: '1',
    damageRemark: ''
  },
  returnRules: {
    returnStatus: [
      { required: true, message: "归还状态不能为空", trigger: "change" }
    ]
  }
})

const { queryParams, form, rules, rejectForm, rejectRules, returnForm, returnRules } = toRefs(data)

/** 查询预约订单列表 */
function getList() {
  loading.value = true
  listResOrder(queryParams.value).then(response => {
    resOrderList.value = response.rows
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
    reserveTime: null,
    orderStatus: null,
    equipmentId: null,
    quantity: null,
    expectReturnTime: null,
    remark: null
  }
  proxy.resetForm("resOrderRef")
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
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
  title.value = "添加预约订单"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _orderId = row.orderId || ids.value
  getResOrder(_orderId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改预约订单"
  })
}

/** 审批通过 */
function handleApprove(row) {
  proxy.$modal.confirm('确认审批通过该订单？').then(function() {
    return approveOrder(row.orderId)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("审批通过")
  }).catch(() => {})
}

/** 拒绝 */
function handleReject(row) {
  currentRejectId.value = row.orderId
  rejectForm.value.rejectReason = ''
  rejectOpen.value = true
}

/** 提交拒绝 */
function submitReject() {
  proxy.$refs["rejectFormRef"].validate(valid => {
    if (valid) {
      rejectOrder(currentRejectId.value, rejectForm.value.rejectReason).then(() => {
        proxy.$modal.msgSuccess("已拒绝")
        rejectOpen.value = false
        getList()
      })
    }
  })
}

/** 归还 */
function handleReturn(row) {
  currentReturnId.value = row.orderId
  returnForm.value.returnStatus = '1'
  returnForm.value.damageRemark = ''
  returnOpen.value = true
}

/** 提交归还 */
function submitReturn() {
  proxy.$refs["returnFormRef"].validate(valid => {
    if (valid) {
      returnOrder(currentReturnId.value, returnForm.value.returnStatus, returnForm.value.damageRemark).then(() => {
        proxy.$modal.msgSuccess("归还成功")
        returnOpen.value = false
        getList()
      })
    }
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["resOrderRef"].validate(valid => {
    if (valid) {
      if (form.value.orderId != null) {
        updateResOrder(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addResOrder(form.value).then(() => {
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
  proxy.$modal.confirm('是否确认删除预约订单编号为"' + _orderIds + '"的数据项？').then(function() {
    return delResOrder(_orderIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/resOrder/export', {
    ...queryParams.value
  }, `resOrder_${new Date().getTime()}.xlsx`)
}

getList()
</script>