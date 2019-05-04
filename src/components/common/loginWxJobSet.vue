<template>
  <div id="loginWxJobSet">
      <el-form :inline="true">
        <el-form-item>
          <el-button type="primary" @click="saveConfig()">发布任务</el-button>
        </el-form-item>
      </el-form>
  </div>
</template>

<script>

export default {
  name: 'loginWxJobSet',
  data: function(){
    return {
      loginNum: 0
    }
  },
  methods: {
    saveConfig: function(){
      this.$emit('releaseJob', '');
    }
  }
}
</script>

<style>
</style>
