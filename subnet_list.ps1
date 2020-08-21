# VPCサブネットを表形式で一覧表示する
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
        Write-Host "VPCサブネットを表形式で表示します"
        Write-Host "$script_name (特にパラメータは不要)"
        
        exit
    }


    $ret_val = (aws ec2 describe-subnets | ConvertFrom-Json)

    $vpceps = @()

    $ret_val.Subnets | ForEach-Object{
        $tmp_hash = @{}

        $tmp_hash.Add('VpcId',$_.VpcId)
        $tmp_hash.Add('AvailabilityZone', $_.AvailabilityZone)
        $tmp_hash.Add('SubnetId', $_.SubnetId)
        $tmp_hash.Add('CidrBlock', $_.CidrBlock)
        $tmp_hash.Add('AvailabilityZoneId', $_.AvailabilityZoneId)
        $tmp_hash.Add('Tags', $_.Tags)

        # Key - Valueを、Key1, Key2, Key3...へ縦横変換を実施
        $vpcep_hash = $tmp_hash | %{ New-Object PSCustomObject -Property $_ }
        $vpceps += $vpcep_hash
    }

    # 表形式で表示
    $vpceps | Format-Table -Property VpcId,AvailabilityZone,CidrBlock,SubnetId,AvailabilityZoneId,Tags
}

Main
