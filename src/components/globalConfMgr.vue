<template>
  <div id="globalConfMgr">
    <el-form ref="form" :model="confJson" label-width="300px">
        <el-form-item label="IP使用间隔时长(分钟):">
            <el-input v-model="confJson.ipUseTime"></el-input>
        </el-form-item>
        <el-form-item label="登录微信使用间隔时长(分钟):">
            <el-input v-model="confJson.loginWxUseTime"></el-input>
        </el-form-item>
        <el-form-item label="手机登录微信最大数量:">
            <el-input v-model="confJson.loginWxNum"></el-input>
        </el-form-item>
        <el-form-item label="群使用超时时间(分钟):">
            <el-input v-model="confJson.qunUseTimeout"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="setConf">保存</el-button>
        </el-form-item>
    </el-form>
  </div>
</template>

<script>

export default {
  name: 'globalConfMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      confJson: {
          loginWxUseTime: '',
          loginWxNum: '',
          ipUseTime: '',
          qunUseTimeout: ''
      }
    }
  },
  methods: {
    getConf: function(){
      this.$http.post(this.apiPath + '/webServer/getGlobalConf', {key: JSON.stringify(this.confJson)}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        this.confJson = resJson.data;
        if(resJson.res == 'success'){
            this.$message({
                message: '获取全局配置成功',
                type: 'success',
                showClose: true
            });
        }else{
            this.$message({
                message: '获取全局配置失败',
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
    },
    setConf: function(){
      this.$http.post(this.apiPath + '/webServer/setGlobalConf', {confJson: JSON.stringify(this.confJson)}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        if(resJson.res == 'success'){
            this.$message({
                message: '保存成功',
                type: 'success',
                showClose: true
            });
        }else{
            this.$message({
                message: '保存失败',
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
    },
  },
  mounted: function(){
    this.getConf();
  }
}
</script>

<style>
</style>
