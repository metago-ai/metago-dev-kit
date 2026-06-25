<#
.SYNOPSIS
  MetaGO Dev Kit 安装脚本 - 把 4 个开发专用技能安装到已部署的 MetaGO 环境

.DESCRIPTION
  本脚本把 Dev Kit 的 4 个开发专用技能（code-review-deep, architecture-design,
  refactor-suggest, security-audit）复制到已安装 MetaGO Lifeform Kit 的技能目录。
  前置条件：已通过 metago-lifeform 的 install.ps1 完成核心包安装。

.PARAMETER Platform
  指定目标平台（必须与 lifeform 安装时一致）：
    trae | claude-code | codex | cursor | codebuddy | qoder | zcode

.PARAMETER SkillsDir
  直接指定技能目标目录的绝对路径（覆盖 -Platform 参数）

.EXAMPLE
  .\scripts\install.ps1 -Platform trae
  .\scripts\install.ps1 -SkillsDir "C:\Users\you\.trae-cn\skills"

.NOTES
  Dev Kit 不安装核心 22 技能（那些由 metago-lifeform 提供）。
  本脚本只安装 Dev Kit 独有的 4 个开发专用技能。
#>

param(
    [ValidateSet('trae','claude-code','codex','cursor','codebuddy','qoder','zcode')]
    [string]$Platform = 'trae',
    [string]$SkillsDir
)

$ErrorActionPreference = 'Stop'
$script:ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$script:SourceSkillsDir = Join-Path $script:ScriptDir "..\skills"

# Dev Kit 独有的 4 个开发专用技能
$script:DevKitSkills = @(
    'metago-code-review-deep',
    'metago-architecture-design',
    'metago-refactor-suggest',
    'metago-security-audit'
)

function Write-Info($msg) { Write-Host "[Dev Kit] $msg" -ForegroundColor Cyan }
function Write-Ok($msg)   { Write-Host "[OK] $msg" -ForegroundColor Green }
function Write-Warn2($msg){ Write-Host "[!] $msg" -ForegroundColor Yellow }

# 解析目标技能目录
if ($SkillsDir) {
    $script:TargetSkillsDir = $SkillsDir
} else {
    # 与 lifeform install.ps1 的目录映射保持一致
    $platformMap = @{
        'trae'         = @{ Base = '.trae-cn'; Sub = 'skills' }
        'claude-code'  = @{ Base = '.claude'; Sub = 'skills' }
        'codex'        = @{ Base = '.codex'; Sub = 'skills' }
        'cursor'       = @{ Base = '.cursor'; Sub = 'skills' }
        'codebuddy'    = @{ Base = '.codebuddy\rules'; Sub = '' }
        'qoder'        = @{ Base = '.qoder'; Sub = 'skills' }
        'zcode'        = @{ Base = '.zcode'; Sub = 'skills' }
    }
    $cfg = $platformMap[$Platform]
    $baseDir = Join-Path $HOME $cfg.Base
    if ($cfg.Sub) {
        $script:TargetSkillsDir = Join-Path $baseDir $cfg.Sub
    } else {
        $script:TargetSkillsDir = $baseDir
    }
}

Write-Info "MetaGO Dev Kit 安装器 v1.0.0"
Write-Info "目标平台    : $Platform"
Write-Info "技能目标目录: $script:TargetSkillsDir"
Write-Info "源技能目录  : $script:SourceSkillsDir"
Write-Host ""

# 验证源技能目录
if (-not (Test-Path $script:SourceSkillsDir)) {
    throw "源技能目录不存在: $script:SourceSkillsDir（请确认 Dev Kit 仓库完整克隆）"
}

# 检查 lifeform 是否已安装（通过检查目标目录是否存在核心技能）
$lifeformMarker = Join-Path $script:TargetSkillsDir 'metago-critique'
if (-not (Test-Path $lifeformMarker)) {
    Write-Warn2 "未在目标目录检测到 metago-lifeform 核心技能（metago-critique）"
    Write-Warn2 "请先安装 metago-lifeform: https://gitee.com/metago/metagolifeform"
    Write-Warn2 "继续安装 Dev Kit 技能，但建议先完成核心包安装"
    Write-Host ""
}

# 创建目标目录
if (-not (Test-Path $script:TargetSkillsDir)) {
    New-Item -ItemType Directory -Path $script:TargetSkillsDir -Force | Out-Null
    Write-Info "已创建目标目录: $script:TargetSkillsDir"
}

# 安装 4 个开发专用技能
$installed = 0
$failed = 0
foreach ($skill in $script:DevKitSkills) {
    $srcSkillDir = Join-Path $script:SourceSkillsDir $skill
    $dstSkillDir = Join-Path $script:TargetSkillsDir $skill
    $srcFile = Join-Path $srcSkillDir 'SKILL.md'

    if (-not (Test-Path $srcFile)) {
        Write-Warn2 "缺失技能文件: $srcFile"
        $failed++
        continue
    }

    try {
        if (-not (Test-Path $dstSkillDir)) {
            New-Item -ItemType Directory -Path $dstSkillDir -Force | Out-Null
        }
        Copy-Item $srcFile $dstSkillDir -Force
        Write-Ok "已安装 $skill"
        $installed++
    } catch {
        Write-Warn2 "安装失败 $skill : $_"
        $failed++
    }
}

Write-Host ""
Write-Info "安装完成"
Write-Info "成功: $installed / $($script:DevKitSkills.Count)"
if ($failed -gt 0) {
    Write-Warn2 "失败: $failed"
    exit 1
}
Write-Ok "Dev Kit 4 个开发专用技能已就绪"
Write-Host ""
Write-Info "现在你的 MetaGO 环境拥有 26 个技能（22 核心 + 4 Dev Kit）"
Write-Info "在 Trae / Claude Code / Cursor 中即可使用："
Write-Info "  - 深度代码审查（metago-code-review-deep）"
Write-Info "  - 架构设计（metago-architecture-design）"
Write-Info "  - 重构建议（metago-refactor-suggest）"
Write-Info "  - 安全审计（metago-security-audit）"
