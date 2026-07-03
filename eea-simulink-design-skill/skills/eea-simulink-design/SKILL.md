---
name: eea-simulink-design
description: Guide electrical engineering and automation graduation design work with MATLAB/Simulink simulation building through MATLAB MCP. Use when the user asks for 电气工程及其自动化毕业设计, Simulink or Simscape model construction, motor drives, power electronics, power systems, renewable energy, automatic control, Stateflow or PLC-like logic, simulation validation, parameter calculation, thesis-ready figures, or Chinese graduation design analysis.
---

# Electrical Engineering Graduation Design With Simulink

## Overview

Use this skill to turn an electrical engineering and automation graduation design topic into a defensible MATLAB/Simulink model, simulation plan, result analysis, and thesis-ready explanation. Favor practical, reproducible work: parameter tables, equations, model-building scripts, simulation cases, plots, and validation notes.

## Core Workflow

1. Restate the design topic as a system: object, topology, inputs, outputs, rated values, control targets, disturbance cases, and required deliverables.
2. Load the relevant references:
   - Read `references/domain-knowledge.md` for electrical engineering knowledge, equations, and modeling choices.
   - Read `references/simulink-workflow.md` before creating or debugging MATLAB/Simulink models.
   - Read `references/topic-recipes.md` when the topic matches motor control, converters, inverters, PV, battery charging, power systems, or automation logic.
   - Read `references/thesis-deliverables.md` when preparing Chinese graduation-design text, figures, tables, or chapter structure.
3. Choose model fidelity explicitly: average model, switching model, phasor/RMS model, Simscape physical network, Specialized Power Systems model, transfer-function model, or Stateflow logic.
4. Use MATLAB MCP tools when available:
   - Use `detect_matlab_toolboxes` before relying on Simscape Electrical, Motor Control Blockset, Stateflow, or control toolboxes.
   - Use `evaluate_matlab_code` for library discovery, quick parameter checks, and small simulations.
   - Use `check_matlab_code` on generated `.m` scripts before running substantial builds.
   - Use `run_matlab_file` to execute idempotent build scripts and report the exact outcome.
5. Build models through scripts where possible. Start from `scripts/build_eea_simulink_starter.m` for a simple closed-loop scaffold, and use `scripts/find_simulink_blocks.m` to discover reliable block paths instead of guessing.
6. Run and verify simulations. Do not claim a waveform, performance metric, or model success unless MATLAB/Simulink has actually produced it.
7. Return thesis-ready outputs: assumptions, parameter table, core equations, model architecture, simulation cases, result interpretation, limitations, and next steps.

## Modeling Standards

- Prefer SI units and state every base value, rated value, sampling time, load condition, and solver choice.
- Keep generated models reproducible. Use one main build script, parameter sections at the top, named subsystems, clean signal names, and saved `.slx` outputs.
- Avoid fragile hard-coded Simscape block paths. Discover library paths with MATLAB when possible, especially for Simscape Electrical and Specialized Power Systems.
- Use textbook defaults only when the user omits parameters, and label them clearly as assumptions.
- For undergrad graduation designs, aim for a complete, explainable model before pursuing high-fidelity detail.
- Include validation cases such as startup, step change, load disturbance, fault, parameter variation, steady-state error, overshoot, settling time, ripple, THD, efficiency, or SOC tracking as appropriate.

## Interaction Style

When the request is underspecified, ask at most two targeted questions. If reasonable assumptions are enough, proceed and list them. Use Chinese for explanations by default when the user writes in Chinese, but keep MATLAB code comments concise and readable.

## Example Requests

- "帮我做一个基于 Simulink 的三相逆变器 SPWM 毕设仿真。"
- "用 MATLAB MCP 搭建 PMSM 矢量控制模型并跑阶跃响应。"
- "我的题目是光伏 MPPT 与 Boost 变换器仿真，帮我写参数计算和模型脚本。"
- "检查这个电机调速 Simulink 模型为什么仿真发散。"
