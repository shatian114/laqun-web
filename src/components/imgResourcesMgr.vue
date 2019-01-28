<template>
  <div id="imgResourcesMgr">
    <el-form :inline="true">
        <el-form-item label="选择要操作的资源类型">
            <el-select v-model="selectType" placeholder="请选择要操作资源类型">
              <el-option v-for="item in resourcesTypeArr" :key="item.val" :label="item.name" :value="item.val"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" v-on:click="search">查询</el-button>
        </el-form-item>
        <el-form-item label="选择图片" style="margin-left:200px;">
            <el-upload action="" ref="upload" :file-list="imgList" multiple :autoUpload="isAutoUpload">
              <el-button type="" @click="selectFile">点我选择</el-button>
            </el-upload>
        </el-form-item>
        <el-form-item>
            <el-button type="success" v-on:click="add">添加</el-button>
        </el-form-item>
    </el-form>

    <el-table :data="resourcesTableData">
      <el-table-column label="图片" prop="fileName">
        <template slot-scope="scope">
          <img :src="apiPath.substr(0, apiPath.length-4) + '/files/' + selectType + '/' + scope.row.val + '.jpg'" width="80px" height="80px" />
        </template>
      </el-table-column>
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
  name: 'imgResourcesMgr',
  props: {
    apiPath: String
  },
  data: function(){
    return {
      isAutoUpload: false,
      imgList: [],
      addVal: '',
      selectType: 'avatar',
      resourcesTypeArr: [
          {name: '头像', val: 'avatar'},
          {name: '朋友圈背景', val: 'backImg'},
          {name: '发圈图片', val: 'momentsImg'}
      ],
      resourcesTableData: [],
      fileList: '',
      fileIndex: 0
    }
  },
  methods: {
    selectFile(){
      this.imgList = [];
    },
    delSn: function(fileName){
      console.log('del: ' + fileName + ", resourcesType: " + this.selectType);
      this.$http.post(this.apiPath + '/webServer/delImg', {resourcesType: this.selectType, fileName: fileName}, {emulateJSON: true}).then((res)=>{
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
        this.$http.post(this.apiPath + '/webServer/getImgList', {resourcesType: this.selectType, pages: 0}, {emulateJSON: true}).then((res)=>{
            console.log(res.body);
            var resJson = res.body;
            if(resJson.res == 'success'){
                //先给所有的pop加上显示标志
                for(var i=0; i<resJson.length; i++){
                  resJson[i]['popView'] = false;
                  resJson[i]['imgUrl'] = resJson[i]['fileName'] + ".jpg";
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
    //将图片文件添加到fileList，然后遍历fileList，每次提交一个
    //添加
    add: function(){

			//添加之前先清空对应资源
			this.$http.post(this.apiPath + '/webServer/clearImg', {resourceType: this.selectType}, {emulateJSON: true}).then((res)=>{
          console.log(res.body);
          var resJson = res.body;
          if(resJson.res == 'success'){

						//上传图片
						let file = this.$refs.upload.$refs['upload-inner'].$refs.input;
      			this.fileList = file.files;
      			this.fileIndex = 0;
      			for(var i=0; i<this.fileList.length; i++){
      			  this.$message({
      			      message: '添加第' + (i+1) + '个',
      			      type: 'info',
      			      showClose: true
      			  });
      			  this.upImg();
      			  this.fileIndex++;
      			}	
          	this.$message({
          	    message: '清空成功',
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
    //上传图片
    upImg: function(){
      var formData = new FormData();
      formData.append('resourcesType', this.selectType);
      formData.append('img', this.fileList[this.fileIndex]);
      this.$http.post(this.apiPath + '/webServer/addImgResources', formData).then((res)=>{
          console.log(res.body);
          var resJson = res.body;
          if(resJson.res == 'success'){
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
          if(this.fileIndex == this.fileList.length){
            this.$message({
                message: '全部上传完成',
                type: 'success',
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
