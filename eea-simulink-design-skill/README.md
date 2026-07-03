# eea-simulink-design skill

一个面向电气工程及其自动化毕业设计的 Codex skill，用于辅助 MATLAB/Simulink 仿真建模、参数计算、专业分析和论文写作说明。

## 适用场景

- 电气工程及其自动化本科毕业设计
- MATLAB/Simulink 或 Simscape Electrical 仿真建模
- 电机控制、电力电子、光伏 MPPT、逆变器、电池充电、电力系统故障分析
- 参数计算、仿真工况设计、波形分析、论文技术章节撰写

## 内容结构

```text
skills/
  eea-simulink-design/
    SKILL.md
    agents/openai.yaml
    references/
      domain-knowledge.md
      simulink-workflow.md
      thesis-deliverables.md
      topic-recipes.md
    scripts/
      build_eea_simulink_starter.m
      find_simulink_blocks.m
```

## 安装

将 `skills/eea-simulink-design` 复制到本机 Codex skills 目录：

```powershell
Copy-Item -Path ".\skills\eea-simulink-design" -Destination "$HOME\.codex\skills" -Recurse
```

重新打开 Codex 线程后，可以这样调用：

```text
Use $eea-simulink-design to 搭建一个基于 Simulink 的光伏 MPPT Boost 毕设仿真。
```

## MATLAB 支持

此 skill 设计为配合 MATLAB MCP 使用，推荐环境包括：

- MATLAB
- Simulink
- Simscape
- Simscape Electrical
- Control System Toolbox
- Motor Control Blockset
- Stateflow

没有完整工具箱时仍可用于方案分析、参数计算和论文结构说明，但部分建模脚本或库块搜索可能需要调整。

## 免责声明

本项目是个人整理的 Codex skill，不隶属于 MathWorks、OpenAI 或任何高校。毕业设计内容应结合学校要求、指导教师意见和真实实验/仿真结果进行修改与核验。

## License

MIT License. See [LICENSE](LICENSE).
