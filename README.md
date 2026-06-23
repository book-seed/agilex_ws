# agilex_ws

基于松灵 (AgileX) 系列机械臂的运动控制仿真及真机控制。

## 目录结构

```
agilex_ws/
├── deps/           # 外部依赖（Git Submodule）
├── src/            # 源码目录（通过 pkglink.sh 链接 deps 中的包）
├── pkglink.sh      # 创建 deps → src 符号链接的脚本
├── .gitmodules     # Git Submodule 配置
└── .gitignore      # Git 忽略规则
```

## 环境要求

- Ubuntu 22.04
- ROS 2 Humble
- [colcon](https://colcon.readthedocs.io/) 构建工具
- Git

## 快速开始

### 1. 克隆仓库

```bash
git clone --recurse-submodules git@github.com:book-seed/agilex_ws.git
cd agilex_ws
```

> 如果已经克隆但未拉取 submodule，请执行：
> ```bash
> git submodule update --init --recursive
> ```

### 2. 链接依赖包

```bash
bash pkglink.sh
```

该脚本会将 `deps/` 中的依赖包通过符号链接映射到 `src/` 目录，使 colcon 能够发现并构建它们。

### 3. 构建工作空间

**首次构建（全量）：**

```bash
colcon build --symlink-install
```

**增量构建（极速调试，推荐）：**

在实际开发中，为了极速调试，推荐以下组合：

```bash
colcon build --symlink-install --packages-select <你的包名>
```

仅构建你正在修改的那个包，配合软链接，速度极快。

如果加上 `--event-handlers console_direct+`，还可以在终端实时看到编译报错信息，省去翻日志的麻烦：

```bash
colcon build --symlink-install --packages-select <你的包名> --event-handlers console_direct+
```

### 4. 配置环境

```bash
source install/setup.bash
```

## 添加新的 Submodule

```bash
# 添加外部依赖
git submodule add <repo-url> deps/<package-name>

# 更新 .gitmodules 并提交
git add .gitmodules deps/<package-name>
git commit -m "Add submodule: <package-name>"

# 重新链接依赖
bash pkglink.sh
```

## License

本项目基于 [Apache License 2.0](LICENSE) 开源。