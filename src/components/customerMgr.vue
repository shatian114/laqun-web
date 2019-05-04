<template>
  <div id="customerMgr">
    <el-form :inline="true">
        <el-form-item label="查询客户">
            <el-input v-model="searchName" placeholder="请输入查询的客户名"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
        <el-form-item label="添加客户" style="margin-left:200px;">
            <el-input v-model="addName" placeholder="请输入添加的客户名"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="success" v-on:click="add">添加</el-button>
        </el-form-item>
    </el-form>
    <hr />

    <el-table :data="customerTableData">
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column label="名称" prop="name"></el-table-column>
      <el-table-column label="添加好友数量" prop="addNum"></el-table-column>
      <el-table-column label="已经成为好友数量" prop="friendNum"></el-table-column>
      <el-table-column label="被拉群数量" prop="laNum"></el-table-column>
      <el-table-column label="剩余添加好友数量" prop="oddNum"></el-table-column>
      <el-table-column label="添加时间" prop="addTime"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popover placement="top" v-model="scope.row.popView">
            <div>
                <el-button type="danger" @click="delCustomer(scope.row)">确认</el-button>
                <el-button type="info" @click="scope.row.popView=false">取消</el-button>
            </div>
            <el-button type="text" size="small" slot="reference">删除</el-button>
          </el-popover>
        </template>
      </el-table-column>
    </el-table>

  </div>
</template>

<script>

export default {
  name: 'customerMgr',
  props: {
      apiPath: String
  },
  data: function(){
    return {
      searchName: '',
      addName: '',
      customerTableData: []
    }
  },
  methods: {
    //删除客户
    delCustomer(customer){
      console.log('del: ' + customer.name);
      this.$http.post(this.apiPath + '/webServer/delCustomer', {customerName: customer.name, customerId: customer.id}, {emulateJSON: true}).then((res)=>{
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
    //添加
    add: function(){
        this.$http.post(this.apiPath + '/webServer/addCustomer', {'customerName': this.addName}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            var resJson = res.body;
            if(resJson.res == 'success'){
              this.search();
                this.$message({
                    message: '添加成功',
                    type: 'success',
                    showClose: true
                });
            }else if(resJson.errInfo.indexOf('Duplicate entry') != -1){
                this.$message({
                    message: '本用户名已存在',
                    type: 'info',
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
    //搜索
    search: function(){
        console.log('path: ' + this.apiPath + "/webServer/getCustomer");
        this.$http.post(this.apiPath + '/webServer/getCustomer', {'customerName': this.searchName}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            //this.customerTableData = resJson.data;
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.length; i++){
                  resJson[i]['popView'] = false;
                }
                this.customerTableData = res.body.data;
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
    }
  }
}
</script>

<style>
</style>
