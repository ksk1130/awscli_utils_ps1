# awscli_utils_ps1
AWS CLI utilities for Powershell

# これは何
AWS CLIをラップして、個人的によく使うコマンドを使いやすくするためのPowershellスクリプト群です。

# 前提
1. AWS CLIがインストールされていること
2. aws configureが実施されていること
3. Execution Policyが外部スクリプトを実行できるように設定されていること

# 各スクリプトの使い方
    <実行したいスクリプト> -help を実行
    例)
    .\vpcep_list.ps1 -help
