# Merge Connection Refactoring in Eclipse 4diac

The section shows the application in project iec-61499/CappingStationLarge

| Status                                  | Number of Connections | Number of Block Instances | Affected block Instances by Refactoring                                           | Reconnections required (Required steps for manual resolution) | Mux/Demux Insertions required  (Required steps for manual resolution) | Execution time (OS overhead, etc., not considereed). This time is not exact. | Errors/Inconsistencies |
|-----------------------------------------|-----------------------|---------------------------|------------------------------------------------------------------------------------|------------------------|---------------------------|-----------------------------------------------------------------------------|-----------------------|
| Before Refactoring                      | 51019                 | 25979                     | 4382 (Instances of SkillConfig) + 15337 (Instances of SkillFB)                     |                        |                           |                                                                             | 0                     |
| After Refactoring                       | 45698                 | 28483                     | 4382 (Instances of SkillConfig) + 15337 (Instances of SkillFB)                     |             12740           |            2504               | ~7.32 sec                                                                   | 0                     |
| Refactoring without conflict resolution | 42881                 | 25979                     | 4382 (Instances of SkillConfig) + 15337 (Instances of SkillFB)                     |            3422            |                           | ~6.04 sec                                                                   | 9390                  |


## Merge Connection Refactoring with Conflict Resolution

https://github.com/user-attachments/assets/a1892f40-a638-4ccb-b441-58c322936588

## Merge Connection Refactoring without Conflict Resolution

https://github.com/user-attachments/assets/555d0991-91a9-4e32-a120-bbbd0d2ff387

# Additional Refactoring Operations implemented in Eclipse 4diac

