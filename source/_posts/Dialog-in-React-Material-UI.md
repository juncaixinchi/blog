---
title: Dialog in React Material-UI
date: 2017-04-09 11:39:47
tags:
    - React
    - Dialog
---


## 解析Material-UI中的Dialog组件

* dialog是常见组件，前段时间研究了一下[Material-UI]()的Dialog组件的代码

## 自己写的dialog

```jsx
import React, { PropTypes } from 'react'
import EventListener from 'react-event-listener'
import keycode from 'keycode'
import { TweenMax } from 'gsap'
import { Paper } from 'material-ui'
import ReactTransitionGroup from 'react-addons-transition-group'

class TransitionItem extends React.Component {

  static propTypes = {
    modal: PropTypes.bool,
    onRequestClose: PropTypes.func
  }

  static defaultProps = {
    modal: false,
    onRequestClose: null
  }

  constructor(props) {
    super(props)

    this.requestClose = (buttonClicked) => {
      if (!buttonClicked && this.props.modal) return
      if (this.props.onRequestClose) {
        this.props.onRequestClose(!!buttonClicked)
      }
    }
    this.handleTouchTapOverlay = () => {
      this.requestClose(false)
    }

    this.handleKeyUp = (event) => {
      switch (keycode(event)) {
        case 'esc': return this.requestClose(false)
        default: return 0
      }
    }
    this.animation = (status) => {
      const transformItem = document.getElementById('transformItem')
      const overlay = document.getElementById('overlay')
      const time = 0.45
      const ease = Power4.easeOut

      if (status === 'In') {
        TweenMax.from(overlay, time, { opacity: 0, ease })
        TweenMax.from(transformItem, time, { top: '-64', opacity: 0, ease })
      }

      if (status === 'Out') {
        TweenMax.to(transformItem, time, { top: '-64', opacity: 0, ease })
        TweenMax.to(overlay, time, { opacity: 0, ease })
      }
    }
  }

  componentWillUnmount() {
    clearTimeout(this.enterTimeout)
    clearTimeout(this.leaveTimeout)
  }

  componentWillEnter(callback) {
    this.componentWillAppear(callback)
  }

  componentWillAppear(callback) {
    this.animation('In')
    this.enterTimeout = setTimeout(callback, 450) // matches transition duration
  }

  componentWillLeave(callback) {
    this.animation('Out')
    this.leaveTimeout = setTimeout(callback, 450) // matches transition duration
  }

  render() {
    return (
      <div
        style={{
          position: 'fixed',
          width: '100%',
          height: '100%',
          top: 0,
          left: 0,
          zIndex: 1500,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          transition: 'all 0ms cubic-bezier(0.23, 1, 0.32, 1)'
        }}
      >
        <div
          id="transformItem"
          style={{
            position: 'relative',
            zIndex: 1500,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center'
          }}
        >
          <EventListener target="window" onKeyUp={this.handleKeyUp} />
          <Paper zDepth={4}>
            {this.props.children}
          </Paper>
        </div>
        <div
          id="overlay"
          style={{
            position: 'fixed',
            height: '100%',
            width: '100%',
            top: 0,
            left: 0,
            backgroundColor: 'rgba(0, 0, 0, 0.541176)',
            zIndex: 1400
          }}
          onTouchTap={this.handleTouchTapOverlay}
        />
      </div>
    )
  }
}

export default class CDialog extends React.Component {

  static propTypes = {
    open: PropTypes.bool.isRequired
  }

  render() {
    return (
      <ReactTransitionGroup>
        {this.props.open && <TransitionItem {...this.props} />}
      </ReactTransitionGroup>
    )
  }
}
```

* 使用ReactTransitionGroup来处理动画，主要是组件进入和退出的动画

* 使用`display: 'flex', alignItems: 'center', justifyContent: 'center'`实现居中

* 基本结构：

	* root: 根div，一个撑满页面的容器，包含transformItem和overlay

	* transformItem：居中显示的包含内容的对话框窗口

	* overlay: dialog后面灰度背景遮罩