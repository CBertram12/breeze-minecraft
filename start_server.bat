@echo off
setlocal enabledelayedexpansion
echo "Running script..."
echo.
git pull origin master
echo.
set name=TEST
if exist current_user (
	for %%R in (current_user) do if not %%~zR lss 1 (
		echo The server is currently in use by:
		more current_user
	) else (
		set /P name="Enter ID: "
		echo !name! > current_user
		git add current_user
		git commit -m "!name! started the server"
		git push origin master
		java -Xmx1024M -Xms1024M -jar .\server.jar nogui
		copy NUL current_user
		git add --all
		git commit -m "!name! updated the server"
		git push origin master
	)
) else (
	echo "current_user does not exist"
)
echo.
pause