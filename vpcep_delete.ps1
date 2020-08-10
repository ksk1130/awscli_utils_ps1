# VPCエンドポイントを削除するコマンドをPowershellでラップしたもの
param(
    [string]$vpc_endpoint_ids                 # vpc-endpoint-ids
   ,[switch]$help
         )

# 未定義変数を禁止
Set-StrictMode -Version 2.0

# エラーがあった時点で処理終了
$ErrorActionPreference = "stop"

# 主処理
function script:Main() {
    $script_name = Split-Path -Leaf $PSCommandPath

    if($help -eq $true){
        Write-Host "指定したパラメータでVPCエンドポイントを削除します"
        Write-Host "$script_name"
        Write-Host " -vpc_endpoint_ids <vpc-endpoint-ids>"
        
        exit
    }

    # 引数チェック
    if([string]::IsNullorEmpty($vpc_endpoint_ids)){
        Write-Host 'VPC-ENDPOINT-IDを指定してください'
        Write-Host "使い方は $script_name -help で確認してください"
        exit
    }

    # 各種パラメータを基にVPCエンドポイントを作成
    aws ec2 delete-vpc-endpoints `
    --vpc-endpoint-ids $vpc_endpoint_ids 

}

Main
