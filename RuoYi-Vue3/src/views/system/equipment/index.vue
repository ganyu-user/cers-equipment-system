<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="设备名称" prop="equipmentName">
        <el-input
          v-model="queryParams.equipmentName"
          placeholder="请输入设备名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="设备分类" prop="categoryId">
        <el-tree-select
          v-model="queryParams.categoryId"
          :data="categoryTreeOptions"
          :props="{ value: 'categoryId', label: 'categoryName', children: 'children' }"
          value-key="categoryId"
          placeholder="请选择设备分类"
          check-strictly
          clearable
          style="width: 200px"
        />
      </el-form-item>
      <el-form-item label="是否追踪" prop="trackUnit">
        <el-select v-model="queryParams.trackUnit" placeholder="请选择是否追踪" clearable>
          <el-option label="是" value="1" />
          <el-option label="否" value="0" />
        </el-select>
      </el-form-item>
      <el-form-item label="维修状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择维修状态" clearable>
          <el-option
            v-for="dict in eq_equipment_status"
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
          v-hasPermi="['system:equipment:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:equipment:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:equipment:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="info"
          plain
          icon="Operation"
          @click="handleUnitManage"
          v-hasPermi="['system:equipment:edit']"
        >单元管理</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['system:equipment:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="equipmentList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="设备ID" align="center" prop="equipmentId" />
      <el-table-column label="设备名称" align="center" prop="equipmentName" />
      <el-table-column label="分类名称" align="center" prop="categoryName" />
      <el-table-column label="设备图片" align="center" prop="image" width="100">
        <template #default="scope">
          <el-image v-if="scope.row.image" style="width: 50px; height: 50px" :src="scope.row.image" :preview-src-list="[scope.row.image]" fit="cover" />
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="设备总库存" align="center" prop="totalStock" />
      <el-table-column label="剩余可用数量" align="center" prop="remainStock" />
      <el-table-column label="是否追踪" align="center" prop="trackUnit">
        <template #default="scope">
          <el-tag v-if="scope.row.trackUnit === '1'" type="success">是</el-tag>
          <el-tag v-else type="info">否</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="编号前缀" align="center" prop="unitCodePrefix">
        <template #default="scope">
          <span>{{ scope.row.unitCodePrefix || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="维修状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="eq_equipment_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="存放地点" align="center" prop="location" />
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:equipment:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:equipment:remove']">删除</el-button>
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

    <!-- 添加或修改设备对话框 -->
    <el-dialog :title="title" v-model="open" width="550px" append-to-body>
      <el-form ref="equipmentRef" :model="form" :rules="rules" label-width="110px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="设备名称" prop="equipmentName">
              <el-input v-model="form.equipmentName" placeholder="请输入设备名称" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="设备分类" prop="categoryId">
              <el-tree-select
                v-model="form.categoryId"
                :data="categoryTreeOptions"
                :props="{ value: 'categoryId', label: 'categoryName', children: 'children' }"
                value-key="categoryId"
                placeholder="请选择设备分类"
                check-strictly
              />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="设备图片" prop="image">
              <image-upload v-model="form.image" action="/system/equipment/upload/image" :limit="1"/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="设备总库存" prop="totalStock">
              <el-input v-model="form.totalStock" placeholder="请输入设备总库存" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="是否追踪单台" prop="trackUnit">
              <el-radio-group v-model="form.trackUnit" @change="onTrackUnitChange">
                <el-radio label="1">是（追踪每台设备编号）</el-radio>
                <el-radio label="0">否（只管理总库存）</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24" v-if="form.trackUnit === '1'">
            <el-form-item label="编号前缀" prop="unitCodePrefix">
              <el-input v-model="form.unitCodePrefix" placeholder="用于生成编号，例如 示波器 则生成 示波器-001" />
              <div style="color: #999; font-size: 12px; margin-top: 4px">
                留空则默认使用设备名称作为前缀，生成格式：前缀-序号（如 示波器-001）
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="维修状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio
                  v-for="dict in eq_equipment_status"
                  :key="dict.value"
                  :label="dict.value"
                >{{ dict.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="存放地点" prop="location">
              <el-input v-model="form.location" placeholder="请输入存放地点" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="设备描述/备注" prop="description">
              <el-input v-model="form.description" type="textarea" placeholder="请输入内容" />
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

    <!-- 设备单元管理对话框 -->
    <el-dialog title="设备单元管理" v-model="unitOpen" width="950px" append-to-body @open="onUnitDialogOpen">
      <el-form :model="unitQueryParams" :inline="true" class="mb8">
        <el-form-item label="设备分类">
          <el-tree-select
            v-model="unitQueryParams.categoryId"
            :data="categoryTreeOptions"
            :props="{ value: 'categoryId', label: 'categoryName', children: 'children' }"
            value-key="categoryId"
            placeholder="选择设备分类"
            check-strictly
            clearable
            style="width: 180px"
          />
        </el-form-item>
        <el-form-item label="设备编号">
          <el-input v-model="unitQueryParams.unitCode" placeholder="输入单元编号" clearable @keyup.enter="getUnitList" />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="unitQueryParams.status" placeholder="选择状态" clearable>
            <el-option v-for="dict in eq_unit_status" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="getUnitList">搜索</el-button>
          <el-button @click="resetUnitQuery">重置</el-button>
          <el-button
            type="warning"
            :disabled="unitSelection.length === 0"
            @click="handleBatchUnitEdit"
          >批量修改</el-button>
        </el-form-item>
      </el-form>

      <el-table v-loading="unitLoading" :data="unitList" max-height="400" @selection-change="handleUnitSelectionChange">
        <el-table-column type="selection" width="55" />
        <el-table-column label="单元ID" prop="unitId" width="80" />
        <el-table-column label="设备ID" prop="equipmentId" width="80" />
        <el-table-column label="设备编号" prop="unitCode" width="140" />
        <el-table-column label="状态" align="center" width="80">
          <template #default="scope">
            <el-tag v-if="scope.row.status === '0'" type="success">在库</el-tag>
            <el-tag v-else-if="scope.row.status === '1'" type="warning">借出</el-tag>
            <el-tag v-else-if="scope.row.status === '2'" type="danger">维修</el-tag>
            <el-tag v-else-if="scope.row.status === '3'" type="info">报废</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="借用人" prop="borrowerName" width="100">
          <template #default="scope"><span>{{ scope.row.borrowerName || '-' }}</span></template>
        </el-table-column>
        <el-table-column label="借出时间" prop="borrowTime" width="160">
          <template #default="scope"><span>{{ scope.row.borrowTime || '-' }}</span></template>
        </el-table-column>
        <el-table-column label="归还状态" width="100">
          <template #default="scope">
            <dict-tag :options="eq_return_status" :value="scope.row.returnStatus" />
          </template>
        </el-table-column>
        <el-table-column label="损坏备注" prop="damageRemark" min-width="140" show-overflow-tooltip />
        <el-table-column label="操作" width="100" fixed="right">
          <template #default="scope">
            <el-button link type="primary" icon="Edit" @click="handleUnitEdit(scope.row)">修改</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="unitTotal > 0"
        :total="unitTotal"
        v-model:page="unitQueryParams.pageNum"
        v-model:limit="unitQueryParams.pageSize"
        @pagination="getUnitList"
      />
    </el-dialog>

    <!-- 修改设备单元状态对话框 -->
    <el-dialog title="修改设备单元" v-model="unitEditOpen" width="450px" append-to-body>
      <el-form ref="unitEditFormRef" :model="unitEditForm" :rules="unitEditRules" label-width="80px">
        <el-form-item label="设备编号">
          <el-input :model-value="unitEditForm.unitCode" disabled />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="unitEditForm.status">
            <el-radio label="0">在库</el-radio>
            <el-radio label="2">维修</el-radio>
            <el-radio label="3">报废</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="归还状态" prop="returnStatus">
          <el-radio-group v-model="unitEditForm.returnStatus">
            <el-radio
              v-for="dict in eq_return_status"
              :key="dict.value"
              :value="dict.value"
            >{{ dict.label }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="损坏备注" prop="damageRemark">
          <el-input v-model="unitEditForm.damageRemark" type="textarea" placeholder="损坏/维修说明" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" @click="submitUnitEdit">确 定</el-button>
        <el-button @click="unitEditOpen = false">取 消</el-button>
      </template>
    </el-dialog>

    <!-- 批量修改设备单元对话框 -->
    <el-dialog title="批量修改设备单元" v-model="batchUnitEditOpen" width="450px" append-to-body>
      <el-alert type="info" :closable="false" style="margin-bottom: 16px">
        已选择 <b>{{ unitSelection.length }}</b> 个设备单元，将应用相同修改。
      </el-alert>
      <el-form ref="batchUnitEditFormRef" :model="batchUnitEditForm" :rules="batchUnitEditRules" label-width="80px">
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="batchUnitEditForm.status">
            <el-radio label="">不变更</el-radio>
            <el-radio label="0">在库</el-radio>
            <el-radio label="2">维修</el-radio>
            <el-radio label="3">报废</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="归还状态" prop="returnStatus">
          <el-radio-group v-model="batchUnitEditForm.returnStatus">
            <el-radio label="">不变更</el-radio>
            <el-radio
              v-for="dict in eq_return_status"
              :key="dict.value"
              :value="dict.value"
            >{{ dict.label }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="损坏备注" prop="damageRemark">
          <el-input v-model="batchUnitEditForm.damageRemark" type="textarea" placeholder="留空表示不修改" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" @click="submitBatchUnitEdit">确 定</el-button>
        <el-button @click="batchUnitEditOpen = false">取 消</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Equipment">
import { listEquipment, getEquipment, delEquipment, addEquipment, updateEquipment, getCategoryTree } from "@/api/system/equipment"
import { listEquipmentUnit, updateEquipmentUnit, batchUpdateEquipmentUnit } from "@/api/system/equipmentUnit"

const { proxy } = getCurrentInstance()
const { eq_equipment_status } = useDict('eq_equipment_status')
const { eq_unit_status } = useDict('eq_unit_status')
const { eq_return_status } = useDict('eq_return_status')

const equipmentList = ref([])
const categoryTreeOptions = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const unitOpen = ref(false)
const unitEditOpen = ref(false)
const unitLoading = ref(false)
const unitList = ref([])
const unitTotal = ref(0)
const unitQueryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  categoryId: undefined,
  unitCode: undefined,
  status: undefined
})
const unitEditForm = reactive({
  unitId: null,
  unitCode: '',
  status: '0',
  returnStatus: '0',
  damageRemark: ''
})
const unitEditRules = {
  status: [{ required: true, message: '状态不能为空', trigger: 'change' }]
}

const unitSelection = ref([])
const batchUnitEditOpen = ref(false)
const batchUnitEditForm = reactive({
  status: '',
  returnStatus: '',
  damageRemark: ''
})
const batchUnitEditRules = {}

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    equipmentName: undefined,
    categoryId: undefined,
    trackUnit: undefined,
    status: undefined,
  },
  rules: {
    equipmentName: [
      { required: true, message: "设备名称不能为空", trigger: "blur" }
    ],
    categoryId: [
      { required: true, message: "分类ID不能为空", trigger: "change" }
    ],
    totalStock: [
      { required: true, message: "设备总库存不能为空", trigger: "blur" }
    ],
    trackUnit: [
      { required: true, message: "是否追踪单台不能为空", trigger: "change" }
    ],
    status: [
      { required: true, message: "维修状态不能为空", trigger: "change" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

function onTrackUnitChange(val) {
  if (val !== '1') {
    form.value.unitCodePrefix = null
  }
}

/** 查询设备列表 */
function getList() {
  loading.value = true
  listEquipment(queryParams.value).then(response => {
    equipmentList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

/** 获取分类树 */
function getTreeselect() {
  getCategoryTree().then(response => {
    categoryTreeOptions.value = response.data
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
    equipmentId: null,
    equipmentName: null,
    categoryId: null,
    image: null,
    totalStock: null,
    remainStock: null,
    trackUnit: '0',
    unitCodePrefix: null,
    status: null,
    location: null,
    description: null,
    delFlag: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null,
    remark: null
  }
  proxy.resetForm("equipmentRef")
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
  ids.value = selection.map(item => item.equipmentId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  getTreeselect()
  open.value = true
  title.value = "添加设备"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  getTreeselect()
  const _equipmentId = row.equipmentId || ids.value
  getEquipment(_equipmentId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改设备"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["equipmentRef"].validate(valid => {
    if (valid) {
      if (form.value.equipmentId != null) {
        updateEquipment(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addEquipment(form.value).then(() => {
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
  const _equipmentIds = row.equipmentId || ids.value
  proxy.$modal.confirm('是否确认删除设备编号为"' + _equipmentIds + '"的数据项？').then(function() {
    return delEquipment(_equipmentIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/equipment/export', {
    ...queryParams.value
  }, `equipment_${new Date().getTime()}.xlsx`)
}

/** 单元管理 */
function handleUnitManage() {
  unitQueryParams.categoryId = undefined
  unitQueryParams.unitCode = undefined
  unitQueryParams.status = undefined
  unitQueryParams.pageNum = 1
  unitOpen.value = true
}

function onUnitDialogOpen() {
  getTreeselect()
  getUnitList()
}

function getUnitList() {
  unitLoading.value = true
  listEquipmentUnit(unitQueryParams).then(response => {
    unitList.value = response.rows
    unitTotal.value = response.total
    unitLoading.value = false
  })
}

function resetUnitQuery() {
  unitQueryParams.categoryId = undefined
  unitQueryParams.unitCode = undefined
  unitQueryParams.status = undefined
  unitQueryParams.pageNum = 1
  getUnitList()
}

function handleUnitSelectionChange(selection) {
  unitSelection.value = selection
}

function handleBatchUnitEdit() {
  batchUnitEditForm.status = ''
  batchUnitEditForm.returnStatus = ''
  batchUnitEditForm.damageRemark = ''
  batchUnitEditOpen.value = true
}

function submitBatchUnitEdit() {
  const unitIds = unitSelection.value.map(item => item.unitId)
  const payload = { unitIds }
  if (batchUnitEditForm.status) payload.status = batchUnitEditForm.status
  if (batchUnitEditForm.returnStatus) payload.returnStatus = batchUnitEditForm.returnStatus
  if (batchUnitEditForm.damageRemark) payload.damageRemark = batchUnitEditForm.damageRemark

  batchUpdateEquipmentUnit(payload).then(() => {
    proxy.$modal.msgSuccess('批量修改成功')
    batchUnitEditOpen.value = false
    getUnitList()
  })
}

function handleUnitEdit(row) {
  unitEditForm.unitId = row.unitId
  unitEditForm.unitCode = row.unitCode
  unitEditForm.status = row.status
  unitEditForm.returnStatus = row.returnStatus || '0'
  unitEditForm.damageRemark = row.damageRemark || ''
  unitEditOpen.value = true
}

function submitUnitEdit() {
  proxy.$refs['unitEditFormRef'].validate(valid => {
    if (valid) {
      updateEquipmentUnit({
        unitId: unitEditForm.unitId,
        status: unitEditForm.status,
        returnStatus: unitEditForm.returnStatus,
        damageRemark: unitEditForm.damageRemark || null
      }).then(() => {
        proxy.$modal.msgSuccess('修改成功')
        unitEditOpen.value = false
        getUnitList()
      })
    }
  })
}

getTreeselect()
getList()
</script>