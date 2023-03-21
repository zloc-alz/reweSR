$esrgan_model = "RealESRGAN_x4plus_anime_6B"
$alpha_upsampler = "realesrgan"
$ext = "png"
$fp32 = $false
$gpu_id = 0
$t = 1024
# $t = 1280
$s = 2

$input_dir = "input"
$output_dir = "output"

Get-ChildItem -Path $input_dir -Directory | ForEach-Object {
    $input_subdir = $_.Name
    # $output_subdir = "$($input_subdir.Replace('1080', '2160'))"
    $output_subdir = "outputs"
    $input_path = "$($input_dir)\$($input_subdir)"
    $output_path = "$($output_dir)\$($output_subdir)"
    $python_cmd = "python .\inference_realesrgan.py -n $esrgan_model -i $input_path -o $output_path --alpha_upsampler $alpha_upsampler --ext $ext"
    if ($fp32) {
        $python_cmd += " --fp32"
    }
    if ($gpu_id -ne $null) {
        $python_cmd += " --gpu-id $gpu_id"
    }
    $python_cmd += " -t $t -s $s"
    Write-Host "Running command: $python_cmd"
    Invoke-Expression $python_cmd
}
