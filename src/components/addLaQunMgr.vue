<template>
  <div id="addLaQunMgr">
    <el-form :inline="true">
        <el-form-item label="选择要操作的客户">
            <el-select v-model="selectCustomer" placeholder="请选择要操作的客户">
              <el-option v-for="item in customerArr" :key="item.name" :label="item.name" :value="item.name"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="查询群" style="margin-left:50px;">
            <el-input v-model="searchPhone" placeholder="请输入查询的群"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
        <el-form-item label="选择群二维码" style="margin-left:50px;">
            <el-upload action="" ref="upload" :file-list="txtFile" :autoUpload="isAutoUpload">
              <el-button type="" @click="selectFile">点我选择</el-button>
            </el-upload>
        </el-form-item><el-form-item label="优先级">
          <el-select v-model="selectPriority" placeholder="优先级" style="width: 100px;">
            <el-option v-for="item in priorityArr" :key="item" :label="item" :value="item"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
            <el-button type="success" v-on:click="add">添加</el-button>
        </el-form-item>
    </el-form>

    <el-table :data="addWxTableData">
      <el-table-column label="群二维码" prop="qunQr"></el-table-column>
      <el-table-column label="群id" prop="qunid"></el-table-column>
      <el-table-column label="昵称" prop="nick"></el-table-column>
      <el-table-column label="已经拉的数量" prop="laedNum"></el-table-column>
      <el-table-column label="剩余拉的数量" prop="canLaNum"></el-table-column>
      <el-table-column label="群成员数量" prop="friendNum"></el-table-column>
      <el-table-column label="群是否异常" prop="isBad"></el-table-column>
      <el-table-column label="最后获取时间" prop="lastGetTimeStr"></el-table-column>
      <el-table-column label="优先级" prop="priority"></el-table-column>
      <el-table-column label="客户" prop="customer"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popover placement="top" v-model="scope.row.popView">
            <div>
                <el-button type="danger" @click="delSn(scope.row.qunQr)">确认</el-button>
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

export default {
  name: 'addLaQunMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      customerArr: [],
      selectCustomer: '',
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
                for(var i=0; i<resJson.data.length; i++){
                  resJson.data[i]['popView'] = false;
                  //转换时间戳为时间格式
                  resJson.data[i]['lastGetTimeStr'] = new Date(resJson.data[i].lastGetTime*1000).toLocaleString();
                  console.log(resJson.data[i]['lastGetTimeStr']);
                  //转换损坏标注1,0为是或否，方便查看
                  resJson.data[i]['isBad'] = resJson.data[i]['isBad'] == 0 ? '否' : '是';
                }
                this.addWxTableData = resJson.data;
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
      formData.append('priority', this.selectPriority);
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
    this.$http.post(this.apiPath + '/webServer/getCustomer', {'customerName': ''}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        //this.customerTableData = resJson.data;
        var resJson = res.body;
        if(resJson.res == 'success'){
            this.customerArr = res.body.data;
            this.selectCustomer = this.customerArr[0]['name'];
            this.$message({
                message: '客户列表查询成功',
                type: 'success',
                showClose: true
            });
        }else{
            this.$message({
                message: '查询客户列表发生未知错误',
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
  }
}
</script>

<style>
</style>
