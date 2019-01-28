<template>
  <div id="test">
    <el-form :inline="true">
        <el-form-item label="查询sn">
            <el-input v-model="searchSn" placeholder="请输入查询的sn"></el-input>
        </el-form-item>
        <el-form-item label="选择群二维码" style="margin-left:50px;">
            <el-upload action="" ref="upload" :file-list="txtFile" :autoUpload="isAutoUpload">
              <el-button type="" @click="selectFile">点我选择</el-button>
            </el-upload>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
    </el-form>
  </div>
</template>

<script>

import timeUtils from '../jsModule/timeUtils.js';

export default {
  name: 'test',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      isAutoUpload: false,
      txtFile: [],
      snTableData: [],
      searchSn: '',
      addSn: ''
    }
  },
  methods: {
    selectFile(){
      this.txtFile = [];
    },
    search: function(){
        //console.log(timeUtils.timeStamp2Str(parseInt(new Date().getTime()/1000)));
        let file = this.$refs.upload.$refs['upload-inner'].$refs.input;
        var formData = new FormData();
        formData.append('fileName', "test.sql");
        formData.append('file', file.files[0]);
        this.$http.post(this.apiPath + '/phoneServer/getTalkChatRoom', {"sn":"12345","isUse":"0","qunQr":"https://weixin.qq.com/g/AzEyczyPa_klAJHj","friendNum":"7","laedNum":"2","isBad":"0","qunid":"4962733081@chatroom","laWxidArr":"wxid1,wxid2"}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            //this.customerTableData = resJson.data;
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.length; i++){
                  resJson[i]['popView'] = false;
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
    
  }
}
</script>

<style>
</style>
