# VPCエンドポイントを表形式で一覧表示する
param(
    [switch]$help
      )

# 未定義変数を禁止
Set-StrictMode -Version 2.0

# エラーがあった時点で処理終了
$ErrorActionPreference = "stop"

# 主処理
function script:Main() {
    $script_name = Split-Path -Leaf $PSCommandPath
    if($help -eq $true){
        Write-Host "VPCエンドポイントを表形式で表示します"
        Write-Host "$script_name (特にパラメータは不要)"
        
        exit
    }


    $ret_val = (aws ec2 describe-vpc-endpoints | ConvertFrom-Json)

    $vpceps = @()

    $ret_val.VpcEndpoints | ForEach-Object{
        $tmp_hash = @{}

        $tmp_hash.Add('vpcid',$_.VpcId)
        $tmp_hash.Add('servicename', $_.ServiceName)
        $tmp_hash.Add('vpcendpointid', $_.VpcEndpointId)
        $tmp_hash.Add('vpcendpointtype', $_.VpcEndpointType)
        $tmp_hash.Add('state', $_.State)
        $tmp_hash.Add('subnetids', $_.SubnetIds)
        $tmp_hash.Add('routes', $_.RouteTableIds)
        $tmp_hash.Add('sgs', $_.Groups)

        # Key - Valueを、Key1, Key2, Key3...へ縦横変換を実施
        $vpcep_hash = $tmp_hash | %{ New-Object PSCustomObject -Property $_ }
        $vpceps += $vpcep_hash
    }

    # 表形式で表示
    $vpceps | Format-Table -Property vpcid,vpcendpointid,servicename,vpcendpointtype,state,subnetids,routes,sgs
}

Main
