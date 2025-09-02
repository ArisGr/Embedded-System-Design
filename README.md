# Embedded Systems – Lab Exercises  

This repository contains six lab exercises from the **Embedded Systems** course (NTUA, 9th semester).  
Each exercise focuses on **optimization techniques**, **low-level programming**, and **hardware/software co-design**.  

---

## Exercise 1 – Algorithm Optimization & Design Space Exploration  

Focus: **Optimizing the PHODS motion estimation algorithm** for energy efficiency and execution speed.  

- Study the **PHODS (Parallel Hierarchical One Dimensional Search)** motion estimation algorithm.  
- Measure execution time with hardware counters, analyze average/min/max cycles.  
- Apply **loop optimizations** and record improvements.  
- Perform **Design Space Exploration (DSE)**:  
  - Optimize block sizes (square & rectangular).  
  - Run exhaustive searches, compare execution times.  
  - Visualize results with boxplots.  
- Compare performance gains before and after optimization.  

---

## Exercise 2 – Dynamic Data Structure Optimization (DDTR)  

Focus: **Optimizing memory usage and access patterns** in two applications using **Dynamic Data Type Refinement (DDTR)**.  

- Tools: **DDTR library**, **Valgrind Massif (memory footprint)**, **Valgrind Lackey (memory accesses)**.  
- **Deficit Round Robin (DRR)**:  
  - Test all **9 combinations** of Node/Packet data structures (SLL, DLL, Dynamic Array).  
  - Record memory accesses & footprint.  
  - Identify the most efficient structure.  
- **Dijkstra’s Algorithm**:  
  - Apply DDTR to optimize shortest-path implementation on a 100×100 graph.  
  - Compare SLL, DLL, Dynamic Array.  
  - Select structures with minimal memory accesses & footprint.  

---

## Exercise 3 – High Level Synthesis (HLS) for FPGA  

Focus: **Accelerating a movie recommendation system (KNN)** using FPGA with **High Level Synthesis (HLS)**.  

- Target platform: **Zynq-7000 ARM/FPGA SoC (Zybo)** with **Xilinx SDSoC 2016.4**.  
- Application: Recommendation System using **MovieLens dataset**, KNN with Euclidean distance.  
- Tasks:  
  - Run baseline HW function, collect resource usage & cycle counts.  
  - Apply **HLS optimizations** (loop pipelining, directives) for speedup.  
  - Use **custom datatypes (`ap_fixed`)** for precision/performance trade-offs.  
  - Refine pipeline design, compare FPGA vs CPU execution, and analyze speedup.  

---

## Exercise 4 – High Level Synthesis with GANs on FPGA  

Focus: **Accelerating neural network inference (GAN generator)** using **High Level Synthesis (HLS)** on the **Xilinx Zybo FPGA**.  

- Application: **Image reconstruction** with a GAN model on **MNIST digits** (reconstructing missing halves of digits).  
- Tasks:  
  - Implement `forward_propagation` as a hardware function.  
  - Measure **resources, latency, and execution cycles**.  
  - Apply **HLS optimizations** (loop pipelining, pragmas) and compare FPGA vs CPU runs.  
  - Reconstruct images with **different bit-width precisions**.  
  - Evaluate results with **Max Pixel Error** and **PSNR**, analyzing speed vs quality trade-offs.  

---

## Exercise 5 – ARM Assembly Programming  

Focus: **Hands-on programming in ARM assembly**, covering string manipulation, I/O handling, serial communication, and C integration.  

- **String Transformation**  
  - Input a string, transform characters (uppercase ↔ lowercase, digit shifts).  
  - Continuous execution until "Q/q".  
- **Serial Communication**  
  - Simulate host–guest communication with **QEMU pseudoterminals**.  
  - Host (C) sends string, Guest (ARM assembly) returns most frequent character.  
- **C & Assembly Integration**  
  - Replace standard C string functions (`strlen`, `strcpy`, `strcat`, `strcmp`) with custom ARM assembly.  
  - Link with a C program and validate results.  

---

## Exercise 6 – Cross-Compiling & Kernel Development for ARM  

Focus: **Cross-compiling programs and building a custom Linux kernel** for ARM on QEMU, using both custom and precompiled toolchains.  

- **Setup & Toolchains**  
  - Create a new **QEMU ARM VM**.  
  - Install and configure **crosstool-ng** (custom toolchain).  
  - Use a **precompiled Linaro toolchain** as an alternative.  

- **Cross-Compiling Programs**  
  - Compare **armhf vs armel** images.  
  - Cross-compile `phods.c` with both toolchains.  
  - Analyze executables (`file`, `readelf`) and compare sizes (dynamic vs static linking).  
  - Extend **glibc** with a custom function, rebuild toolchain, and test execution.  

- **Kernel Development**  
  - Download and configure **Linux kernel source for ARM**.  
  - Cross-compile kernel and generate `.deb` packages.  
  - Install kernel in QEMU and boot with new image.  
  - Add a **custom system call** (`printk` greeting) and test it with a C program.  

---

## 📌 Summary  

These exercises provide practical experience in:  
- **Algorithmic optimization** (loops, transformations, DSE).  
- **Memory-aware software design** (dynamic data structures, profiling).  
- **Hardware/software co-design** (HLS, FPGA acceleration).  
- **Low-level programming** (ARM assembly, system-level debugging).  
- **Cross-compilation & OS development** (toolchains, kernel customization, syscalls).  
