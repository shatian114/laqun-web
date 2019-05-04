import Vue from 'vue'
import Router from 'vue-router'
import globalConfMgr from '@/components/globalConfMgr'
import phoneAppMgr from '@/components/phoneAppMgr'
import customerMgr from '@/components/customerMgr'
import loginWxMgr from '@/components/loginWxMgr'
import newsMgr from '@/components/newsMgr'
import talkChatRoomMgr from '@/components/talkChatRoomMgr'
import snMgr from '@/components/snMgr'
import snGroupMgr from '@/components/snGroupMgr'
import ipMgr from '@/components/ipMgr'
import test from '@/components/test'
import textResourcesMgr from '@/components/textResourcesMgr'
import imgResourcesMgr from '@/components/imgResourcesMgr'
import addWxMgr from '@/components/addWxMgr'
import addLaQunMgr from '@/components/addLaQunMgr'
import jobMgr from '@/components/jobMgr'
import getExcel from '@/components/getExcel'

Vue.use(Router)
Vue.use(globalConfMgr)
Vue.use(customerMgr)
Vue.use(phoneAppMgr)
Vue.use(loginWxMgr)
Vue.use(newsMgr)
Vue.use(talkChatRoomMgr)
Vue.use(snMgr)
Vue.use(snGroupMgr)
Vue.use(ipMgr)
Vue.use(test)
Vue.use(addWxMgr)
Vue.use(addLaQunMgr)
Vue.use(textResourcesMgr)
Vue.use(imgResourcesMgr)
Vue.use(jobMgr)

export default new Router({
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/globalConfMgr',
      name: 'globalConfMgr',
      component: globalConfMgr
    },{
      path: '/phoneAppMgr',
      name: 'phoneAppMgr',
      component: phoneAppMgr
    },
    {
      path: '/customerMgr',
      name: 'customerMgr',
      component: customerMgr
    },
    {
      path: '/snMgr',
      name: 'snMgr',
      component: snMgr
    },
    {
      path: '/snGroupMgr',
      name: 'snGroupMgr',
      component: snGroupMgr
    },
    {
      path: '/ipMgr',
      name: 'ipMgr',
      component: ipMgr
    },
    {
      path: '/test',
      name: 'test',
      component: test
    },
    {
      path: '/loginWxMgr',
      name: 'loginWxMgr',
      component: loginWxMgr
    },
    {
      path: '/newsMgr',
      name: 'newsMgr',
      component: newsMgr
    },
    {
      path: '/talkChatRoomMgr',
      name: 'talkChatRoomMgr',
      component: talkChatRoomMgr
    },
    {
      path: '/textResourcesMgr',
      name: 'textResourcesMgr',
      component: textResourcesMgr
    },
    {
      path: '/imgResourcesMgr',
      name: 'imgResourcesMgr',
      component: imgResourcesMgr
    },
    {
      path: '/addWxMgr',
      name: 'addWxMgr',
      component: addWxMgr
    },
    {
      path: '/addLaQunMgr',
      name: 'addLaQunMgr',
      component: addLaQunMgr
    },
    {
      path: '/jobMgr',
      name: 'jobMgr',
      component: jobMgr
    },
    {
      path: '/getExcel',
      name: 'getExcel',
      component: getExcel
    }
  ]
})
