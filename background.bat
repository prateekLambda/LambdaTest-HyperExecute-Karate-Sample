echo off
CALL mvn clean test -Dtest=LocalRunner -Dmaven.repo.local=./.m2
CALL curl http://localhost:8080/__admin/stop
CALL netstat -ano | findstr 8080 || ver>nul
CALL CALL npx kill-port 8080
EXIT /b 0