<template>
  <div id="ipMgr">
    <el-form :inline="true">
        <el-form-item label="查询ip">
            <el-input v-model="searchIp" placeholder="请输入查询的IP"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
    </el-form>
    <el-form :inline="true">
      
    </el-form>

    <el-table :data="ipTableData">
      <el-table-column label="IP" prop="ipAddr"></el-table-column>
      <el-table-column label="使用次数" prop="useNum"></el-table-column>
      <el-table-column label="最后使用时间" prop="lastUseTime"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popover placement="top" v-model="scope.row.popView">
            <div>
                <el-button type="danger" @click="delSn(scope.row.ipAddr)">确认</el-button>
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
  name: 'ipMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      ipTableData: [],
      searchIp: ''
    }
  },
  methods: {
    selectFile(){
      this.txtFile = [];
    },
    delSn: function(ipAddr){
      console.log('del: ' + ipAddr);
      this.$http.post(this.apiPath + '/webServer/delIp', {ipAddr: ipAddr}, {emulateJSON: true}).then((res)=>{
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
        this.$http.post(this.apiPath + '/webServer/getIp', {searchIp: this.searchIp}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.length; i++){
                  resJson[i]['popView'] = false;
                }
                this.ipTableData = res.body.data;
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
