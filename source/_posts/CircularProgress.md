---
title: CircularProgress
date: 2017-11-18 22:36:05
tags:
---


A CircularProgress Component
===

一个环进度条组件，主要是利用了两个半圆，旋转不同角度来展现不同的进度

<!-- more -->

```jsx
renderCircularProgress(progress, color, hovered) {
    const p = progress > 1 ? 1 : progress < 0 ? 0 : progress
    const rightDeg = Math.min(45, p * 360 - 135)
    const leftDeg = Math.max(45, p * 360 - 135)
    return (
      <div style={{ width: 56, height: 56, position: 'relative' }}>
        {/* right circular */}
        <div style={{ width: 22, height: 44, marginLeft: 28, marginTop: 6, position: 'absolute', overflow: 'hidden' }}>
          <div
            style={{
              position: 'absolute',
              top: 0,
              right: 0,
              width: 36,
              height: 36,
              transform: `rotate(${rightDeg}deg)`,
              border: '4px solid #C5CAE9',
              borderTop: `4px solid ${color}`,
              borderRight: `4px solid ${color}`,
              borderRadius: '50%'
            }}
          />
        </div>

        {/* left circular */}
        <div style={{ width: 22, height: 44, marginLeft: 6, marginTop: 6, position: 'absolute', overflow: 'hidden' }}>
          <div
            style={{
              position: 'absolute',
              top: 0,
              left: 0,
              width: 36,
              height: 36,
              transform: `rotate(${leftDeg}deg)`,
              border: '4px solid #C5CAE9',
              borderTop: `4px solid ${color}`,
              borderRight: `4px solid ${color}`,
              borderRadius: '50%'
            }}
          />
        </div>

        {/* process and action */}
        <div
          style={{
            position: 'absolute',
            top: 6,
            left: 6,
            width: 36,
            height: 36,
            border: '4px solid transparent',
            fontSize: 12,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            borderRadius: '50%'
          }}
        >
          { `${Math.round(p * 100)}%` }
        </div>
      </div>
    )
  }
```