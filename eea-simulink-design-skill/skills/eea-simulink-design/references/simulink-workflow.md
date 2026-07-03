# MATLAB/Simulink 建模工作流

## 使用 MATLAB MCP

1. 先调用 `detect_matlab_toolboxes`，确认 MATLAB、Simulink、Simscape Electrical、Control System Toolbox、Motor Control Blockset、Stateflow、Simulink Test 是否可用。
2. 用 `evaluate_matlab_code` 做轻量检查，例如计算参数、搜索库块、试运行小片段。
3. 对生成的 `.m` 建模脚本调用 `check_matlab_code`，修正 MATLAB Code Analyzer 发现的问题。
4. 用 `run_matlab_file` 执行脚本，读取命令窗口输出，再确认模型文件和仿真结果是否生成。

## 推荐建模流程

1. 创建一个项目文件夹，区分 `models/`、`scripts/`、`results/`、`figures/`。
2. 写一个主构建脚本，例如 `buildBuckClosedLoop.m`。脚本应可重复运行，重复运行时覆盖旧模型或安全关闭旧模型。
3. 在脚本开头定义参数：额定功率、电压、电流、频率、采样周期、控制器参数、负载参数和仿真时间。
4. 使用 `new_system`、`add_block`、`set_param`、`add_line` 创建模型。
5. 将功率级、控制器、测量与显示分成命名子系统。
6. 设置求解器和停止时间。连续系统常用 `ode23tb`、`ode15s` 或 `ode45`，离散控制常用固定步长。
7. 启用信号记录或 `To Workspace`，保存关键波形。
8. 运行 `sim`，生成图像和指标表。

## 库块发现

不要凭记忆硬写复杂库路径。优先用 MATLAB 搜索：

```matlab
load_system('simulink');
find_system('simulink', 'SearchDepth', 3, 'Name', 'Step')
```

对 Specialized Power Systems 可尝试：

```matlab
load_system('powerlib');
find_system('powerlib', 'LookUnderMasks', 'all', 'FollowLinks', 'on', ...
    'RegExp', 'on', 'Name', '.*IGBT.*')
```

对 Simscape Electrical 可尝试加载 `ee_lib`，若失败则用 `ver` 和 `which` 先确认库名。可以使用 `scripts/find_simulink_blocks.m` 按关键词搜索常用库。

## 常用 API 模式

```matlab
model = 'demo_model';
if bdIsLoaded(model)
    close_system(model, 0);
end
new_system(model);
open_system(model);

set_param(model, 'StopTime', '5', 'Solver', 'ode45');
add_block('simulink/Sources/Step', [model '/Reference']);
add_block('simulink/Math Operations/Gain', [model '/Gain'], 'Gain', '2');
add_line(model, 'Reference/1', 'Gain/1', 'autorouting', 'on');
save_system(model);
```

## Simscape 与电力系统注意事项

- Simscape 物理网络通常需要 Solver Configuration 和 Electrical Reference。
- Specialized Power Systems 网络通常需要 `powergui`。
- 开关电力电子模型容易刚性强，必要时降低开关频率、缩短仿真时间、使用离散 powergui 或调整求解器。
- 同一个模型里混合 Simscape 物理域和普通 Simulink 信号时，注意传感器、受控源和转换块。
- 当模型发散时，先检查初值、单位、极性、反馈符号、饱和、采样时间、求解器和过大的控制增益。

## 验证清单

- 模型能从空目录一键构建。
- 关键参数在脚本顶部可见。
- 每条曲线的物理意义、单位和预期趋势明确。
- 至少包含一个稳态场景和一个扰动场景。
- 仿真结果与理论公式或工程常识一致。
- 若使用假设参数，说明假设来源和对结果的影响。
