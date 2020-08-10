# VPCエンドポイントを作成するコマンドをPowershellでラップしたもの
param(
    [string]$vpc_id                           # vpc-id
   ,[string]$vpc_endpoint_type='Interface'    # vpc-endpoint-type
   ,[string]$service_name                     # service-name
   ,[string]$subnet_id                        # subnet-id
   ,[string]$security_group_id                # security-group-id
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
        Write-Host "指定したパラメータでVPCエンドポイントを作成します"
        Write-Host "$script_name"
        Write-Host " -vpc_id <vpc-id>"
        Write-Host " -vpc_endpoint_type <vpc-endpoint-type>(デフォルトは'Interface'です。'Gateway'の場合指定してください)"
        Write-Host " -service_name <service-name>"
        Write-Host " -subnet_id <subnet-id>"
        Write-Host " -security_group_id <security-group-id>"
        
        exit
    }

    # 引数チェック
    if([string]::IsNullorEmpty($vpc_id) -Or [string]::IsNullorEmpty($service_name) -Or [string]::IsNullorEmpty($subnet_id) -Or [string]::IsNullorEmpty($security_group_id)){
        Write-Host 'VPC-ID, SERVICE-NAME, SUBNET-ID, SECURITY-GROUP-IDを指定してください'
        Write-Host "使い方は $script_name -help で確認してください"
        exit
    }

    # 各種パラメータを基にVPCエンドポイントを作成
    aws ec2 create-vpc-endpoint `
    --vpc-id $vpc_id `
    --vpc-endpoint-type $vpc_endpoint_type `
    --service-name $service_name `
    --subnet-id $subnet_id `
    --security-group-id $security_group_id

}

Main
