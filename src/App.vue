<template>
  <div id="app">
    <el-container>
      <el-header id="app-header">
        <el-row>
          <el-col :span="4" :offset="10">
            <h1>管理平台</h1>
          </el-col>
          <el-col :span="4">
            <el-button type="primary" @click="loginModel">{{ isLoged ? '退出' : '登录' }}</el-button>
          </el-col>
        </el-row>
      </el-header>

      <el-container>
        <el-aside id="app-aside">
          <el-menu router v-bind:style="{height: asideHeight + 'px'}">
            <el-menu-item index="test">测试界面</el-menu-item>
            <el-menu-item index="globalConfMgr">全局配置</el-menu-item>
            <el-menu-item index="phoneAppMgr">手机APP管理</el-menu-item>
            <el-menu-item index="customerMgr">客户管理</el-menu-item>
            <el-menu-item index="snMgr">手机sn管理</el-menu-item>
            <el-menu-item index="snGroupMgr">手机sn组管理</el-menu-item>
            <el-menu-item index="ipMgr">IP管理</el-menu-item>
            <el-menu-item index="loginWxMgr">登录微信管理</el-menu-item>
            <el-menu-item index="newsMgr">新闻管理</el-menu-item>
            <el-menu-item index="talkChatRoomMgr">群聊管理</el-menu-item>
            <el-submenu index="">
              <template slot="title">资源管理</template>
              <el-menu-item index="textResourcesMgr">文本资源管理</el-menu-item>
              <el-menu-item index="imgResourcesMgr">图片资源管理</el-menu-item>
            </el-submenu>
            <el-menu-item index="addWxMgr">添加微信管理</el-menu-item>
            <el-menu-item index="addLaQunMgr">添加拉群管理</el-menu-item>
            <el-menu-item index="jobMgr">任务管理</el-menu-item>
            <el-menu-item index="getExcel">获取报表</el-menu-item>
          </el-menu>
        </el-aside>
        <el-main id="app-main">
          <router-view :apiPath="apiPath" :pageSize="pageSize"></router-view>
        </el-main>
      </el-container>
    </el-container>

    <!-- 登录弹出框 -->
    <el-dialog title="登录" :visible.sync="loginView">
      <el-form>
        <el-form-item>
          <el-input v-model="loginPassword" placeholder="请输入登录密码"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="login">登录</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>

export default {
  name: 'app',
  data: function(){
    return {
      // apiPath: '/wxQunWeb_war/api',
      apiPath: '/api',
      asideHeight: 0,
      pageSize: 10,
      isLoged: false,
      loginView: false,
      loginPassword: ''
    }
  },

  methods: {
    //登录按钮事件
    loginModel: function(){
      //如果已经登录了，就退出
      if(this.isLoged){
        this.$http.post(this.apiPath + '/webServer/logout', {}, {emulateJSON: true}).then((res)=>{
          console.log(res.body);
          var resJson = res.body;
          this.$message({
              message: resJson.resInfo,
              type: 'success',
              showClose: true
          });
          if(resJson.resInfo == '退出成功'){
              this.isLoged = false;
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
      }else{
        //否则弹出登录框
        this.loginView = true;
      }
    },

    login: function(){
      this.$http.post(this.apiPath + '/webServer/login', {loginPassword: this.loginPassword}, {emulateJSON: true}).then((res)=>{
        console.log(res.body);
        var resJson = res.body;
        this.$message({
            message: resJson.resInfo,
            type: 'success',
            showClose: true
        });
        if(resJson.resInfo == '登录成功'){
          window.location.reload();
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
    this.asideHeight = window.innerHeight-60;
    //判断登录状态
    this.$http.post(this.apiPath + '/webServer/isLogin', {}, {emulateJSON: true}).then((res)=>{
      console.log(res.body);
      var resJson = res.body;
      if(resJson.resInfo == '登录成功'){
        this.isLoged = true;
      }else{
        this.isLoged = false
      }
    }, (err)=>{
      console.log("err: ");
      this.isLoged = false;
    });
  }
}
</script>

<style>
  #app-header {
    text-align: center;
    background-color: #ccc;
  }

  body {
    margin: 0px;
  }
</style>
