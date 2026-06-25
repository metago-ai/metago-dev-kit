# MetaGO Dev Kit

> 开发者垂直场景增强包 — 让 AI 在编程领域变专业
>
> 第2阶段 Week 4 交付物 · 产品矩阵产品线 A

<p align="center">
  <img src="https://gitee.com/metago/metagolifeform/raw/main/assets/metago-logo.png" alt="MetaGO Logo" width="280" />
</p>

## 这是什么

**MetaGO Dev Kit** 是 [MetaGO Lifeform Kit](https://gitee.com/metago/metagolifeform) 的开发者垂直增强包，在 22 个核心能力之上叠加 **4 个开发专用技能**，让 AI 助手在编程场景下具备专家级能力。

## 能力清单

### 🔄 复用核心技能（4 个）

来自 `metago-lifeform@>=36.4.3`，开发者场景下高频调用：

| 技能 | 作用 | 开发场景价值 |
|------|------|-------------|
| `metago-decision-lock` | 决策锁定 | 锁定技术选型，防止讨论反复 |
| `metago-critique` | 批判性分析 | 方案评审、设计质疑 |
| `metago-fact-check` | 事实核查 | 验证 API 行为、库版本特性 |
| `metago-problem-trace` | 问题溯源 | Bug 根因分析、故障定位 |

### ➕ 新增开发专用技能（4 个）

Dev Kit 独有，专为编程场景设计：

| 技能 | 作用 | 输出价值 |
|------|------|---------|
| `metago-code-review-deep` | 深度代码审查 | 5 步流程 + 4 级分级（Blocker/Major/Minor/Suggest） |
| `metago-architecture-design` | 架构设计 | 5 步流程 + 7 项原则 + ADR 文档 |
| `metago-refactor-suggest` | 重构建议 | 8 种代码异味 + 4 种复杂度量 |
| `metago-security-audit` | 安全审计 | OWASP Top 10 + CVSS 评分 |

**总计：8 个技能**（4 复用 + 4 新增）

## 安装

### 前置条件

必须先安装 [MetaGO Lifeform Kit](https://gitee.com/metago/metagolifeform) v36.4.3 或更高版本：

```powershell
git clone https://gitee.com/metago/metagolifeform.git
cd metagolifeform
.\scripts\install.ps1 -Platform tre
```

### 安装 Dev Kit

```powershell
git clone https://gitee.com/metago/metago-dev-kit.git
cd metago-dev-kit
.\scripts\install.ps1
```

安装脚本会把 4 个开发专用技能复制到已安装的 MetaGO skills 目录，与核心 22 技能合并为 26 技能。

## 与产品矩阵的关系

```
MetaGO Lifeform Kit (22 核心技能)
    │
    ├── Dev Kit (本包，+4 开发专用技能) ← 你在这里
    ├── Research Kit (规划中)
    ├── PM Kit (规划中)
    └── Writer Kit (规划中)
```

Dev Kit 是产品矩阵**产品线 A（垂直场景包）**的第一个产品，遵循战略规划第2阶段 Week 4 的交付要求。

### 完整产品矩阵

| 产品 | 类型 | 描述 |
|------|------|------|
| [Lifeform Kit](https://gitee.com/metago/metagolifeform) | 核心包 | 22核心+4Dev Kit技能，7平台支持 |
| **Dev Kit**（本产品） | 垂直包 | 开发者增强包（8技能） |
| [MCP Server](https://www.npmjs.com/package/@metago-ai/mcp-server) | 平台工具 | 22 tools + 8 prompts MCP服务 |
| [CLI](https://gitee.com/metago/metago-cli) | 平台工具 | 跨平台命令行工具 |
| [Studio](https://gitee.com/metago/metago-studio) | 平台工具 | 可视化技能编排平台 |
| [Skills SDK](https://gitee.com/metago/skills-sdk) | 生态基础设施 | TypeScript技能开发SDK |
| [Skills Hub](https://gitee.com/metago/skills-hub) | 生态基础设施 | 技能市场 |

## 使用示例

安装后，在 Trae / Claude Code / Cursor 等平台中，AI 会自动识别并调用这些技能：

```
用户：帮我审查这段代码
AI：[自动调用 metago-code-review-deep]
    按 5 步流程执行：语法 → 逻辑 → 性能 → 安全 → 可维护性
    输出分级：1 Major + 2 Minor + 1 Suggest
```

```
用户：这个模块架构怎么设计？
AI：[自动调用 metago-architecture-design]
    按 5 步流程：领域分析 → 模块划分 → 接口设计 → 依赖梳理 → ADR 文档
    输出：7 项原则校验 + ADR 记录
```

## 技术规格

- **格式标准**：每个技能为 `SKILL.md` 文件，YAML frontmatter + Markdown 正文
- **兼容平台**：Trae / Claude Code / Codex / Cursor / CodeBuddy / Qoder / ZCode（7 大平台）
- **依赖**：`metago-lifeform@>=36.4.3`（peerDependency）
- **许可证**：MIT

## 相关链接

- **核心包**：[metago-lifeform](https://gitee.com/metago/metagolifeform)
- **GitHub 镜像**：[metago-ai/metago-dev-kit](https://github.com/metago-ai/metago-dev-kit)
- **官方网站**：https://metago-d6gfw1e4rf2a5bcad-1257074864.tcloudbaseapp.com/
- **战略规划**：[STRATEGY.md](https://gitee.com/metago/metagolifeform/blob/main/docs/STRATEGY.md)
- **执行日志**：[STRATEGY-EXECUTION-LOG.md](https://gitee.com/metago/metagolifeform/blob/main/docs/STRATEGY-EXECUTION-LOG.md)

## 许可证

MIT © MetaGO Lightyear
