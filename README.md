# 5stage-pipeline-architecture
Design and Implementation of 5 stage pipeline architecture using verilog

A 5 stage pipeline architecture consists of Fetch, Decode, Execute, Memory and Write-Back stages. As the number of stages increases,
throughput increases. The verilog code for each of these stages and their internal sub-modules are included as .v files. Inorder to overcome
the dependencies resulting into hazards, we have included a Hazard Detection Unit (To stall) and a Forwarding Unit (To forward) the data. 
The code was made in reference to Computer Organization and Design by Hennessy and Patterson.   
