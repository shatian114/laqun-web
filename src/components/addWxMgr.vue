<template>
  <div id="addWxMgr">
    <el-form :inline="true">
        <el-form-item label="选择客户">
            <el-select v-model="selectCustomer" placeholder="请选择客户">
              <el-option v-for="item in customerArr" :key="item.name" :label="item.name" :value="item.name"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="查询手机" style="margin-left:50px;">
            <el-input v-model="searchPhone" placeholder="请输入查询的手机号"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
        <el-form-item label="选择手机号文件" style="margin-left:50px;">
            <el-upload action="" ref="upload" :file-list="txtFile" :autoUpload="isAutoUpload">
              <el-button type="" @click="selectFile">点我选择</el-button>
            </el-upload>
        </el-form-item>
        <el-form-item label="优先级">
            <el-select v-model="selectPriority" placeholder="优先级" style="width: 100px;">
              <el-option v-for="item in priorityArr" :key="item" :label="item" :value="item"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item>
            <el-button type="success" v-on:click="add">添加</el-button>
        </el-form-item>
    </el-form>
    <el-form :inline="true">
      
    </el-form>

    <el-table :data="addWxTableData">
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column label="手机号" prop="phone"></el-table-column>
      <el-table-column label="正在使用" prop="isUse"></el-table-column>
      <el-table-column label="wxid" prop="wxid"></el-table-column>
      <el-table-column label="昵称" prop="nick"></el-table-column>
      <el-table-column label="性别" prop="sex"></el-table-column>
      <el-table-column label="省" prop="province"></el-table-column>
      <el-table-column label="市" prop="city"></el-table-column>
      <el-table-column label="是否被拉" prop="isLa"></el-table-column>
      <el-table-column label="被拉的群" prop="laQunId"></el-table-column>
      <el-table-column label="被拉时间" prop="laTime"></el-table-column>
      <el-table-column label="添加时间" prop="addTime"></el-table-column>
      <el-table-column label="优先级" prop="priority"></el-table-column>
      <el-table-column label="客户" prop="customer"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popover placement="top" v-model="scope.row.popView">
            <div>
                <el-button type="danger" @click="delSn(scope.row.phone)">确认</el-button>
                <el-button type="info" @click="scope.row.popView = false">取消</el-button>
            </div>
            <!--<el-button type="text" size="small" slot="reference">删除</el-button>-->
          </el-popover>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import {file2txtArr} from '../jsModule/utils.js';

export default {
  resourcesTableData: [],
  name: 'addWxMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      selectCustomer: '',
      customerArr: [],
      isAutoUpload: false,
      txtFile: [],
      addWxTableData: [],
      searchPhone: '',
      priorityArr: [1, 2, 3, 4, 5],
      selectPriority: 1
    }
  },
  methods: {
    selectFile(){
      this.txtFile = [];
    },
    delSn: function(phone){
      console.log('del: ' + phone);
      this.$http.post(this.apiPath + '/webServer/delAddWx', {phone: phone}, {emulateJSON: true}).then((res)=>{
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
        this.$http.post(this.apiPath + '/webServer/getAddWx', {customer: this.selectCustomer, searchPhone: this.searchPhone}, {emulateJSON: true}).then((res)=>{
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
    add: async function(){
      let file = this.$refs.upload.$refs['upload-inner'].$refs.input;
      let addWxArr = await file2txtArr(file.files[0]);
      console.log('selectCustomer: ' + this.selectCustomer);
      this.$http.post(this.apiPath + '/webServer/addAddWx', {customer: this.selectCustomer, priority: this.selectPriority, addWxArr: addWxArr.join(',')}, {emulateJSON: true}).then((res)=>{
          console.log(res.body);
          var resJson = res.body;
          this.$message({
              message: '添加完成，成功添加数量：' + resJson.addCount,
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
    this.$http.post(this.apiPath + '/webServer/getCustomer', {customerName: ''}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        if(resJson.res == 'success'){
            this.customerArr = res.body.data;
            this.selectCustomer = this.customerArr[0].name;
            this.$message({
                message: '查询客户列表成功',
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
  }
}
</script>

<style>
</style>
