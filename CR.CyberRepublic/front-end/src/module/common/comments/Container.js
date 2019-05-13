import { createContainer } from '@/util'
import Component from './Component'
import CommentService from '@/service/CommentService'
import CouncilService from '@/service/CouncilService'
import { message } from 'antd'
import _ from 'lodash'

export default createContainer(Component, (state) => {
  const commentables = ['task', 'submission', 'team', 'member']

  const props = {
    currentUserId: state.user.current_user_id,
    all_users: _.values(state.council.council_members || []),
    loading: {},
  }

  _.each(commentables, (commentable) => {
    props[commentable] = state[commentable].detail
    props.loading[commentable] = state[commentable].loading
  })

  return props
}, () => {
  const commentService = new CommentService()
  const councilService = new CouncilService()

  return {
    async postComment(type, reduxType, detailReducer, returnUrl, parentId, comment, headline) {
      try {
        const rs = await commentService.postComment(type, reduxType, detailReducer,
          returnUrl, parentId, comment, headline)

        if (rs) {
          message.success('Your comment has been posted.')
        }
      } catch (err) {
        message.error(err.message)
      }
    },

    async listUsers() {
      try {
        return await councilService.getCouncilMembers()
      } catch (err) {
        // console.error(err)
        message.error(err.message)
      }
    },

    async subscribe(type, parentId) {
      try {
        await commentService.subscribe(type, parentId)
      } catch (err) {
        message.error(err.message)
      }
    },

    async unsubscribe(type, parentId) {
      try {
        await commentService.unsubscribe(type, parentId)
      } catch (err) {
        message.error(err.message)
      }
    },
  }
})
