<template>
  <div id="jobMgr">
    <el-form :inline="true">
      <!-- 选择任务类型，下拉框 -->
      <el-form-item label="选择任务类型">
          <el-select v-model="selectJob" placeholder="请选择任务类型" @change="jobChange">
            <el-option v-for="item in jobArr" :key="item" :label="item" :value="item"></el-option>
          </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="dialogVisible = true">选择任务手机</el-button>
      </el-form-item>
    </el-form>

    <!-- 选择接受任务的手机，弹出框 -->
    <el-dialog title="选择接受任务手机" :visible.sync="dialogVisible">
      <el-form :inline="true">
        <el-form-item label="请选择接收任务的手机组">
          <el-select v-model="selectSnGroup" placeholder="请选择接收任务的手机组" @change="selectSnChange">
            <el-option v-for="item in snGroupArr" :key="item.groupName" :label="item.groupName" :value="item.groupName"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-checkbox-group v-model="selectSnArr">
            <el-checkbox v-for="sn in snArr" :key="sn.sn" :label="sn.sn"></el-checkbox>
          </el-checkbox-group>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false" type="primary">确定</el-button>
      </span>
    </el-dialog>

    <component :is="jobComponent" @releaseJob="releaseJob"></component>
  </div>
</template>

<script>

import resJobSet from './common/resJobSet'
import trainJobSet from './common/trainJobSet'
import addFriendJobSet from './common/addFriendJobSet'
import loginWxJobSet from './common/loginWxJobSet'

export default {
  components: {
    resJobSet, trainJobSet, loginWxJobSet, addFriendJobSet
  },
  name: 'jobMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      dialogVisible: false,
      jobArr: ['登录微信', '添加好友', '修改资料', '养号'],
      selectJob: '登录微信',
      selectSn: [],
      snGroupArr: [],
      snArr: [],
      selectSnArr: [],
      selectSnGroup: '',
      jobComponent: 'loginWxJobSet'
    }
  },
  methods: {
    jobChange: function(){
      switch(this.selectJob){
        case '登录微信':
          this.jobComponent = 'loginWxJobSet';
          break;
        case '添加好友':
          this.jobComponent = 'addFriendJobSet';
          break;
        case '修改资料':
          this.jobComponent = 'resJobSet';
          break;
        case '养号':
          this.jobComponent = 'trainJobSet';
          break;
      }
    },
    //发布任务
    releaseJob: function(configStr){
      console.log('start releaseJob: ' + configStr);
      this.$http.post(this.apiPath + '/webServer/releaseJob', {snArr: this.selectSnArr.join(','), job: this.selectJob, jobContent: configStr}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        if(resJson.res == 'success'){
            this.$message({
                message: '发布成功',
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
    //改变了SN组后，同步selectSnArr
    selectSnChange: function(){
      console.log(this.selectSnGroup);
      for(var i=0; i<this.snGroupArr.length; i++){
        if(this.selectSnGroup == this.snGroupArr[i]['groupName']){
          this.selectSnArr = this.snGroupArr[i]['groupMember'].split(',');
          return;
        }
      }
    },
    delSn: function(phone){
      console.log('del: ' + phone);
      this.$http.post(this.apiPath + '/webServer/delLaQun', {customer: this.selectCustomer, phone: phone}, {emulateJSON: true}).then((res)=>{
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
        this.$http.post(this.apiPath + '/webServer/getLaQun', {customer: this.selectCustomer, searchPhone: this.searchPhone}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.length; i++){
                  resJson[i]['popView'] = false;
                }
                this.addWxTableData = res.body.data;
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
      let file = this.$refs.upload.$refs['upload-inner'].$refs.input;
      var formData = new FormData();
      console.log('selectCustomer: ' + this.selectCustomer);
      formData.append('customer', this.selectCustomer);
      formData.append('txtFile', file.files[0]);
      this.$http.post(this.apiPath + '/webServer/addLaQun', formData).then((res)=>{
          console.log(res.body);
          var resJson = res.body;
          this.$message({
              message: '添加完成，成功添加数量：' + resJson.saveQunidCount,
              type: 'success',
              showClose: true
          });
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
    }
  },
  mounted: function(){
    //获取sn组名称
    this.$http.post(this.apiPath + '/webServer/getSnGroup', {groupName: ''}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        //this.customerTableData = resJson.data;
        var resJson = res.body;
        if(resJson.res == 'success'){
            this.snGroupArr = resJson.data;
            this.$message({
                message: 'SN组查询成功',
                type: 'success',
                showClose: true
            });
        }else{
            this.$message({
                message: '查询SN组发生未知错误',
                type: 'error',
                showClose: true
            });
        }
    }, (err)=>{
        this.$message({
            type: 'error',
            message: '查询客户列表时，服务器发生错误',
            showClose: true
        });
        console.log("err: ");
        for(var k in err){
            console.log(k + ": " + err[k]);
        }
    });
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
