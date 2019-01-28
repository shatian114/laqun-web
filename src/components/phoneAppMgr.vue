<template>
  <div id="phoneAppMgr">
    <el-form :inline="true">
      <el-form-item label="APP版本">
        <el-input v-model="appVer" placeholder="请输入APP版本"></el-input>
      </el-form-item>
      <el-form-item label="选择APP文件" style="margin-left:100px;">
        <el-upload action="" ref="upload" :file-list="appFile" :autoUpload="isAutoUpload">
          <el-button type="" @click="selectFile">点我选择</el-button>
        </el-upload>
      </el-form-item>
      <el-form-item>
        <el-button type="success" v-on:click="add">添加</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>

export default {
  resourcesTableData: [],
  name: 'phoneAppMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      appVer: '',
      isAutoUpload: false,
      appFile: []
    }
  },
  methods: {
    selectFile(){
      this.appFile = [];
    },
    //添加
    add: function(){
      let file = this.$refs.upload.$refs['upload-inner'].$refs.input;
      var formData = new FormData();
      formData.append('appVer', this.appVer);
      formData.append('appFile', file.files[0]);
      this.$http.post(this.apiPath + '/webServer/addPhoneApp', formData).then((res)=>{
          console.log(res.body);
          var resJson = res.body;
          if(resJson.res == 'success'){
            this.$message({
              message: '添加完成',
              type: 'success',
              showClose: true
            });
          }else{
            this.$message({
              message: '添加失败',
              type: 'info',
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
    console.log('mouted');
    this.$http.post(this.apiPath + '/webServer/getPhoneAppVer', {}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            var resJson = res.body;
            if(resJson.res == 'success'){
                this.appVer = res.body.appVer
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
</script>

<style>
</style>
