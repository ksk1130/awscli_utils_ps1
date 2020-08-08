# VPCエンドポイントを削除するコマンドをPowershellでラップしたもの
param(
    [string]$vpc_endpoint_ids                 # vpc-endpoint-ids
      )

# 未定義変数を禁止
Set-StrictMode -Version 2.0

# エラーがあった時点で処理終了
$ErrorActionPreference = "stop"

# 主処理
function script:Main() {
    # 引数チェック
    if([string]::IsNullorEmpty($vpc_endpoint_ids)){
        Write-Host 'VPC-ENDPOINT-IDを指定してください'
        exit
    }

    # 各種パラメータを基にVPCエンドポイントを作成
    aws ec2 delete-vpc-endpoints `
    --vpc-endpoint-ids $vpc_endpoint_ids 

}

Main
