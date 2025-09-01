# Embedded Systems – Lab Exercises  

This repository contains three lab exercises from the **Embedded Systems** course (NTUA, 9th semester).  
Each exercise focuses on **optimization techniques** for performance, memory, and hardware acceleration.  

---

## ⚡ Exercise 1 – Algorithm Optimization & Design Space Exploration  

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

## 🗂️ Exercise 2 – Dynamic Data Structure Optimization (DDTR)  

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

## 🎬 Exercise 3 – High Level Synthesis (HLS) for FPGA  

Focus: **Accelerating a movie recommendation system (KNN)** using FPGA with **High Level Synthesis (HLS)**.  

- Target platform: **Zynq-7000 ARM/FPGA SoC (Zybo)** with **Xilinx SDSoC 2016.4**.  
- Application: Recommendation System using **MovieLens dataset**, KNN with Euclidean distance.  
- Tasks:  
  - Run baseline HW function, collect resource usage & cycle counts.  
  - Apply **HLS optimizations** (loop pipelining, directives) for speedup.  
  - Use **custom datatypes (`ap_fixed`)** for precision/performance trade-offs.  
  - Refine pipeline design, compare FPGA vs CPU execution, and analyze speedup.  

---

## 📌 Summary  

These exercises provide practical experience in:  
- **Algorithmic optimization** (loops, transformations, DSE).  
- **Memory-aware software design** (dynamic data structures, profiling).  
- **Hardware/software co-design** (HLS, FPGA acceleration).  
