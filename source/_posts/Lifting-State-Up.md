---
title: Lifting-State-Up
date: 2017-03-10 21:25:41
tags: 
	- React
	- JavaScript
	- state
---

很多情况下，几个组件之间需要共享state。此时就可以利用提升共同state至附组件的方法来处理，参见：[Lifting State Up](https://facebook.github.io/react/docs/lifting-state-up.html)

<!-- more -->

简单而言就是通过在子组件中使用this.props.state代替this.state，将state托管至父组件，进而共享state。其中原来子组件的this.setState要用this.props.setState或者间接的function代替（如下例子中的handleChange），不过其中要注意使用bind(this)方法。

以下是一个具体的例子：

父组件Calculator.jsx

```jsx
import React from 'react'
import TemperatureInput from './TemperatureInput'


const BoilingVerdict = (props) => {
  if (props.celsius >= 100) {
    return <p>The water would boil.</p>
  }
  return <p>The water would not boil.</p>
}

const toCelsius = fahrenheit => (fahrenheit - 32) * 5 / 9

const toFahrenheit = celsius => (celsius * 9 / 5) + 32

const tryConvert = (value, convert) => {
  const input = parseFloat(value)
  if (Number.isNaN(input)) {
    return ''
  }
  const output = convert(input)
  const rounded = Math.round(output * 1000) / 1000
  return rounded.toString()
}

export default class Calculator extends React.Component {
  constructor(props) {
    super(props)
    this.handleCelsiusChange = this.handleCelsiusChange.bind(this)
    this.handleFahrenheitChange = this.handleFahrenheitChange.bind(this)
    this.state = { value: '', scale: 'c' }
  }

  handleCelsiusChange(value) {
    this.setState({ scale: 'c', value })
  }

  handleFahrenheitChange(value) {
    this.setState({ scale: 'f', value })
  }

  render() {
    const scale = this.state.scale
    const value = this.state.value
    const celsius = scale === 'f' ? tryConvert(value, toCelsius) : value
    const fahrenheit = scale === 'c' ? tryConvert(value, toFahrenheit) : value

    return (
      <div>
        <TemperatureInput
          scale="c"
          value={celsius}
          onChange={this.handleCelsiusChange}
        />
        <TemperatureInput
          scale="f"
          value={fahrenheit}
          onChange={this.handleFahrenheitChange}
        />
        <BoilingVerdict
          celsius={parseFloat(celsius)}
        />
      </div>
    )
  }
}

```

子组件TemperatureInput.jsx

```jsx
import React from 'react'

const scaleNames = {
  c: 'Celsius',
  f: 'Fahrenheit'
}

export default class TemperatureInput extends React.Component {

  constructor(props) {
    super(props)
    this.handleChange = this.handleChange.bind(this)
  }

  handleChange(e) {
    this.props.onChange(e.target.value)
  }

  render() {
    const value = this.props.value
    const scale = this.props.scale
    return (
      <fieldset>
        <legend>Enter value in {scaleNames[scale]}:</legend>
        <input
          value={value}
          onChange={this.handleChange}
        />
      </fieldset>
    )
  }
}
```


代码可见[Github](https://github.com/juncaixinchi/React-DE/tree/master/src/calculator)