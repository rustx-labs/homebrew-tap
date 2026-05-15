<p align="center">
  <a href="https://github.com/rustx-labs/homebrew-tap/actions/workflows/publish.yml">
    <img src="https://github.com/rustx-labs/homebrew-tap/actions/workflows/publish.yml/badge.svg" alt="CI 状态">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="许可证">
  </a>
  <a href="https://github.com/rustx-labs/homebrew-tap/stargazers">
    <img src="https://img.shields.io/github/stars/rustx-labs/homebrew-tap?style=social" alt="GitHub Stars">
  </a>
  <a href="https://github.com/rustx-labs/homebrew-tap/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/rustx-labs/homebrew-tap" alt="贡献者">
  </a>
  <a href="https://github.com/rustx-labs/homebrew-tap/commits/main">
    <img src="https://img.shields.io/github/last-commit/rustx-labs/homebrew-tap" alt="最后提交">
  </a>
  <a href="https://github.com/rustx-labs/homebrew-tap">
    <img src="https://img.shields.io/github/repo-size/rustx-labs/homebrew-tap" alt="仓库大小">
  </a>
</p>

<p align="center">
  <a href="README.md">🇺🇸 English</a>
</p>

<h1 align="center">RustX Labs Homebrew Tap</h1>

<p align="center">
  <b>RustX Labs macOS 应用与开发者工具的一站式 Homebrew 源。</b><br>
  一条 <code>brew</code> 命令，即可安装、升级、管理全部软件。
</p>

---

## 这是什么？

本仓库是由 **RustX Labs** 维护的官方 [Homebrew Tap](https://docs.brew.sh/Taps)。我们将 macOS 桌面应用和 CLI 工具打包为 Homebrew Cask，让你无需手动下载、拖拽安装，一条命令轻松搞定，升级也毫无负担。

## 快速开始

一次性添加本 Tap：

```bash
brew tap rustx-labs/tap
```

随后即可随时安装任意应用：

```bash
brew install --cask eye-sentry
brew install --cask apifire
brew install --cask sky-monitor
brew install --cask novadb
```

## 可用 Cask

<table>
<tr>
<td width="50%" valign="top">

### Eye Sentry

你的个人 macOS 护眼助手。智能提醒、专注计时与休息提示，助你养成健康的屏幕使用习惯。

- **安装**：`brew install --cask eye-sentry`
- **安装位置**：`/Applications/eye-sentry.app`
- **适合人群**：长时间面对屏幕、希望保护视力的用户

</td>
<td width="50%" valign="top">

### ApiFire

专为 API 测试与开发者工作流打造的极速 CLI 工具包。直接在终端中构建、调试和自动化 HTTP 请求。

- **安装**：`brew install --cask apifire`
- **安装位置**：`apifire` 命令行可执行文件
- **适合人群**：后端开发者、QA 工程师以及习惯终端操作的 DevOps 专家

</td>
</tr>
<tr>
<td width="50%" valign="top">

### Sky Monitor

轻量级 macOS 菜单栏系统监控工具。常驻托盘区，一眼即可查看实时 CPU、内存、磁盘、温度和网络指标，点击打开详细下拉面板。

- **安装**：`brew install --cask sky-monitor`
- **安装位置**：`/Applications/sky-monitor.app`
- **适合人群**：高级用户和开发者，希望在菜单栏中即时查看系统性能

</td>
<td width="50%" valign="top">

### NovaDB

下一代 AI 原生数据库客户端。NovaDB 将智能助手与现代界面相结合，让你使用自然语言即可查询、可视化和管理数据。

- **安装**：`brew install --cask novadb`
- **安装位置**：`/Applications/NovaDB.app`
- **适合人群**：希望为数据库配备 AI  copilot 的开发者和数据分析师

</td>
</tr>
</table>

## 升级

更新 Tap 并升级所有已安装的 Cask：

```bash
brew update
brew upgrade --cask
```

或单独升级某个应用：

```bash
brew upgrade --cask eye-sentry
```

## Brewfile 示例

配置新 Mac？把以下内容写入你的 `Brewfile`，然后运行 `brew bundle`：

```ruby
tap "rustx-labs/tap"
cask "eye-sentry"
cask "apifire"
cask "sky-monitor"
cask "novadb"
```

## 系统要求

- **macOS**：11 Big Sur 或更高版本
- **架构**：Apple Silicon (ARM64) 或 Intel (x86_64)
- **Homebrew**：4.0 或更高版本（[安装指南](https://docs.brew.sh/Installation)）

## 注意事项

- 如果 `/Applications` 中已存在同名应用，Homebrew 会无缝替换。
- `eye-sentry` 和 `sky-monitor` 会在安装后自动清除 macOS 隔离属性并启动应用。
- `apifire` 安装的是已签名的 CLI 二进制文件，并在安装期间清除隔离属性。
- `novadb` 遵循与其他原生应用相同的安装后流程：清除隔离属性并自动启动。

## 文档

- [Homebrew 官方文档](https://docs.brew.sh)
- `brew help` 和 `man brew`

## 许可证

本项目采用 [Apache License 2.0](LICENSE) 许可。
