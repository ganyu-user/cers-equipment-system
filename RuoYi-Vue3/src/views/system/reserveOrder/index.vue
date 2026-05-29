<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="预约状态" prop="orderStatus">
        <el-select v-model="queryParams.orderStatus" placeholder="请选择预约状态" clearable>
          <el-option v-for="dict in res_order_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="预约时间" prop="reserveTime">
        <el-date-picker v-model="queryParams.reserveTime" type="date" placeholder="选择预约时间" value-format="YYYY-MM-DD" clearable />
      </el-form-item>
      <el-form-item label="归还状态" prop="returnStatus">
        <el-select v-model="queryParams.returnStatus" placeholder="请选择归还状态" clearable>
          <el-option v-for="dict in eq_return_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['system:resOrder:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['system:resOrder:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:resOrder:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['system:resOrder:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="resOrderList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="订单号" align="center" prop="orderNo" width="180">
        <template #default="scope"><span>{{ scope.row.orderNo || scope.row.orderId }}</span></template>
      </el-table-column>
      <el-table-column label="预约人" align="center" prop="realName" width="100">
        <template #default="scope"><span>{{ scope.row.realName || '-' }}</span></template>
      </el-table-column>
      <el-table-column label="设备名称" align="center" prop="equipmentName" min-width="140" show-overflow-tooltip />
      <el-table-column label="预约数量" align="center" prop="quantity" width="80" />
      <el-table-column label="预约状态" align="center" prop="orderStatus" width="110">
        <template #default="scope">
          <dict-tag :options="res_order_status" :value="scope.row.orderStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="归还状态" align="center" prop="returnStatus" width="100">
        <template #default="scope">
          <dict-tag :options="eq_return_status" :value="scope.row.returnStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="预约时间" align="center" prop="reserveTime" width="160" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="280">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleDetail(scope.row)">详情</el-button>
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:resOrder:edit']">修改</el-button>
          <el-button link type="success" icon="CircleCheck" @click="handleApprove(scope.row)" v-if="scope.row.orderStatus === '0'" v-hasPermi="['system:resOrder:approve']">通过</el-button>
          <el-button link type="danger" icon="CircleClose" @click="handleReject(scope.row)" v-if="scope.row.orderStatus === '0'" v-hasPermi="['system:resOrder:approve']">拒绝</el-button>
          <el-button link type="warning" icon="RefreshRight" @click="handleVerifyReturn(scope.row)" v-if="scope.row.orderStatus === '6'" v-hasPermi="['system:resOrder:return']">核验归还</el-button>
          <el-button link type="danger" icon="AlarmClock" @click="handleUrgeReturn(scope.row)" v-if="canUrge(scope.row)" v-hasPermi="['system:resOrder:edit']">催还</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:resOrder:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <!-- 添加或修改对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="resOrderRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24"><el-form-item label="用户ID" prop="userId"><el-input v-model="form.userId" placeholder="请输入用户ID" /></el-form-item></el-col>
          <el-col :span="24"><el-form-item label="预约时间" prop="reserveTime"><el-date-picker v-model="form.reserveTime" type="date" placeholder="选择预约时间" value-format="YYYY-MM-DD" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="24"><el-form-item label="预约状态" prop="orderStatus"><el-radio-group v-model="form.orderStatus"><el-radio v-for="dict in res_order_status" :key="dict.value" :value="dict.value">{{ dict.label }}</el-radio></el-radio-group></el-form-item></el-col>
          <el-col :span="24"><el-form-item label="设备ID" prop="equipmentId"><el-input v-model="form.equipmentId" placeholder="请输入设备ID" /></el-form-item></el-col>
          <el-col :span="24"><el-form-item label="预约数量" prop="quantity"><el-input v-model="form.quantity" placeholder="请输入预约数量" /></el-form-item></el-col>
          <el-col :span="24"><el-form-item label="预计归还时间" prop="expectReturnTime"><el-date-picker v-model="form.expectReturnTime" type="date" placeholder="选择预计归还时间" value-format="YYYY-MM-DD" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="24"><el-form-item label="备注" prop="remark"><el-input v-model="form.remark" type="textarea" placeholder="请输入内容" /></el-form-item></el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 详情对话框 -->
    <el-dialog title="预约单详情" v-model="detailOpen" width="700px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="订单编号">{{ detailForm.orderNo || detailForm.orderId }}</el-descriptions-item>
        <el-descriptions-item label="预约状态">
          <dict-tag :options="res_order_status" :value="detailForm.orderStatus"/>
        </el-descriptions-item>
        <el-descriptions-item label="用户账号">{{ detailForm.loginName || detailForm.userName }}</el-descriptions-item>
        <el-descriptions-item label="用户名称">{{ detailForm.userName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="真实姓名">{{ detailForm.realName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="学号">{{ detailForm.studentNo || '-' }}</el-descriptions-item>
        <el-descriptions-item label="年级和班级">{{ detailForm.grade || '-' }}</el-descriptions-item>
        <el-descriptions-item label="专业">{{ detailForm.major || '-' }}</el-descriptions-item>
        <el-descriptions-item label="手机号">{{ detailForm.phone || '-' }}</el-descriptions-item>
        <el-descriptions-item label="设备名称">{{ detailForm.equipmentName }}</el-descriptions-item>
        <el-descriptions-item label="" v-if="detailForm.equipmentImage">
          <el-image style="width: 80px; height: 80px" :src="detailForm.equipmentImage" :preview-src-list="[detailForm.equipmentImage]" fit="cover" />
        </el-descriptions-item>
        <el-descriptions-item label="预约数量">{{ detailForm.quantity }}</el-descriptions-item>
        <el-descriptions-item label="预约时间">{{ detailForm.reserveTime }}</el-descriptions-item>
        <el-descriptions-item label="预计归还时间">{{ detailForm.expectReturnTime }}</el-descriptions-item>
        <el-descriptions-item label="实际归还时间" v-if="detailForm.actualReturnTime">{{ detailForm.actualReturnTime }}</el-descriptions-item>
        <el-descriptions-item label="归还状态">
          <dict-tag :options="eq_return_status" :value="detailForm.returnStatus"/>
        </el-descriptions-item>
        <el-descriptions-item label="损坏数量" :span="2" v-if="damageInfo && damageInfo.type === 'non_tracked'">{{ damageInfo.count }} 台</el-descriptions-item>
        <el-descriptions-item label="损坏设备编号" :span="2" v-if="damageInfo && damageInfo.type === 'tracked'">{{ damageInfo.codes }} （共{{ damageInfo.count }}台）</el-descriptions-item>
        <el-descriptions-item label="分配设备编号" :span="2" v-if="detailForm.assignedUnitCodes">{{ detailForm.assignedUnitCodes }}</el-descriptions-item>
        <el-descriptions-item label="审批人" v-if="detailForm.approverName">{{ detailForm.approverName }}</el-descriptions-item>
        <el-descriptions-item label="审批时间" v-if="detailForm.approveTime">{{ detailForm.approveTime }}</el-descriptions-item>
        <el-descriptions-item label="拒绝原因" :span="2" v-if="detailForm.rejectReason">{{ detailForm.rejectReason }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2" v-if="detailForm.remark">{{ detailForm.remark }}</el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="detailOpen = false">关 闭</el-button>
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

    <!-- 归还核验对话框 -->
    <el-dialog title="归还核验" v-model="verifyOpen" width="750px" append-to-body :close-on-click-modal="false">
      <div v-if="verifyOrderData">
        <el-descriptions :column="2" border size="small" style="margin-bottom: 16px">
          <el-descriptions-item label="订单编号">{{ verifyOrderData.orderNo || verifyOrderData.orderId }}</el-descriptions-item>
          <el-descriptions-item label="预约人">{{ verifyOrderData.realName || verifyOrderData.userName }}</el-descriptions-item>
          <el-descriptions-item label="设备名称">{{ verifyOrderData.equipmentName }}</el-descriptions-item>
          <el-descriptions-item label="预约数量">{{ verifyOrderData.quantity }}</el-descriptions-item>
          <el-descriptions-item label="已归还数量" :span="2">{{ verifiedCount }} / {{ verifyOrderData.quantity }}</el-descriptions-item>
        </el-descriptions>

        <!-- 不可追踪设备核验区 -->
        <div v-if="verifyOrderData.trackUnit !== '1'">
          <el-divider content-position="left">不可追踪设备核验</el-divider>
          <el-form ref="nonTrackVerifyRef" :model="nonTrackForm" :rules="nonTrackRules" label-width="100px">
            <el-form-item label="正常归还数量" prop="returnQuantity">
              <el-input-number v-model="nonTrackForm.returnQuantity" :min="0" :max="maxReturnQty" controls-position="right" style="width: 200px" />
              <span style="margin-left: 8px; color: #909399">默认值 = 预约数量 - 已归还数量 = {{ maxReturnQty }}</span>
            </el-form-item>
            <el-form-item label="损坏数量" prop="damageQuantity">
              <el-input-number v-model="nonTrackForm.damageQuantity" :min="0" :max="maxReturnQty - nonTrackForm.returnQuantity" controls-position="right" style="width: 200px" />
            </el-form-item>
            <el-form-item label="损坏备注" prop="damageRemark" v-if="nonTrackForm.damageQuantity > 0">
              <el-input v-model="nonTrackForm.damageRemark" type="textarea" placeholder="请输入损坏备注" maxlength="500" show-word-limit />
            </el-form-item>
          </el-form>
          <div style="text-align: center; margin-top: 16px">
            <el-button type="primary" @click="submitNonTrackVerify">确认归还</el-button>
          </div>
        </div>

        <!-- 可追踪设备核验区 -->
        <div v-else>
          <el-divider content-position="left">可追踪设备核验</el-divider>
          <div style="margin-bottom: 12px">
            <el-button size="small" @click="selectAllUnits">全选</el-button>
            <el-button size="small" @click="invertSelectUnits">反选</el-button>
            <el-button size="small" type="success" :disabled="selectedUnitCodes.length === 0" @click="batchNormalReturn">批量正常归还</el-button>
          </div>
          <el-table ref="unitTableRef" :data="unitList" style="width: 100%" row-key="unitId">
            <el-table-column type="selection" width="45" @selection-change="onUnitSelectionChange" />
            <el-table-column label="设备编号" prop="unitCode" width="150" />
            <el-table-column label="当前状态" width="80">
              <template #default="scope">
                <dict-tag :options="eq_unit_status" :value="scope.row.status"/>
              </template>
            </el-table-column>
            <el-table-column label="归还状态" width="100">
              <template #default="scope">
                <dict-tag :options="eq_return_status" :value="scope.row.returnStatus"/>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="200">
              <template #default="scope">
                <template v-if="scope.row.returnStatus === '1'">
                  <el-button link type="success" size="small" @click="unitNormalReturn(scope.row)">正常归还</el-button>
                  <el-button link type="danger" size="small" @click="unitDamageReturn(scope.row)">损坏归还</el-button>
                </template>
                <span v-else style="color: #909399">已核验</span>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </div>

      <!-- 损坏归还备注对话框 -->
      <el-dialog title="损坏归还备注" v-model="damageRemarkOpen" width="400px" append-to-body>
        <el-form ref="damageRemarkRef" :model="damageRemarkForm" :rules="damageRemarkRules" label-width="80px">
          <el-form-item label="损坏备注" prop="damageRemark">
            <el-input v-model="damageRemarkForm.damageRemark" type="textarea" placeholder="请输入损坏备注" maxlength="500" show-word-limit />
          </el-form-item>
        </el-form>
        <template #footer>
          <div class="dialog-footer">
            <el-button type="primary" @click="submitDamageRemark">确 定</el-button>
            <el-button @click="damageRemarkOpen = false">取 消</el-button>
          </div>
        </template>
      </el-dialog>

      <template #footer>
        <div class="dialog-footer">
          <el-button @click="verifyOpen = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="ResOrder">
import { listResOrder, getResOrder, delResOrder, addResOrder, updateResOrder, approveOrder, rejectOrder, verifyReturn, getReturnDetail, urgeReturn } from "@/api/system/reserveOrder"
import { listEquipmentUnit } from "@/api/system/equipmentUnit"

const { proxy } = getCurrentInstance()
const { res_order_status } = useDict('res_order_status')
const { eq_return_status } = useDict('eq_return_status')
const { eq_unit_status } = useDict('eq_unit_status')

const resOrderList = ref([])
const open = ref(false)
const detailOpen = ref(false)
const rejectOpen = ref(false)
const verifyOpen = ref(false)
const damageRemarkOpen = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const currentRejectId = ref(null)
const verifyOrderData = ref(null)
const unitList = ref([])
const unitTableRef = ref(null)
const selectedUnitCodes = ref([])
const currentDamageUnit = ref(null)
const verifiedCount = ref(0)
const damageInfo = ref(null)

const data = reactive({
  form: {},
  detailForm: {},
  queryParams: { pageNum: 1, pageSize: 10, orderStatus: undefined, reserveTime: undefined, returnStatus: undefined },
  rules: {
    userId: [{ required: true, message: "用户ID不能为空", trigger: "blur" }],
    reserveTime: [{ required: true, message: "预约时间不能为空", trigger: "blur" }],
    orderStatus: [{ required: true, message: "预约状态不能为空", trigger: "change" }],
    equipmentId: [{ required: true, message: "设备ID不能为空", trigger: "blur" }],
    expectReturnTime: [{ required: true, message: "预计归还时间不能为空", trigger: "blur" }]
  },
  rejectForm: { rejectReason: '' },
  rejectRules: { rejectReason: [{ required: true, message: "拒绝原因不能为空", trigger: "blur" }] },
  nonTrackForm: { returnQuantity: 0, damageQuantity: 0, damageRemark: '' },
  nonTrackRules: {},
  damageRemarkForm: { damageRemark: '' },
  damageRemarkRules: { damageRemark: [{ required: true, message: "损坏备注不能为空", trigger: "blur" }] }
})

const { queryParams, form, rules, detailForm, rejectForm, rejectRules, nonTrackForm, nonTrackRules, damageRemarkForm, damageRemarkRules } = toRefs(data)

const maxReturnQty = computed(() => {
  if (verifyOrderData.value) {
    return Math.max(0, (verifyOrderData.value.quantity || 0) - verifiedCount.value)
  }
  return 0
})

function getList() {
  loading.value = true
  listResOrder(queryParams.value).then(response => {
    resOrderList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function cancel() { open.value = false; reset() }

function reset() {
  form.value = { orderId: null, userId: null, reserveTime: null, orderStatus: null, equipmentId: null, quantity: null, expectReturnTime: null, remark: null }
  proxy.resetForm("resOrderRef")
}

function handleQuery() { queryParams.value.pageNum = 1; getList() }

function resetQuery() { proxy.resetForm("queryRef"); handleQuery() }

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.orderId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

function handleAdd() { reset(); open.value = true; title.value = "添加预约订单" }

function handleUpdate(row) {
  reset()
  const _orderId = row.orderId || ids.value
  getResOrder(_orderId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改预约订单"
  })
}

function handleDetail(row) {
  getResOrder(row.orderId).then(response => {
    detailForm.value = response.data
    detailOpen.value = true
    damageInfo.value = null
    if (detailForm.value.returnStatus === '3') {
      getReturnDetail(row.orderId).then(detailResponse => {
        const details = detailResponse.data || []
        if (detailForm.value.trackUnit === '1') {
          const damagedUnits = details.filter(d => d.returnStatus === '3')
          if (damagedUnits.length > 0) {
            damageInfo.value = { type: 'tracked', count: damagedUnits.length, codes: damagedUnits.map(d => d.unitCode).join('、') }
          }
        } else {
          let totalDamage = 0
          details.forEach(d => { totalDamage += (d.damageQuantity || 0) })
          if (totalDamage > 0) {
            damageInfo.value = { type: 'non_tracked', count: totalDamage, codes: '' }
          }
        }
      }).catch(() => {})
    }
  })
}

function handleApprove(row) {
  proxy.$modal.confirm('确认审批通过该订单？').then(function() {
    return approveOrder(row.orderId)
  }).then(() => { getList(); proxy.$modal.msgSuccess("审批通过") }).catch(() => {})
}

function handleReject(row) {
  currentRejectId.value = row.orderId
  rejectForm.value.rejectReason = ''
  rejectOpen.value = true
}

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

function handleVerifyReturn(row) {
  getResOrder(row.orderId).then(response => {
    verifyOrderData.value = response.data
    verifyOpen.value = true
    nonTrackForm.value.returnQuantity = 0
    nonTrackForm.value.damageQuantity = 0
    nonTrackForm.value.damageRemark = ''
    selectedUnitCodes.value = []

    getReturnDetail(row.orderId).then(detailResponse => {
      const details = detailResponse.data
      if (verifyOrderData.value.trackUnit === '1') {
        verifiedCount.value = details.length
      } else {
        let count = 0
        details.forEach(d => {
          count += (d.returnQuantity || 0) + (d.damageQuantity || 0)
        })
        verifiedCount.value = count
      }
      nonTrackForm.value.returnQuantity = maxReturnQty.value
    }).catch(() => {
      verifiedCount.value = 0
      nonTrackForm.value.returnQuantity = maxReturnQty.value
    })

    if (verifyOrderData.value.trackUnit === '1' && verifyOrderData.value.assignedUnitCodes) {
      listEquipmentUnit({ equipmentId: verifyOrderData.value.equipmentId, pageSize: 9999 }).then(unitResponse => {
        const allUnits = unitResponse.rows || []
        const assignedCodes = verifyOrderData.value.assignedUnitCodes.split(',').map(c => c.trim())
        unitList.value = allUnits.filter(u => assignedCodes.includes(u.unitCode))
      })
    }
  })
}

function onUnitSelectionChange(selection) {
  selectedUnitCodes.value = selection.map(u => u.unitCode)
}

function selectAllUnits() {
  const table = unitTableRef.value
  if (!table) return
  const pending = unitList.value.filter(u => u.returnStatus === '1')
  pending.forEach(u => table.toggleRowSelection(u, true))
  selectedUnitCodes.value = pending.map(u => u.unitCode)
}

function invertSelectUnits() {
  const table = unitTableRef.value
  if (!table) return
  const current = new Set(selectedUnitCodes.value)
  const pending = unitList.value.filter(u => u.returnStatus === '1')
  pending.forEach(u => {
    if (current.has(u.unitCode)) {
      table.toggleRowSelection(u, false)
    } else {
      table.toggleRowSelection(u, true)
    }
  })
  selectedUnitCodes.value = pending.filter(u => !current.has(u.unitCode)).map(u => u.unitCode)
}

function unitNormalReturn(row) {
  const details = [{ unitCode: row.unitCode, returnStatus: '2', damageRemark: '' }]
  submitVerifyDetails(details)
}

function unitDamageReturn(row) {
  currentDamageUnit.value = row
  damageRemarkForm.value.damageRemark = ''
  damageRemarkOpen.value = true
}

function submitDamageRemark() {
  proxy.$refs["damageRemarkRef"].validate(valid => {
    if (valid) {
      damageRemarkOpen.value = false
      const details = [{ unitCode: currentDamageUnit.value.unitCode, returnStatus: '3', damageRemark: damageRemarkForm.value.damageRemark }]
      submitVerifyDetails(details)
    }
  })
}

function batchNormalReturn() {
  const details = selectedUnitCodes.value.map(code => ({ unitCode: code, returnStatus: '2', damageRemark: '' }))
  submitVerifyDetails(details)
}

function submitNonTrackVerify() {
  if (nonTrackForm.value.returnQuantity + nonTrackForm.value.damageQuantity > maxReturnQty.value) {
    proxy.$modal.msgError("归还数量超过预约数量")
    return
  }
  if (nonTrackForm.value.damageQuantity > 0 && !nonTrackForm.value.damageRemark) {
    proxy.$modal.msgError("损坏数量大于0时，损坏备注不能为空")
    return
  }
  const details = [{
    returnQuantity: nonTrackForm.value.returnQuantity,
    damageQuantity: nonTrackForm.value.damageQuantity,
    damageRemark: nonTrackForm.value.damageRemark
  }]
  submitVerifyDetails(details)
}

function submitVerifyDetails(details) {
  verifyReturn(verifyOrderData.value.orderId, details).then(() => {
    proxy.$modal.msgSuccess("核验成功")
    getList()
    handleVerifyReturn({ orderId: verifyOrderData.value.orderId })
  })
}

function submitForm() {
  proxy.$refs["resOrderRef"].validate(valid => {
    if (valid) {
      if (form.value.orderId != null) {
        updateResOrder(form.value).then(() => { proxy.$modal.msgSuccess("修改成功"); open.value = false; getList() })
      } else {
        addResOrder(form.value).then(() => { proxy.$modal.msgSuccess("新增成功"); open.value = false; getList() })
      }
    }
  })
}

function handleDelete(row) {
  const _orderIds = row.orderId || ids.value
  proxy.$modal.confirm('是否确认删除预约订单编号为"' + _orderIds + '"的数据项？').then(function() {
    return delResOrder(_orderIds)
  }).then(() => { getList(); proxy.$modal.msgSuccess("删除成功") }).catch(() => {})
}

function handleExport() {
  proxy.download('system/resOrder/export', { ...queryParams.value }, `resOrder_${new Date().getTime()}.xlsx`)
}

function handleUrgeReturn(row) {
  proxy.$modal.confirm('确认向该用户发送催还通知？').then(function() {
    return urgeReturn(row.orderId)
  }).then(() => { proxy.$modal.msgSuccess("催还消息已发送") }).catch(() => {})
}

function canUrge(row) {
  if (row.orderStatus === '4') return true
  if (row.orderStatus === '1' && row.expectReturnTime) {
    const now = new Date()
    const expectReturn = new Date(row.expectReturnTime)
    return now > expectReturn
  }
  return false
}

getList()
</script>
