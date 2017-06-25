---
title: React-Develop-Environment
date: 2017-03-19 20:43:19
tags:
    - React
---

# 搭建React开发环境

搭建基于React+webpack+Babel+Eslint的react开发环境

<!-- more -->

## Package

利用npm下载所有所需软件包

	npm install

按照当前项目 node_modules 目录内的安装包情况生成稳定的版本号描述，参考[npm-shrinkwrap](http://tech.meituan.com/npm-shrinkwrap.html)

	npm shrinkwrap

安装的软件包列表，`package.json`

```json
{
  "name": "Test",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "build": "webpack",
    "dev": "webpack-dev-server --hot"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "babel-core": "^6.23.1",
    "babel-eslint": "^7.1.1",
    "babel-loader": "^6.4.0",
    "babel-plugin-transform-decorators-legacy": "^1.3.4",
    "babel-preset-es2015": "^6.22.0",
    "babel-preset-react": "^6.23.0",
    "babel-preset-react-hmre": "^1.1.1",
    "babel-preset-stage-2": "^6.22.0",
    "css-loader": "^0.27.3",
    "debug": "^2.6.3",
    "eslint": "^3.17.1",
    "eslint-config-airbnb": "^14.1.0",
    "eslint-loader": "^1.6.3",
    "eslint-plugin-import": "^2.2.0",
    "eslint-plugin-jsx-a11y": "^4.0.0",
    "eslint-plugin-react": "^6.10.0",
    "html-webpack-plugin": "^2.28.0",
    "node-sass": "^4.5.0",
    "react-tap-event-plugin": "^2.0.1",
    "sass-loader": "^6.0.3",
    "style-loader": "^0.13.2",
    "webpack": "^2.2.1",
    "webpack-dev-server": "^2.4.1"
  },
  "dependencies": {
    "marked": "^0.3.6",
    "material-ui": "^0.17.0",
    "react": "^15.4.2",
    "react-dom": "^15.4.2"
  }
}
```

## Babel

Babel 是一个 JavaScript 转换器，它将 JavaScript 变成 JavaScript（现在是将高版本的 ES6/ES7 转换为 ES5）。

Babel的配置文件，`.babelrc`

```json
{
  "presets": ["react", "es2015", "stage-2"],
  "env": {
    "development": {
      "presets": ["react-hmre"]
    }
  },
  "plugins": ["transform-decorators-legacy"]
}

```
## Webpack

webpack是一个模块打包器，能够把 React 库、JSX 文件和任何其它 JavaScript 的相关部分打包为一个文件。它还能扩展到 CSS（LESS/SASS）文件和应用程序所用的其它类型的素材。其中webpack-dev提供能够热替换的调试工具

Webpack的配置文件,`webpack.config.js`

```js
const path = require('path')
const HtmlwebpackPlugin = require('html-webpack-plugin')

const ROOT_PATH = path.resolve(__dirname)
const BUILD_PATH = path.resolve(ROOT_PATH, 'public')
const APP_PATH = path.resolve(ROOT_PATH, 'src')
module.exports = {
  entry: {
    app: path.resolve(APP_PATH, 'app.jsx')
  },
  output: {
    path: path.resolve(ROOT_PATH, BUILD_PATH),
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        include: [
          path.resolve(ROOT_PATH, 'src')
        ],
        loader: 'babel-loader'
      },
      {
        test: /\.scss$/,
        include: [
          path.resolve(ROOT_PATH, 'src')
        ],
        loaders: ['style-loader', 'css-loader', 'sass-loader']
      }


    ]
  },
  resolve: {
    modules: ['node_modules', path.join(ROOT_PATH, 'src')],
    extensions: ['.js', '.jsx']
  },
  devtool: 'eval-source-map',
  devServer: {
    contentBase: path.join(ROOT_PATH, 'dist'),
    compress: true,
    port: 9000,
    hot: true,
    inline: true
  },


  plugins: [
    new HtmlwebpackPlugin({
      title: 'React Test App'
    })
  ]
}

```

## Eslint

ESLint 是一个插件化的javascript 代码检测工具，它可以用于检查常见的JavaScript 代码错误，也可以进行代码风格检查。这里主要以[airbnb](https://github.com/airbnb/javascript)的指南为准，基本规则见[Eslint Rules](http://eslint.cn/docs/rules/)，React相关规则见[React Rules](https://github.com/JasonBoy/javascript/tree/master/react)

检查file.jsx的代码格式

	eslint file.jsx

检查并修改可自动修正的部分（主要是空格与换行等空白的修复）

	eslint --fix file.jsx

Eslint的配置文件，`.eslintrc`

```json
{
  "extends": "airbnb",
  "parser": "babel-eslint",
  "env": {
    "browser": true,
    "node": true
  },
  "settings": {
    "ecmascript": 6,
    "jsx": true
  },
  "plugins": [
    "react",
    "jsx-a11y",
    "import"
  ],
  "rules": {
    "strict": "warn",
    "quotes": "warn",
    "camelcase": "warn",
    "no-underscore-dangle": "warn",
    "no-undef": "warn",
    "max-len": "warn",
    "no-unused-vars": "warn",
    "no-unused-expressions": "warn",
    "no-shadow": "warn",
    "default-case": "warn",
    "no-confusing-arrow": "warn",
    "no-useless-constructor": "warn",
    "no-nested-ternary": "off",
    "no-mixed-operators": "off",
    "semi": ["warn", "never"],
    "comma-dangle": ["warn", "never"],
    "no-plusplus": ["warn", { "allowForLoopAfterthoughts": true }],
    "import/no-extraneous-dependencies": "warn",
    "import/extensions": ["warn", "never"],
    "react/no-multi-comp": "warn",
    "react/prop-types": "off",
    "react/prefer-stateless-function": ["warn", { "ignorePureComponents": true }]
    }
}
```

Github项目链接：[React-DE](https://github.com/juncaixinchi/React-DE)