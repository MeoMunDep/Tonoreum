@echo off
title name Bot by @MeoMunDep
color 0A

cd %~dp0

echo Checking configuration files...

if not exist configs.json (
    (
    echo {
    echo   "rotateProxy": false,
    echo   "skipInvalidProxy": true,
    echo   "proxyRotationInterval": 2,
    echo   "delayEachAccount": [1, 1],
    echo   "timeToRestartAllAccounts": 300,
    echo   "howManyAccountsRunInOneTime": 10,
    echo   "doTasks": true,
    echo   "referralCodes": "",
    echo   "howManyTimeToUpgradeLevel": 1,
    echo   "watchAds": true,
    echo   "changeWallet": false
    echo }
    ) > configs.json
    echo Created configs.json
)


(for %%F in (datas.txt wallets.txt proxies.txt) do (
    if not exist %%F (
        type nul > %%F
        echo Created %%F
    )
))

echo Configuration files checked.

echo Checking dependencies...
if exist "..\node_modules" (
    echo Using node_modules from parent directory...
    cd ..
    CALL npm install --no-audit --no-fund --prefer-offline --force  user-agents axios meo-forkcy-colors https-proxy-agent socks-proxy-agent 
    cd %~dp0
) else (
    echo Installing dependencies in current directory...
    CALL npm install --no-audit --no-fund --prefer-offline --force  user-agents axios meo-forkcy-colors https-proxy-agent socks-proxy-agent 
)
echo Dependencies installation completed!

echo Checking for bot updates...
git pull origin main > nul 2>&1
echo Bot updated!

echo Starting the bot...
node meomundep

pause
exit
