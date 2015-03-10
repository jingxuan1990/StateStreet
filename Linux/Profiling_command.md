#Linux基础知识

#####when I am doing profiling document for one project, I often use those following commands for searching some information.

```bash

find . -name "*.java" -print | xargs grep -i "Runtime.getRuntime" | wc -l
find . -name "*.java" -print | xargs grep -i "System.loadLibary" | wc -l
find . -name "*.properties" -print | wc -l
find . -name "*.sh" -print | xargs du -
find . -name "*.sh" -print | xargs du -sk
find . -name "*.properties" -print | xargs grep -i "email"
find . -name "*.properties" -print | xargs du -sh

```
