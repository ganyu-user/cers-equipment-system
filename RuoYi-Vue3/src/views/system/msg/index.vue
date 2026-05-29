<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="消息标题" prop="title">
        <el-input v-model="queryParams.title" placeholder="请输入消息标题" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="消息类型" prop="msgType">
        <el-select v-model="queryParams.msgType" placeholder="请选择消息类型" clearable style="width: 200px">
          <el-option v-for="dict in sys_msg_type" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['system:msg:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['system:msg:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:msg:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="msgList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="消息ID" align="center" prop="msgId" width="80" />
      <el-table-column label="消息标题" align="center" prop="title" min-width="200" show-overflow-tooltip>
        <template #default="scope">
          <el-link type="primary" @click="handleView(scope.row)">{{ scope.row.title }}</el-link>
        </template>
      </el-table-column>
      <el-table-column label="消息类型" align="center" prop="msgType" width="100">
        <template #default="scope">
          <dict-tag :options="sys_msg_type" :value="scope.row.msgType" />
        </template>
      </el-table-column>
      <el-table-column label="发送者" align="center" prop="senderName" width="100" />
      <el-table-column label="优先级" align="center" prop="priority" width="80">
        <template #default="scope">
          <el-tag v-if="scope.row.priority === 'urgent'" type="danger">紧急</el-tag>
          <el-tag v-else-if="scope.row.priority === 'normal'" type="primary">普通</el-tag>
          <el-tag v-else type="info">低</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="发送范围" align="center" prop="targetType" width="100">
        <template #default="scope">
          <span v-if="scope.row.targetType === 'all'">全部用户</span>
          <span v-else-if="scope.row.targetType === 'user'">指定用户</span>
          <span v-else>指定角色</span>
        </template>
      </el-table-column>
      <el-table-column label="接收人" align="center" prop="targetUserName" min-width="120" show-overflow-tooltip />
      <el-table-column label="创建时间" align="center" prop="createTime" width="160" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="160">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看</el-button>
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:msg:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:msg:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="650px" append-to-body>
      <el-form ref="msgRef" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="消息类型" prop="msgType">
              <el-select v-model="form.msgType" placeholder="请选择消息类型">
                <el-option v-for="dict in sys_msg_type" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="消息标题" prop="title">
              <el-input v-model="form.title" placeholder="请输入消息标题" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="优先级" prop="priority">
              <el-radio-group v-model="form.priority">
                <el-radio label="urgent">紧急</el-radio>
                <el-radio label="normal">普通</el-radio>
                <el-radio label="low">低</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="发送范围" prop="targetType">
              <el-radio-group v-model="form.targetType">
                <el-radio label="all">全部用户</el-radio>
                <el-radio label="user">指定用户</el-radio>
                <el-radio label="role">指定角色</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24" v-if="form.targetType === 'user'">
            <el-form-item label="用户ID" prop="targetId">
              <el-input v-model="form.targetId" placeholder="多个用户ID用逗号分隔" />
            </el-form-item>
          </el-col>
          <el-col :span="24" v-if="form.targetType === 'role'">
            <el-form-item label="目标角色" prop="targetRole">
              <el-input v-model="form.targetRole" placeholder="请输入角色标识，如 common" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="消息内容" prop="content">
              <el-input v-model="form.content" type="textarea" :rows="5" placeholder="请输入消息内容" />
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

    <el-dialog title="消息详情" v-model="viewOpen" width="600px" append-to-body>
      <el-descriptions :column="1" border>
        <el-descriptions-item label="消息ID">{{ viewForm.msgId }}</el-descriptions-item>
        <el-descriptions-item label="消息类型">
          <dict-tag :options="sys_msg_type" :value="viewForm.msgType" />
        </el-descriptions-item>
        <el-descriptions-item label="消息标题">{{ viewForm.title }}</el-descriptions-item>
        <el-descriptions-item label="优先级">
          <el-tag v-if="viewForm.priority === 'urgent'" type="danger">紧急</el-tag>
          <el-tag v-else-if="viewForm.priority === 'normal'" type="primary">普通</el-tag>
          <el-tag v-else type="info">低</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="发送者">{{ viewForm.senderName }}</el-descriptions-item>
        <el-descriptions-item label="发送范围">
          <span v-if="viewForm.targetType === 'all'">全部用户</span>
          <span v-else-if="viewForm.targetType === 'user'">指定用户（ID: {{ viewForm.targetId }}）</span>
          <span v-else>指定角色（{{ viewForm.targetRole }}）</span>
        </el-descriptions-item>
        <el-descriptions-item label="接收人">{{ viewForm.targetUserName || viewForm.targetId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="消息内容">{{ viewForm.content }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ viewForm.createTime }}</el-descriptions-item>
        <el-descriptions-item label="备注" v-if="viewForm.remark">{{ viewForm.remark }}</el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="viewOpen = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Msg">
import { listMsg, getMsg, addMsg, updateMsg, delMsg } from "@/api/system/msg"

const { proxy } = getCurrentInstance()
const { sys_msg_type } = useDict('sys_msg_type')

const msgList = ref([])
const open = ref(false)
const viewOpen = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {},
  viewForm: {},
  queryParams: { pageNum: 1, pageSize: 10, title: undefined, msgType: undefined },
  rules: {
    title: [{ required: true, message: "消息标题不能为空", trigger: "blur" }],
    content: [{ required: true, message: "消息内容不能为空", trigger: "blur" }],
    msgType: [{ required: true, message: "消息类型不能为空", trigger: "change" }],
    targetType: [{ required: true, message: "发送范围不能为空", trigger: "change" }],
  }
})

const { queryParams, form, rules, viewForm } = toRefs(data)

function getList() {
  loading.value = true
  listMsg(queryParams.value).then(response => {
    msgList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function cancel() { open.value = false; reset() }

function reset() {
  form.value = { msgId: null, msgType: undefined, title: undefined, content: undefined, priority: 'normal', targetType: 'all', targetId: undefined, targetRole: undefined, remark: undefined }
  proxy.resetForm("msgRef")
}

function handleQuery() { queryParams.value.pageNum = 1; getList() }

function resetQuery() { proxy.resetForm("queryRef"); handleQuery() }

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.msgId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

function handleAdd() { reset(); open.value = true; title.value = "新增消息" }

function handleUpdate(row) {
  reset()
  const msgId = row.msgId || ids.value
  getMsg(msgId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改消息"
  })
}

function handleView(row) {
  getMsg(row.msgId).then(response => {
    viewForm.value = response.data
    viewOpen.value = true
  })
}

function submitForm() {
  proxy.$refs["msgRef"].validate(valid => {
    if (valid) {
      if (form.value.msgId != null) {
        updateMsg(form.value).then(() => { proxy.$modal.msgSuccess("修改成功"); open.value = false; getList() })
      } else {
        addMsg(form.value).then(() => { proxy.$modal.msgSuccess("新增成功"); open.value = false; getList() })
      }
    }
  })
}

function handleDelete(row) {
  const msgIds = row.msgId || ids.value
  proxy.$modal.confirm('是否确认删除消息编号为"' + msgIds + '"的数据项？').then(function() {
    return delMsg(msgIds)
  }).then(() => { getList(); proxy.$modal.msgSuccess("删除成功") }).catch(() => {})
}

getList()
</script>