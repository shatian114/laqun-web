<template>
  <div id="trainJobSet">
      <el-form :inline="true">
          <el-form-item label="点赞数量">
            <el-input v-model="dianzanNum" placeholder="请输入点赞数量"></el-input>
          </el-form-item>
          <el-form-item label="评论数量">
            <el-input v-model="pinglunNum" placeholder="请输入评论数量"></el-input>
          </el-form-item>
          <el-form-item label="看文章数量">
            <el-input v-model="kanwenzhangNum" placeholder="请输入看文章数量"></el-input>
          </el-form-item>
          <el-form-item label="发朋友圈类型">
            <el-select v-model="fapengyouquanType" placeholder="请选择朋友圈类型">
              <el-option v-for="item in pengyouquanTypeArr" :key="item" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="是否互聊">
            <el-select v-model="isTalk">
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
  name: 'trainJobSet',
  data: function(){
    return {
      isAddTalk: '是',
      isTalkToTalkWx: '是',
      isTalk: '是',
      talkArr: ['是', '否'],
      dianzanNum: 0,
      pinglunNum: 0,
      kanwenzhangNum: 0,
      fapengyouquanType: 0,
      pengyouquanTypeArr: ['文字', '文字和图片']
    }
  },
  methods: {
    saveConfig: function(){
      var jobConfigArr = {};
      jobConfigArr['点赞数量'] = this.dianzanNum;
      jobConfigArr['评论数量'] = this.pinglunNum;
      jobConfigArr['看文章数量'] = this.kanwenzhangNum;
      jobConfigArr['是否互聊'] = this.isTalk;
      jobConfigArr['朋友圈类型'] = this.fapengyouquanType;
      this.$emit('releaseJob', JSON.stringify(jobConfigArr));
    }
  }
}
</script>

<style>
</style>
