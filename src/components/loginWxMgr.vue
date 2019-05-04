<template>
  <div id="loginWxMgr">
    <el-form :inline="true">
        <el-form-item label="查询微信">
            <el-input v-model="searchWxName" placeholder="请输入查询的微信号"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
        <el-form-item label="选择登录微信号文件" style="margin-left:200px;">
            <el-upload action="" ref="upload" :file-list="txtFile" :autoUpload="isAutoUpload">
              <el-button type="" @click="selectFile">点我选择</el-button>
            </el-upload>
        </el-form-item>
        <el-form-item>
            <el-button type="success" v-on:click="add">添加</el-button>
        </el-form-item>
    </el-form>
    <el-form :inline="true">
        <el-form-item label="操作相关状态微信">
            <el-select v-model="wxState" placeholder="操作状态">
              <el-option v-for="item in wxStateArr" :key="item" :label="item" :value="item"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="operate('download')">导出</el-button>
        </el-form-item>
        <el-form-item>
            <el-button type="danger" v-on:click="operate('del')">删除</el-button>
        </el-form-item>
    </el-form>

    <el-table :data="loginWxTableDataView">
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column label="微信号" prop="wxName"></el-table-column>
      <el-table-column label="wxid" prop="wxid"></el-table-column>
      <el-table-column label="密码" prop="wxPassword"></el-table-column>
      <el-table-column label="昵称" prop="nick"></el-table-column>
      <el-table-column label="允许加好友数量" prop="addNum"></el-table-column>
      <el-table-column label="目前好友数量" prop="friendNum"></el-table-column>
      <el-table-column label="状态" prop="state"></el-table-column>
      <el-table-column label="手机sn" prop="sn"></el-table-column>
      <el-table-column label="添加时间" prop="addTime"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popover placement="top" v-model="scope.row.popView">
            <div>
                <el-button type="danger" @click="delLoginWx(scope.row.wxid)">确认</el-button>
                <el-button type="info" @click="scope.row.popView = false">取消</el-button>
            </div>
            <el-button type="text" size="small" slot="reference">删除</el-button>
          </el-popover>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination :page-count="pageCount" @current-change="changePage" layout="prev, pager, next">
      
    </el-pagination>
  </div>
</template>

<script>

import {file2txtArr} from '../jsModule/utils.js';

export default {
  name: 'loginWxMgr',
  props: {
    apiPath: String,
    pageSize: Number
  },
  data: function(){
    return {
      pageCount: 0,

      isAutoUpload: false,
      loginWxTableData: [],
      loginWxTableDataView: [],
      searchWxName: '',
      txtFile: [],
      wxStateArr: ['密码错误','新机','封号'],
      wxState: '密码错误'
    }
  },
  methods: {
    //导出或删除相关状态的微信
    operate: function(operateType){
      console.log('start ' + operateType + ': ' + this.wxState);
      this.$http.post(this.apiPath + '/webServer/operateLoginWx', {wxState: this.wxState, operateType: operateType}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        if(resJson.res == 'success'){
            this.$message({
                message: '操作成功',
                type: 'success',
                showClose: true
            });
            if(operateType == 'download'){
              window.location.href = "http://" + window.location.host + this.apiPath.substr(0, this.apiPath.length-4) + '/loginWx.txt';
            }
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
    changePage: function(page){
      //数组下表从0开始
      page--;
      console.log(this.loginWxTableData);
      this.loginWxTableDataView = this.loginWxTableData.slice(page*this.pageSize, page*this.pageSize+this.pageSize);
      console.log(this.loginWxTableDataView);
    },
    selectFile(){
      this.txtFile = [];
    },
    delLoginWx: function(wxid){
      console.log('del: ' + wxid);
      this.$http.post(this.apiPath + '/webServer/delLoginWx', {wxid: wxid}, {emulateJSON: true}).then((res)=>{
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
        this.$http.post(this.apiPath + '/webServer/getLoginWx', {'wxName': this.searchWxName}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            //this.customerTableData = resJson.data;
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.length; i++){
                  resJson[i]['popView'] = false;
                }
                this.loginWxTableData = res.body.data;
                this.pageCount = Math.ceil(this.loginWxTableData.length/this.pageSize);
                this.loginWxTableDataView = this.loginWxTableData.slice(0, this.pageSize);
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
      let loginWxArr = await file2txtArr(file.files[0]);
      this.$http.post(this.apiPath + '/webServer/addLoginWx', {loginWxArr: loginWxArr.join(',')}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            this.txtFile = [];
            var resJson = res.body;
            this.$message({
                message: '添加成功登录微信数量：' + resJson.saveWxCount,
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
</style>
