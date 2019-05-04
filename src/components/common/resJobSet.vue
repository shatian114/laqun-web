<template>
  <div id="resJobSet">
      <el-form :inline="true">
        <el-form-item label="是否修改头像">
            <el-select v-model="isChangeAvatar">
              <el-option key="是" label="是" value="是"></el-option>
              <el-option key="否" label="否" value="否"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="是否修改昵称">
            <el-select v-model="isChangeNick">
              <el-option key="是" label="是" value="是"></el-option>
              <el-option key="否" label="否" value="否"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="是否修改朋友圈背景">
            <el-select v-model="isChangeBack">
              <el-option key="是" label="是" value="是"></el-option>
              <el-option key="否" label="否" value="否"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="是否修改密码">
            <el-select v-model="isChangePassword">
              <el-option key="是" label="是" value="是"></el-option>
              <el-option key="否" label="否" value="否"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="是否添加好友验证">
            <el-select v-model="isChangeAddVerify">
              <el-option key="是" label="是" value="是"></el-option>
              <el-option key="否" label="否" value="否"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="修改地区列表">
            <el-select v-model="isChangeCountry">
              <el-option v-for="item in countryArr" :key="item" :label="item" :value="item"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="修改性别">
            <el-select v-model="isChangeSex">
              <el-option key="不修改" label="不修改" value="不修改"></el-option>
              <el-option key="男" label="男" value="男"></el-option>
              <el-option key="女" label="女" value="女"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="是否修改签名">
            <el-select v-model="isChangeSign">
              <el-option key="是" label="是" value="是"></el-option>
              <el-option key="否" label="否" value="否"></el-option>
            </el-select>
        </el-form-item>
        <!-- <el-form-item>
          <el-checkbox-group v-model="selectResTypeArr">
            <el-checkbox v-for="resType in resTypeArr" :key="resType.name" :label="resType.name"></el-checkbox>
          </el-checkbox-group>
        </el-form-item> -->
        <el-form-item>
            <el-button type="primary" @click="saveConfig()">发布任务</el-button>
        </el-form-item>
      </el-form>
  </div>
</template>

<script>

export default {
  name: 'resJobSet',
  data: function(){
    return {
      isChangeSex: '不修改',
      isChangeSign: '是',
      isChangeAvatar: '是',
      isChangeNick: '是',
      isChangeBack: '是',
      isChangePassword: '是',
      isChangeAddVerify: '是',
      isChangeCountry: '不修改',
      countryArr: ['不修改', 'Anhui', 'Beijing', 'Chongqing', 'Fujian', 'Gansu', 'Guangdong', 'Guizhou', 'Hainan', 'Hebei', 'Heilongjiang', 'Henan', 'Hong Kong', 'Hubei', 'Hunan', 'Inner Mongolia', 'Jiangsu', 'Jiangxi', 'Jilin', 'Liaoning', 'Macao', 'Ningxia', 'Qinghai', 'Shaanxi', 'Shandong', 'Shanghai', 'Shanxi', 'Sichuan', 'Taiwan', 'Tianjin', 'Tibet', 'Xinjiang', 'Yunnan', 'Zhejiang']
    }
  },
  methods: {
    saveConfig: function(){
      var jobConfigArr = {};
      jobConfigArr['是否修改头像'] = this.isChangeAvatar;
      jobConfigArr['是否修改昵称'] = this.isChangeNick;
      jobConfigArr['是否修改朋友圈背景'] = this.isChangeBack;
      jobConfigArr['是否修改密码'] = this.isChangePassword;
      jobConfigArr['是否添加好友验证'] = this.isChangeAddVerify;
      jobConfigArr['是否修改地区'] = this.isChangeCountry;
      jobConfigArr['是否修改性别'] = this.isChangeSex;
      jobConfigArr['是否修改签名'] = this.isChangeSign;
      console.log(JSON.stringify(jobConfigArr));
      this.$emit('releaseJob', JSON.stringify(jobConfigArr));
    }
  }
}
</script>

<style>
</style>
