# Technical Note: Partial Configuration Scripts

> **Notice:** The scripts included in this repository (e.g., `DUS_router_CONFIGURE.sh`, `FRA_router_CONFIGURE.sh`) represent a **partial subset** of the complete Autonomous System configuration. 

These files are provided for demonstration purposes to showcase:
* **Automation:** The use of Bash scripting to provision FRRouting (FRR) nodes.
* **Policy Logic:** Representative examples of BGP Route-Maps and OSPF weight configurations.
* **Role-Based Design:** Configuration patterns for specific network roles, such as IXP Peering at FRA or Transit at DUS.

The full project environment consists of 8 interconnected routers and an Open vSwitch Layer-2, which were managed as part of the University of Kassel "Mini-Internet" project.

![AS-Level Topology of the Mini-Internet](topology.png){width=80%}

[cite_start]**Note on Configuration:** The scripts provided (DUS, FRA, etc.) are partial samples of the full 8-router topology shown above[cite: 63, 259].
