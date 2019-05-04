<template>
  <div id="newsMgr">
    <el-form :inline="true">
        <el-form-item label="查询新闻">
            <el-input v-model="searchNewsName" placeholder="请输入查询的新闻名称"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
        <el-form-item label="选择新闻文件" style="margin-left:200px;">
            <el-upload action="" ref="upload" :file-list="txtFile" :autoUpload="isAutoUpload">
              <el-button type="" @click="selectFile">点我选择</el-button>
            </el-upload>
        </el-form-item>
        <el-form-item>
            <el-button type="success" v-on:click="add">添加</el-button>
        </el-form-item>
    </el-form>

    <el-table :data="newsTableData">
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column label="新闻名称" prop="newsName"></el-table-column>
      <el-table-column label="新闻URL" prop="newsUrl"></el-table-column>
      <el-table-column label="添加时间" prop="addTime"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popover placement="top" v-model="scope.row.popView">
            <div>
                <el-button type="danger" @click="del(scope.row.newsName)">确认</el-button>
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
  name: 'newsMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      isAutoUpload: false,
      newsTableData: [],
      searchNewsName: '',
      txtFile: []
    }
  },
  methods: {
    selectFile(){
      this.txtFile = [];
    },
    del: function(newsName){
      console.log('del: ' + newsName);
      this.$http.post(this.apiPath + '/webServer/delNews', {newsName: newsName}, {emulateJSON: true}).then((res)=>{
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
        this.$http.post(this.apiPath + '/webServer/getNews', {newsName: this.searchNewsName}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            //this.customerTableData = resJson.data;
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.length; i++){
                  resJson[i]['popView'] = false;
                }
                this.newsTableData = res.body.data;
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
      let newsArr = await file2txtArr(file.files[0]);
      this.$http.post(this.apiPath + '/webServer/addNews', {newsArr: newsArr.join(',')}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            this.txtFile = [];
            var resJson = res.body;
            this.$message({
                message: '添加成功新闻数量：' + resJson.saveNewsCount,
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
