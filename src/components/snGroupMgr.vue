<template>
  <div id="snGroupMgr">
    <el-form :inline="true">
        <el-form-item label="查询sn组">
            <el-input v-model="searchSnGroup" placeholder="请输入查询的sn组"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
        <el-form-item>
            <el-button type="success" @click="dialogShow">添加</el-button>
        </el-form-item>
    </el-form>

    <el-dialog title="操作sn组成员" :visible.sync="dialogVisible">
      <el-form :inline="true">
        <el-form-item label="SN组名称">
            <el-input v-model="snGroupName" placeholder="请输入查询的sn组"></el-input>
        </el-form-item>
      </el-form>
      <el-checkbox-group v-model="selectSnArr">
        <el-checkbox v-for="sn in snArr" :key="sn.sn" :label="sn.sn"></el-checkbox>
      </el-checkbox-group>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button @click="add" type="primary">确定</el-button>
      </span>
    </el-dialog>

    <el-table :data="snGroupTableData">
      <el-table-column label="SN组" prop="groupName"></el-table-column>
      <el-table-column label="添加时间" prop="addTime"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popover placement="top" v-model="scope.row.popView">
            <div>
                <el-button type="danger" @click="delSn(scope.row.groupName)">确认</el-button>
                <el-button type="info" @click="scope.row.popView = false">取消</el-button>
            </div>
            <el-button type="text" size="small" slot="reference">删除</el-button>
            <el-button type="text" size="small" slot="reference" @click="changeSnGroup(scope.row.groupName, scope.row.groupMember)">编辑</el-button>
          </el-popover>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>

export default {
  name: 'snGroupMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      snGroupName: '',
      snArr: [],
      selectSnArr: [],
      dialogVisible: false,
      isAutoUpload: false,
      txtFile: [],
      snGroupTableData: [],
      searchSnGroup: '',
      addSn: '',
      addOrChange: ''
    }
  },
  methods: {
    //弹出dialog前设置修改内容
    changeSnGroup: function(groupName, groupMember){
      console.log('change name: ' + groupName);
      this.selectSnArr = groupMember.split(',');
      this.snGroupName = groupName;
      this.addOrChange = 'change';
      this.dialogVisible = true;
    },
    //弹出dialog前清除内容
    dialogShow: function(){
      this.snGroupName = '';
      this.selectSnArr = [];
      this.dialogVisible = true;
      this.addOrChange = 'add';
    },
    delSn: function(sn){
      console.log('del: ' + sn);
      this.$http.post(this.apiPath + '/webServer/delSnGroup', {groupName: sn}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        if(resJson.res == 'success'){
            this.search();
            this.$message({
                message: '删除成功',
                type: 'success',
                showClose: true
            });
        }else{
            this.$message({
                message: '未知错误',
                type: 'error',
                showClose: true
            });
        }
      }, (err)=>{
        this.$message({
            type: 'error',
            message: '服务器发生错误',
            showClose: true
        });
        console.log("err: ");
        for(var k in err){
            console.log(k + ": " + err[k]);
        }
      });
    },
    search: function(){
        this.$http.post(this.apiPath + '/webServer/getSnGroup', {'groupName': this.searchSnGroup}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.length; i++){
                  resJson[i]['popView'] = false;
                }
                this.snGroupTableData = res.body.data;
                this.$message({
                    message: '查询成功',
                    type: 'success',
                    showClose: true
                });
            }else{
                this.$message({
                    message: '未知错误',
                    type: 'error',
                    showClose: true
                });
            }
        }, (err)=>{
            this.$message({
                type: 'error',
                message: '服务器发生错误',
                showClose: true
            });
            console.log("err: ");
            for(var k in err){
                console.log(k + ": " + err[k]);
            }
        });
    },
    //添加
    add: function(){
      console.log(this.selectSnArr);
      this.$http.post(this.apiPath + '/webServer/addSnGroup', {operateType: this.addOrChange, snGroupName: this.snGroupName, snArr: this.selectSnArr.join(',')}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            var resJson = res.body;
            if(resJson.res == 'success'){
              this.$message({
                  message: '操作SN组成功',
                  type: 'success',
                  showClose: true
              });
            }else{
              this.$message({
                  message: '操作SN组失败: ' + resJson.errInfo,
                  type: 'info',
                  showClose: true
              });
            }
            this.dialogVisible = false;
        }, (err)=>{
            this.txtFile = [];
            this.$message({
                type: 'error',
                message: '服务器发生错误',
                showClose: true
            });
            console.log("err: ");
            for(var k in err){
                console.log(k + ": " + err[k]);
            }
        });
    }
  },
  mounted: function(){
    //获取全部sn
    this.$http.post(this.apiPath + '/webServer/getSn', {sn: ''}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        this.snArr = resJson.data;
        this.$message({
            message: '获取全部SN成功',
            type: 'success',
            showClose: true
        });
    }, (err)=>{
        this.txtFile = [];
        this.$message({
            type: 'error',
            message: '获取全部sn发生错误',
            showClose: true
        });
        console.log("err: ");
        for(var k in err){
            console.log(k + ": " + err[k]);
        }
    });
  }
}
</script>

<style>
</style>
