# VPCエンドポイントを作成するコマンドをPowershellでラップしたもの
param(
    [string]$vpc_id                           # vpc-id
   ,[string]$vpc_endpoint_type='Interface'    # vpc-endpoint-type
   ,[string]$service_name                     # service-name
   ,[string]$subnet_id                        # subnet-id
   ,[string]$security_group_id                # security-group-id
      )

# 未定義変数を禁止
Set-StrictMode -Version 2.0

# エラーがあった時点で処理終了
$ErrorActionPreference = "stop"

# 主処理
function script:Main() {
    # 引数チェック
    if([string]::IsNullorEmpty($vpc_id) -Or [string]::IsNullorEmpty($service_name) -Or [string]::IsNullorEmpty($subnet_id) -Or [string]::IsNullorEmpty($security_group_id)){
        Write-Host 'VPC-ID, SERVICE-NAME, SUBNET-ID, SECURITY-GROUP-IDを指定してください'
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
