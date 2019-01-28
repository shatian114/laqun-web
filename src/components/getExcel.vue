<template>
  <div id="getExcel">
    <el-form>
        <!-- 选择报表类型，下拉框 -->
          <el-form-item label="请选择群类型">
              <el-select v-model="selectExcelType" placeholder="请选择群类型">
                <el-option v-for="item in excelTypeArr" :key="item" :label="item" :value="item"></el-option>
              </el-select>
          </el-form-item>

            <el-form-item>
              <el-checkbox-group v-model="selectCustomer">
                <el-checkbox v-for="customer in customerArr" :key="customer.name" :label="customer.name"></el-checkbox>
              </el-checkbox-group>
            </el-form-item>

        <el-form-item>
            <el-button type="primary" v-on:click="generalExcel">开始生成报表</el-button>
        </el-form-item>
    </el-form>
  </div>
</template>

<script>

import timeUtils from '../jsModule/timeUtils.js';

export default {
  name: 'getExcel',
  props: {
    apiPath: String
  },
  data: function(){
    return {
        excelTypeArr: ['已拉完的群', '未拉完的群'],
        selectExcelType: '已拉完的群',
        customerArr: [],
        selectCustomer: []
    }
  },
  methods: {
      //生成报表，参数是客户列表和报表类型
      generalExcel: function(){
          console.log(this.apiPath.substr(0, this.apiPath.length-4) + '/files/');
          let customerArr = this.selectCustomer.join(',');
          this.$http.post(this.apiPath + '/webServer/generalExcel', {customerArr: customerArr, excelType: this.selectExcelType}, {emulateJSON: true}).then((res)=>{
                console.log(res.body);
                //this.customerTableData = resJson.data;
                var resJson = res.body;
                if(resJson.res == 'success'){
                    this.$message({
                        message: '生成成功，准备下载',
                        type: 'success',
                        showClose: true
                    });
                    window.open(this.apiPath.substr(0, this.apiPath.length-4) + '/files/' + resJson['excelFileName']);
                }else{
                    this.$message({
                        message: '生成失败，未知错误',
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
  },

  mounted: function(){
      console.log('start get customer arr');
      //先获取客户列表，供选择
      this.$http.post(this.apiPath + '/webServer/getCustomer', {customerName: ''}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        //this.customerTableData = resJson.data;
        var resJson = res.body;
        if(resJson.res == 'success'){
            this.customerArr = resJson.data;
            this.$message({
                message: '客户列表查询成功',
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
