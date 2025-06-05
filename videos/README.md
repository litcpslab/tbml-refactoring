# Merge Connection Refactoring in Eclipse 4diac
The following videos demonstrate the merge connection refactoring feature.
**Please turn on sound for explanation**
## Merge Connection Refactoring with Conflict Resolution

https://github.com/user-attachments/assets/a1892f40-a638-4ccb-b441-58c322936588

## Merge Connection Refactoring without Conflict Resolution

https://github.com/user-attachments/assets/555d0991-91a9-4e32-a120-bbbd0d2ff387


This table shows the quantification of an example oriented on a real-world plant manufacturing system.
The initial application was scaled up from 91 block instances to 28483 to demonstrate functionality on larger systems too.

| Status                                  | Number of Connections | Number of Block Instances | Affected block Instances by Refactoring                                           | Reconnections required (Required steps for manual resolution) | Mux/Demux Insertions required  (Required steps for manual resolution) | Execution time (OS overhead, etc., not considereed). This time is not exact. | Errors/Inconsistencies |
|-----------------------------------------|-----------------------|---------------------------|------------------------------------------------------------------------------------|------------------------|---------------------------|-----------------------------------------------------------------------------|-----------------------|
| Before Refactoring     https://github.com/litcpslab/tbml-refactoring/tree/main/iec-61499/CappingStationLarge     | 51019                 | 25979                     | 4382 (Instances of SkillConfig) + 15337 (Instances of SkillFB)                     |                        |                           |                                                                             | 0                     |
| After Refactoring      https://github.com/litcpslab/tbml-refactoring/tree/main/iec-61499/CappingStationLargeAfterRefactoring                 | 45698                 | 28483                     | 4382 (Instances of SkillConfig) + 15337 (Instances of SkillFB)                     |             12740           |            2504               | ~7.32 sec                                                                   | 0                     |
| Refactoring without conflict resolution  https://github.com/litcpslab/tbml-refactoring/tree/main/iec-61499/CappingStationLargeNoRepair| 42881                 | 25979                     | 4382 (Instances of SkillConfig) + 15337 (Instances of SkillFB)                     |            3422            |                           | ~6.04 sec                                                                   | 9390                  |




# Additional Refactoring Operations implemented in Eclipse 4diac

## Moving Block through Hierachy

https://github.com/user-attachments/assets/519f5544-cc95-4b31-aa31-9a5693c88078

## Rename Function Block Type and Rename Interface Pin

https://github.com/user-attachments/assets/04556ef6-e9ac-42f7-8da4-2878865368e5

## Safe Deletion of a DataType

https://github.com/user-attachments/assets/ec499dc8-76b7-4dec-a55b-b749a7c06233

## Additional Features of Eclipse 4diac (without video)
* Moving types to different packages
* Safely deleting Function Block type
* Renaming member of Structured Data Type
* Updating initial value of Structured Data Type
* Replacing pin with Structured Type
* Creating new hierarchical element from existing network
* Removing hierachy level
* Extracting adapter
* Translating model fragments to types


