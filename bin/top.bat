@wmic path win32_perfformatteddata_perfproc_process ^
    where (PercentProcessorTime ^> 50) ^
    get Name, Caption, PercentProcessorTime, IDProcess /format:list
