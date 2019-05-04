<template>
  <div id="addFriendJobSet">
      <el-form :inline="true">
          <!--<el-form-item label="加人方式">
            <el-select v-model="addType" placeholder="请选择加人方式">
              <el-option v-for="item in addTypeArr" :key="item" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="来源">
            <el-select v-model="sourceType" placeholder="请选择来源">
              <el-option v-for="item in sourceTypeArr" :key="item" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>-->
          <el-form-item label="加人次数">
            <el-input v-model="addNum" placeholder="请输入加人次数"></el-input>
          </el-form-item>
          <el-form-item label="是否看文章">
            <el-select v-model="isViewWenzhang" placeholder="是否看文章">
              <el-option v-for="item in kanwenzhangArr" :key="item" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="是否拉群">
            <el-select v-model="isLaqun" placeholder="是否拉群">
              <el-option v-for="item in laqunArr" :key="item" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="是否与互聊微信号聊天">
            <el-select v-model="isAddTalk">
              <el-option v-for="item in talkArr" :key="item" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="saveConfig()">发布任务</el-button>
          </el-form-item>
      </el-form>
  </div>
</template>

<script>

export default {
  name: 'addFriendJobSet',
  data: function(){
    return {
      talkArr: ['是', '否'],
      addType: '搜索',
      addTypeArr: ['搜索', 'wxid', '通讯录'],
      sourceType: '无',
      sourceTypeArr: ['无', '附近的人'],
      addNum: '0',
      kanwenzhangArr: ['看', '不看'],
      laqunArr: ['拉', '不拉'],
      isViewWenzhang: '看',
      isLaqun: '拉',
      isAddTalk: '否'
    }
  },
  methods: {
    saveConfig: function(){
      var jobConfigArr = {};
      jobConfigArr['是否互聊'] = this.isAddTalk;
      jobConfigArr['添加数量'] = this.addNum;
      jobConfigArr['是否看文章'] = this.isViewWenzhang;
      jobConfigArr['是否拉群'] = this.isLaqun;
      console.log(JSON.stringify(jobConfigArr));

      this.$emit('releaseJob', JSON.stringify(jobConfigArr));
    }
  }
}
</script>

<style>
</style>
