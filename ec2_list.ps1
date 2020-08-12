# EC2を表形式で一覧表示する
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
        Write-Host "EC2を表形式で表示します"
        Write-Host "$script_name (特にパラメータは不要)"
        
        exit
    }


    $ret_val = (aws ec2 describe-instances | ConvertFrom-Json)

    $ec2s = @()

    $ret_val.Reservations | ForEach-Object{
        $_.Instances | ForEach-Object{
            $tmp_hash = @{}

            $tmp_hash.Add('PublicDnsName',$_.PublicDnsName)
            $tmp_hash.Add('PrivateDnsName',$_.PrivateDnsName)
            $tmp_hash.Add('VpcId',$_.VpcId)
            $tmp_hash.Add('State',$_.State)
            $tmp_hash.Add('CpuOptions',$_.CpuOptions)
            $tmp_hash.Add('InstanceId',$_.InstanceId)
            $tmp_hash.Add('ImageId',$_.ImageId)
            $tmp_hash.Add('SecurityGroups',$_.SecurityGroups)
            $tmp_hash.Add('SubnetId',$_.SubnetId)
            $tmp_hash.Add('InstanceType',$_.InstanceType)
            $tmp_hash.Add('Architecture',$_.Architecture)
            $tmp_hash.Add('RootDeviceType',$_.RootDeviceType)
            $tmp_hash.Add('Tags',$_.Tags)

            # Key - Valueを、Key1, Key2, Key3...へ縦横変換を実施
            $ec2s_hash = $tmp_hash | %{ New-Object PSCustomObject -Property $_ }
            $ec2s += $ec2s_hash
        }
    }

    # 表形式で表示
    $ec2s | Format-Table -Property InstanceId,State,PublicDnsName,PrivateDnsName,VpcId,CpuOptions,ImageId,SecurityGroups,SubnetId,InstanceType,Architecture,RootDeviceType,Tags
}

Main
