<template>
  <div id="talkFriendMgr">
    <el-form :inline="true">
        <el-form-item label="查询群聊">
            <el-input v-model="searchQunQr" placeholder="请输入查询群聊"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
        <el-form-item label="选择群聊二维码文件" style="margin-left:200px;">
            <el-upload action="" ref="upload" :file-list="txtFile" :autoUpload="isAutoUpload">
              <el-button type="" @click="selectFile">点我选择</el-button>
            </el-upload>
        </el-form-item>
        <el-form-item>
            <el-button type="success" v-on:click="add">添加</el-button>
        </el-form-item>
    </el-form>

    <el-table :data="talkChatRoomTableData">
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column label="群二维码" prop="qunQr"></el-table-column>
      <el-table-column label="群ID" prop="qunid"></el-table-column>
      <el-table-column label="成员数量" prop="friendNum"></el-table-column>
      <el-table-column label="群名称" prop="nick"></el-table-column>
      <el-table-column label="添加时间" prop="addTime"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popover placement="top" v-model="scope.row.popView">
            <div>
                <el-button type="danger" @click="delLoginWx(scope.row.qunQr)">确认</el-button>
                <el-button type="info" @click="scope.row.popView = false">取消</el-button>
            </div>
            <el-button type="text" size="small" slot="reference">删除</el-button>
          </el-popover>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>

import {file2txtArr} from '../jsModule/utils.js';

export default {
  name: 'talkFriendMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      talkChatRoomTableData: [],
      searchQunQr: '',
      addQunQr: '',
      isAutoUpload: false,
      txtFile: [],
    }
  },
  methods: {
    closeChange: function(type, qunQr, state){
      console.log('change qunQr: ' + qunQr + ", state: " + state);
      this.$http.post(this.apiPath + '/webServer/updateTalkChatRoom', {type: type, qunQr: qunQr, state: state}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        if(resJson.res == 'success'){
            this.search();
            this.$message({
                message: '更新成功',
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
    selectFile(){
      this.txtFile = [];
    },
    delLoginWx: function(qunQr){
      console.log('del: ' + qunQr);
      this.$http.post(this.apiPath + '/webServer/delTalkChatRoom', {qunQr: qunQr}, {emulateJSON: true}).then((res)=>{
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
        this.$http.post(this.apiPath + '/webServer/getTalkChatRoom', {qunQr: this.searchQunQr}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.length; i++){
                  resJson[i]['popView'] = false;
                }
                this.talkChatRoomTableData = res.body.data;
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
      let qunQrArr = await file2txtArr(file.files[0]);
      this.$http.post(this.apiPath + '/webServer/addTalkChatRoom', {qunQrArr: qunQrArr.join(',')}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            this.txtFile = [];
            var resJson = res.body;
            this.$message({
                message: '添加成功群聊二维码数量：' + resJson.saveQunQrCount,
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
