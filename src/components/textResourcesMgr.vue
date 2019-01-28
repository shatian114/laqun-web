<template>
  <div id="textResourcesMgr">
    <el-form :inline="true">
        <el-form-item label="选择要操作的资源类型">
            <el-select v-model="selectType" placeholder="请选择要操作资源类型">
              <el-option v-for="item in resourcesTypeArr" :key="item.val" :label="item.name" :value="item.val"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
        <el-form-item label="选择资源文件" style="margin-left:200px;">
            <el-upload action="" ref="upload" :file-list="txtFile" :autoUpload="isAutoUpload">
              <el-button type="" @click="selectFile">点我选择</el-button>
            </el-upload>
        </el-form-item>
        <el-form-item>
            <el-button type="success" v-on:click="add">添加</el-button>
        </el-form-item>
    </el-form>

    <el-table :data="resourcesTableData">
      <el-table-column label="值" prop="val"></el-table-column>
      <el-table-column label="添加时间" prop="addTime"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popover placement="top" v-model="scope.row.popView">
            <div>
                <el-button type="danger" @click="delSn(scope.row.val)">确认</el-button>
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
  resourcesTableData: [],
  name: 'textResourcesMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      isAutoUpload: false,
      txtFile: [],
      addVal: '',
      selectType: 'nick',
      resourcesTypeArr: [
          {name: '昵称', val: 'nick'},
          {name: '朋友圈评论', val: 'comment'},
          {name: '发圈内容', val: 'moments'},
          {name: '签名', val: 'sign'},
          {name: '加好友验证', val: 'addFriendVerify'},
          {name: '聊天内容', val: 'talkContent'}
      ],
      resourcesTableData: []
    }
  },
  methods: {
    selectFile(){
      this.txtFile = [];
    },
    delSn: function(val){
      console.log('del: ' + val);
      this.$http.post(this.apiPath + '/webServer/delTextResources', {resourcesType: this.selectType, val: val}, {emulateJSON: true}).then((res)=>{
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
        this.$http.post(this.apiPath + '/webServer/getTextResources', {resourcesType: this.selectType}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.length; i++){
                  resJson[i]['popView'] = false;
                }
                this.resourcesTableData = res.body.data;
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
      formData.append('txtFile', file.files[0]);
      formData.append('resourceType', this.selectType);
      this.$http.post(this.apiPath + '/webServer/addTextResources', formData, {emulateJSON: true}).then((res)=>{
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
                    message: '这个值在这个类型里已存在',
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
    }
  }
}
</script>

<style>
</style>
