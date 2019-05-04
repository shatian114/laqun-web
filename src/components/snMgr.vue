<template>
  <div id="snMgr">
    <el-form :inline="true">
        <el-form-item label="查询sn">
            <el-input v-model="searchSn" placeholder="请输入查询的sn"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
        <el-form-item label="选择SN文件" style="margin-left:150px;">
            <el-upload action="" ref="upload" :file-list="txtFile" :autoUpload="isAutoUpload">
              <el-button type="" @click="selectFile">点我选择</el-button>
            </el-upload>
        </el-form-item>
        <el-form-item>
            <el-button type="success" v-on:click="add">添加</el-button>
        </el-form-item>
    </el-form>

    <el-table :data="snTableData" >
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column label="SN" prop="sn"></el-table-column>
      <el-table-column label="备注" prop="remark"></el-table-column>
      <el-table-column label="异常微信数量" prop="badWxNum"></el-table-column>
      <el-table-column label="正常微信数量" prop="goodWxNum"></el-table-column>
      <el-table-column label="当前状态" prop="currentState"></el-table-column>
      <el-table-column label="任务" prop="jobName"></el-table-column>
      <el-table-column label="任务参数" prop="jobContent"></el-table-column>
      <el-table-column label="最后通信时间">
        <template slot-scope="scope">
          <span :class="{ redTime: scope.row.timeout }">{{ scope.row.lastHttpTime }}</span>
        </template>
      </el-table-column>
      <el-table-column label="手机APP版本" prop="appVer"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popover placement="top" v-model="scope.row.popView">
            <div>
                <el-button type="danger" @click="delSn(scope.row.sn)">确认</el-button>
                <el-button type="info" @click="scope.row.popView = false">取消</el-button>
            </div>
            <el-button type="text" size="small" slot="reference">删除</el-button>
            <el-button type="text" size="small" slot="reference" @click="stopJob(scope.row.sn)" :disabled="scope.row.jobName == '任务已停止'">停止任务</el-button>
            <el-button type="text" size="small" slot="reference" @click="visibleRemarEdit(scope.row.sn, scope.row.remark)">设置备注</el-button>
          </el-popover>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog
      title='设置备注'
      :visible.sync="remarking"
      width="60%">
      <el-input v-model="remark" placeholder="请输入备注" :rows="3" type="textarea"></el-input>
      <span slot="footer">
        <el-button @click="remarking = false">取消</el-button>
        <el-button @click="setRemark">确定</el-button>
      </span>

    </el-dialog>
  </div>
</template>

<script>

import {file2txtArr} from '../jsModule/utils.js';

export default {
  name: 'snMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      selectSn: '',
      isAutoUpload: false,
      txtFile: [],
      snTableData: [],
      searchSn: '',
      addSn: '',
      remark: '',
      remarking: false,
    }
  },
  methods: {
    visibleRemarEdit: function(sn, remark) {
      this.remarking = true;
      this.selectSn = sn;
      this.remark = remark;
    },
    setRemark: function() {
      this.$http.post(this.apiPath + '/webServer/setSnRemark', {sn: this.selectSn, remark: this.remark}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        if(resJson.res == 'success'){
          this.remarking = false;
            this.search();
            this.$message({
                message: '备注设置成功',
                type: 'success',
                showClose: true
            });
        }else{
            this.$message({
                message: '备注设置失败',
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
    stopJob: function(sn){
      this.$http.post(this.apiPath + '/webServer/stopJob', {sn: sn}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        if(resJson.res == 'success'){
            this.search();
            this.$message({
                message: '停止成功',
                type: 'success',
                showClose: true
            });
        }else{
            this.$message({
                message: '停止错误',
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
    selectFile(){
      this.txtFile = [];
    },
    delSn: function(sn){
      console.log('del: ' + sn);
      this.$http.post(this.apiPath + '/webServer/delSn', {sn: sn}, {emulateJSON: true}).then((res)=>{
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
        this.$http.post(this.apiPath + '/webServer/getSn', {sn: this.searchSn}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            //this.customerTableData = resJson.data;
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.data.length; i++){
                  resJson.data[i]['popView'] = false;
                  if(resJson.data[i]['lastHttpTime'].length == 19 && Date.parse(resJson.data[i]['lastHttpTime'])+(10*60*1000) < Date.parse(new Date())){
                    resJson.data[i]['timeout'] = true;
                  }else{
                    resJson.data[i]['timeout'] = false;
                  }
                }
                this.snTableData = res.body.data;
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
    add: async function(){
      let file = this.$refs.upload.$refs['upload-inner'].$refs.input;
      let snArr = await file2txtArr(file.files[0]);
      this.$http.post(this.apiPath + '/webServer/addSn', {snArr: snArr.join(',')}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            this.txtFile = [];
            var resJson = res.body;
            this.$message({
                message: '添加成功SN数量：' + resJson.saveSnCount,
                type: 'success',
                showClose: true
            });
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
  }
}
</script>

<style>
.redTime{
  color: red;
}
</style>
